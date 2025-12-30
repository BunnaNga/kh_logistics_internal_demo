import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  List<String> bluetoothDevices = [];
  static const platform =
      MethodChannel('com.example.kh_logistics_internal_demo/bluetooth');
  bool? isOpen;
  String? bluetoothConnection;
  // Future<void> getBluetoothList() async {
  //   try {
  //     List<String> result = await platform.invokeMethod('getBluetoothDevices');

  //     setState(() {
  //       bluetoothDevices = result;
  //     });
  //   } on PlatformException catch (e) {
  //     log("Failed to get bluetooth list: ${e.message}");
  //   }
  // }
  Future<void> getBluetoothList() async {
    try {
      final result = await platform.invokeMethod('getBluetoothDevices');

      // Convert the dynamic list to List<String>
      List<String> devices = (result as List).map((e) => e.toString()).toList();

      setState(() {
        bluetoothDevices = devices;
      });
    } on PlatformException catch (e) {
      log("Failed to get bluetooth list: ${e.message}");
    }
  }

  Future<void> sendSelectedDeviceIndex(int index) async {
    showLoadingDialog();
    try {
      bluetoothConnection =
          await platform.invokeMethod('selectBluetoothDevice', {
        'index': index,
      });
      hideLoadingDialog();
      // if (bluetoothConnection != null && bluetoothConnection == '1') {
      //   Navigator.pop(context,);
      // } else {
      //   Navigator.pop(context);
      // }
      Navigator.pop(context, '1');

      setState(() {});
    } on PlatformException catch (e) {
      log("Failed to send device index: ${e.message}");
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // user cannot close it
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Connecting..."),
            ],
          ),
        );
      },
    );
  }

  void hideLoadingDialog() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void getDevice() async {
    await getBluetoothList();
  }

  // for ios device
  Future<void> openBluetoothAdapter() async {
    try {
      await platform.invokeMethod('openBluetoothAdapter');
    } on PlatformException catch (e) {
      log("Failed to get bluetooth list: ${e.message}");
    }
  }

  void checkBlue() async {
    while (isOpen == true) {
      await getBluetoothList();
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  @override
  void initState() {
    // bluetoothDevices.clear(); // clear old devices
    isOpen = true;
    if (Platform.isIOS) {
      openBluetoothAdapter();
      checkBlue();
    } else if (Platform.isAndroid) {
      getDevice();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    isOpen = false; // stop the iOS scanning loop when screen is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColors,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.whiteTextColor,
            )),
        title: Text(
          "select_bluetooth".tr,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.whiteTextColor),
        ),
      ),
      body: Expanded(
        child: bluetoothDevices.isEmpty
            ? const Center(child: Text('No devices found'))
            : ListView.builder(
                itemCount: bluetoothDevices.length,
                itemBuilder: (context, index) {
                  final device = bluetoothDevices[index];
                  return ListTile(
                    leading: const Icon(Icons.bluetooth),
                    title: Text(device ?? 'Unknown'),
                    // subtitle: Text(device['address'] ?? ''),
                    onTap: () {
                      // Send the index of the tapped device
                      sendSelectedDeviceIndex(index);
                    },
                  );
                },
              ),
      ),
    );
  }
}
