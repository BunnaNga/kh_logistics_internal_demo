import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  ReceiptController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth Printer")),
      body: Receipt(
        builder: (context) => Column(
          children: [
            const SizedBox(height: 10),
            const Text('Hello World'),
            const SizedBox(height: 5),
            const Text('Address, Place', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 15),
            for (int i = 0; i < 5; i++)
              Row(
                children: [
                  Expanded(
                      child: Text('s${i + 1}',
                          style: const TextStyle(fontSize: 12))),
                  Expanded(
                      flex: 3,
                      child: const Text('product',
                          style: TextStyle(fontSize: 12))),
                  Expanded(
                      flex: 2,
                      child: const Text('rate',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.right)),
                  Expanded(
                      flex: 2,
                      child: const Text('amount',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.right)),
                ],
              ),
          ],
        ),
        onInitialized: (c) {
          controller = c;
          log("ReceiptController initialized");
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (controller == null) {
              log("Receipt controller not initialized");
              return;
            }

            try {
              // Select printer
              final device =
                  await FlutterBluetoothPrinter.selectDevice(context);
              if (device == null) {
                log("No printer selected");
                return;
              }

              log("Printing to printer ${device.name} at ${device.address}");

              // Retry mechanism: try 2 times if printing fails
              for (int attempt = 0; attempt < 2; attempt++) {
                try {
                  await controller!.print(
                    address: device.address,
                    keepConnected: false,
                    addFeeds: 8, // more feeds to trigger paper
                  );
                  log("Print successful");
                  break; // stop retry after success
                } catch (e) {
                  log("Printing attempt ${attempt + 1} failed: $e");
                  if (attempt == 1) rethrow; // throw after last attempt
                }
              }
            } catch (e, stack) {
              log("Printing failed: $e");
              log(stack.toString());
            }
          },
          child: const Text('Select Printer & Print'),
        ),
      ),
    );
  }
}
