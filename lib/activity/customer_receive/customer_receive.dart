import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class CustomerReceive extends StatefulWidget {
  const CustomerReceive({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<CustomerReceive> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _flash = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GestureDetector(
          onTap: () {
            controller?.resumeCamera();
            setState(() {});
          },
          child: _buildQrView(context),
        ),
        SafeArea(
            child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(_flash ? Icons.flash_on : Icons.flash_off),
              color: Colors.white,
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {
                  _flash = !_flash;
                });
              },
            ),
          ),
        )),
        SafeArea(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      color: AppColor.baseColors,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('close'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                )))
      ],
    ));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 40,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        log('Scanned Data: ${result!.code}');
        controller.pauseCamera();
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    log('dispose called');
    // TODO: implement dispose
    super.dispose();
  }
}
