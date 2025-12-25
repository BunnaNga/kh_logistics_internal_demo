package com.example.kh_logistics_internal_demo;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.Manifest;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.os.Build;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.example.kh_logistics_internal_demo.km_mode.KmCreate;
import com.example.kh_logistics_internal_demo.km_mode.Send;
import com.example.kh_logistics_internal_demo.km_mode.UseCase;
import com.hztytech.printer.sdk.km_blebluetooth.KmBlebluetooth;
import com.hztytech.printer.sdk.km_bluetooth.Kmbluetooth;
import com.hztytech.printer.sdk.km_bluetooth.KmbluetoothAdapter;
import com.hztytech.printer.sdk.km_usb.KmUsb;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL =
            "com.example.kh_logistics_internal_demo/bluetooth";

    // Define our own TAG for logging
    private static final String TAG = "Bluetooth";


    private List<BluetoothDevice> blueDevices = new ArrayList<>(); // store paired devices

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        //经典蓝牙
        Kmbluetooth.getInstance().openBluetoothAdapter(this);
        //低功耗蓝牙
        KmBlebluetooth.getInstance().openBluetoothAdapter(this);
        KmUsb.getInstance().openUsb(this);

        new MethodChannel(
                flutterEngine.getDartExecutor().getBinaryMessenger(),
                CHANNEL
        ).setMethodCallHandler((call, result) -> {

            if ("getBluetoothDevices".equals(call.method)) {
                getBluetoothDevices(result);
            } else if ("selectBluetoothDevice".equals(call.method)) {
                // Get index from Flutter
                Integer index = call.argument("index");
                if (index != null && index >= 0 && index < blueDevices.size()) {
                   // BluetoothDevice selectedDevice = blueDevices.get(index);
                    Log.d(TAG, "configureFlutterEngine:"+blueDevices.get(index));
                    Kmbluetooth.getInstance().getConnectDeviceOnly(blueDevices.get(index), new KmbluetoothAdapter(){
                        @Override
                        public void connectSuccess() {
                            KmCreate.getInstance().connectType = 1;
                            KmCreate.getInstance().connectName = blueDevices.get(index).getName();
                            System.out.println("连接成功");
                            Log.d(TAG, "successed dddddddd");
                            result.success("1");
                        }

                        @Override
                        public void connectFailed(String reason) {
                            result.success("0");
                            Log.e(TAG, "connectFailed: Bluetooth connection failed. Reason = " + reason);
                        }
                    });

                } else {

                    Log.d(TAG, "Invalid index received from Flutter: " + index);
                }

            }else if (call.method.equals("sendImageReceipt")) {
                byte[] bitmapBytes = call.argument("receipt");
                if (bitmapBytes != null) {
                    Bitmap bmp = BitmapFactory.decodeByteArray(bitmapBytes, 0, bitmapBytes.length);

                    // Send directly to printer
                    Send.writeData(UseCase.tspl_case2(MainActivity.this, bmp), MainActivity.this);

                    result.success(bitmapBytes);
                } else {
                    result.error("NULL_BITMAP", "Bitmap is null", null);
                }
            }else if (call.method.equals("sendImageQrcode")) {
                // Get list of byte arrays
                List<byte[]> bitmapBytesList = call.argument("qrCode");

                if (bitmapBytesList != null && !bitmapBytesList.isEmpty()) {
                    for (byte[] bitmapBytes : bitmapBytesList) {
                        // Decode each byte array into a Bitmap
                        Bitmap bmp = BitmapFactory.decodeByteArray(bitmapBytes, 0, bitmapBytes.length);

                        if (bmp != null) {
                            // Send each bitmap to printer
                            Send.writeData(UseCase.tspl_case2(MainActivity.this, bmp), MainActivity.this);
                        }
                    }

                    // Return success to Flutter
                    result.success(true);
                } else {
                    result.error("NULL_BITMAP", "Bitmap list is null or empty", null);
                }
            }
            else {
                result.notImplemented();
            }
        });
    }

    private void getBluetoothDevices(MethodChannel.Result result) {
        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();

        if (bluetoothAdapter == null) {
            result.error("UNAVAILABLE", "Bluetooth not supported", null);
            return;
        }

        if (!bluetoothAdapter.isEnabled()) {
            result.error("DISABLED", "Bluetooth is disabled", null);
            return;
        }

        // Android 12+ permission check
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (ActivityCompat.checkSelfPermission(
                    this,
                    Manifest.permission.BLUETOOTH_CONNECT
            ) != PackageManager.PERMISSION_GRANTED) {
                result.error(
                        "PERMISSION_DENIED",
                        "BLUETOOTH_CONNECT permission not granted",
                        null
                );
                return;
            }
        }

        Set<BluetoothDevice> pairedDevices = bluetoothAdapter.getBondedDevices();
        List<String> deviceList = new ArrayList<>();
        blueDevices.clear(); // store devices for later use
        if (pairedDevices != null) {
            for (BluetoothDevice device : pairedDevices) {
//                Map<String, String> map = new HashMap<>();
//                map.put("name", device.getName());
//                map.put("address", device.getAddress());
//                deviceList.add(map);
                deviceList.add(device.getName());

                blueDevices.add(device); // save device to list
            }
        }

        result.success(deviceList);
    }
    public Bitmap loadBitmapFromView(View v) {
        DisplayMetrics dm = getResources().getDisplayMetrics();
        v.measure(View.MeasureSpec.makeMeasureSpec(dm.widthPixels,
                        View.MeasureSpec.EXACTLY),
                View.MeasureSpec.makeMeasureSpec(dm.heightPixels,
                        View.MeasureSpec.EXACTLY));
        v.layout(0, 0, v.getMeasuredWidth(), v.getMeasuredHeight());
        Bitmap returnedBitmap =
                Bitmap.createBitmap(v.getMeasuredWidth(),
                        v.getMeasuredHeight(), Bitmap.Config.ARGB_8888);
        Canvas c = new Canvas(returnedBitmap);
        v.draw(c);

        return returnedBitmap;
    }


}
