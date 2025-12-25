import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';

class TestChannel extends StatefulWidget {
  const TestChannel({super.key});

  @override
  State<TestChannel> createState() => _TestChannelState();
}

class _TestChannelState extends State<TestChannel> {
  static const MethodChannel platform =
      MethodChannel('com.example.kh_logistics_internal_demo/bluetooth');
  bool isOpen = true;
  List<String> bluetoothDevices = [];
  Uint8List? imageBytes; // <-- Store the image bytes here
  ScreenshotController screenshotControllerReceipt = ScreenshotController();
  @override
  initState() {
    openBluetoothAdapter();
    checkBlue();
    super.initState();
  }

  void checkBlue() async {
    while (isOpen == true) {
      await getBluetoothList();
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  Future<void> openBluetoothAdapter() async {
    try {
      await platform.invokeMethod('openBluetoothAdapter');
    } on PlatformException catch (e) {
      log("Failed to get bluetooth list: ${e.message}");
    }
  }

  Future<void> getBluetoothList() async {
    try {
      List<dynamic>? result =
          await platform.invokeMethod('getBluetoothDevices');

      setState(() {
        bluetoothDevices = result?.cast<String>() ?? [];
        log('Bluetooth devices: $bluetoothDevices');
      });
    } on PlatformException catch (e) {
      log("Failed to get bluetooth list: ${e.message}");
    }
  }

  Future<void> selecIndex(int index) async {
    try {
      final connectionState = await platform.invokeMethod('selecIndex', {
        'index': index,
      });
      if (connectionState != null) {
        log("connection state is: ${connectionState}");
      }
    } on PlatformException catch (e) {
      log("Failed to get bluetooth list: ${e.message}");
    }
  }

  Future<void> sendDataReceipt(Uint8List bitmapReceipt) async {
    try {
      await platform.invokeMethod<Uint8List>(
        'sendImageReceipt',
        {
          'receipt': bitmapReceipt,
        },
      );
    } on PlatformException catch (e) {
      log("Failed to send bitmap: ${e.message}");
    }
  }

  Future<Uint8List> assetImageToUint8List(String assetPath) async {
    try {
      ByteData byteData = await rootBundle.load(assetPath);
      return byteData.buffer.asUint8List();
    } catch (e) {
      log("Error loading asset: $e");
      return Uint8List(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth Devices')),
      body: Screenshot(
        controller: screenshotControllerReceipt,
        child: Container(
          color: Colors.white,
          child: Transform.scale(
            alignment: Alignment.topLeft,
            scale: 0.5,
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Display the image if loaded
                if (imageBytes != null)
                  Image.memory(imageBytes!, width: 150, height: 150),

                const SizedBox(height: 20),

                ElevatedButton(
                  // onPressed: () async {
                  //   Uint8List bytes = await assetImageToUint8List(
                  //       'assets/images/kh_logistic_logo.png');
                  //   if (bytes.isNotEmpty) {
                  //     log("Image bytes loaded: $bytes");
                  //     setState(() {
                  //       imageBytes = bytes; // <-- update state to show image
                  //     });
                  //     // sendDataReceipt(bytes);
                  //   } else {
                  //     log("Failed to load image bytes");
                  //   }
                  // },
                  onPressed: () {
                    screenshotControllerReceipt
                        .capture(delay: Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      // ShowCapturedWidget(context, capturedImage!);
                      sendDataReceipt(capturedImage!);
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                  child: const Text('Print Data'),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: bluetoothDevices.isEmpty
                      ? const Center(child: Text('No devices found'))
                      : ListView.builder(
                          itemCount: bluetoothDevices.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.bluetooth),
                              title: Text(bluetoothDevices[index]),
                              onTap: () {
                                selecIndex(index);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
}
