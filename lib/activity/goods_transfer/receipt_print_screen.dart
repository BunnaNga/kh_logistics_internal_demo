import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/bluetooth.dart';
import 'package:kh_logistics_internal_demo/models/goods_transfer/goods_transfer_add_respone.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/services.dart'
    show MethodCall, MethodChannel, PlatformException, rootBundle;
import 'package:image/image.dart' as img;

class ReceiptPrintScreen extends StatefulWidget {
  final Data data;
  const ReceiptPrintScreen({super.key, required this.data});

  @override
  State<ReceiptPrintScreen> createState() => _ReceiptPrintScreenState();
}

class _ReceiptPrintScreenState extends State<ReceiptPrintScreen> {
  TextEditingController controllerScale = TextEditingController();
  double scaleSize = 0.0;
  ScreenshotController screenshotControllerReceipt = ScreenshotController();
  late List<ScreenshotController> qrControllers;
  bool? isConnected;
  bool isCompletedReceipt = false;
  ValueNotifier<int> progressNotifier = ValueNotifier(0);

  static const platform =
      MethodChannel('com.example.kh_logistics_internal_demo/bluetooth');
  String? isButton;
  Uint8List? bytImage;
  // int qty = 0;

  Future<void> sendDataReceipt(
    Uint8List bitmapReceipt,
  ) async {
    try {
      // Call native method and await the result
      // final Uint8List? result =
      await platform.invokeMethod<Uint8List>(
        'sendImageReceipt',
        {
          'receipt': bitmapReceipt,
        },
      );
      // setState(() {
      //   bytImage = result;
      // });
    } on PlatformException catch (e) {
      log("Failed to send bitmap: ${e.message}");
    }
  }

  Future<void> sendDataQr(List<Uint8List> bitmapQr) async {
    try {
      // Call native method and await the result
      // final Uint8List? result =
      await platform.invokeMethod<Uint8List>(
        'sendImageQrcode',
        {
          'qrCode': bitmapQr,
        },
      );
      // setState(() {
      //   bytImage = result;
      // });
    } on PlatformException catch (e) {
      log("Failed to send bitmap: ${e.message}");
    }
  }

  Future<void> checkConnection() async {
    try {
      // Call native method and await the result
      final bool? result = await platform.invokeMethod('checkConnection');
      setState(() {
        isConnected = result;
      });
    } on PlatformException catch (e) {
      log("Failed to send bitmap: ${e.message}");
    }
  }

  void checkDevice() async {
    await checkConnection();
  }

  Future<void> _handleNativeCalls(MethodCall call) async {
    switch (call.method) {
      case "printProgress":
        final int progress = (call.arguments['progress'] as num).toInt();
        progressNotifier.value = progress; // notify the dialog
        debugPrint("Print progress: $progress%");
        break;

      case "printCompleted":
        hideLoadingDialog();
        debugPrint("Print completed");
        break;
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Row(
            children: [
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: progressNotifier,
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                        color: AppColor.baseColors, value: value / 100);
                  },
                ),
              ),
              SizedBox(width: 10),
              Text('printing_progress'.tr),
              SizedBox(width: 10),
              ValueListenableBuilder<int>(
                valueListenable: progressNotifier,
                builder: (context, value, child) {
                  return Text("$value%");
                },
              ),
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

  @override
  void initState() {
    //
    platform.setMethodCallHandler(_handleNativeCalls);
    checkDevice();
    controllerScale.text = '50';
    scaleSize = double.parse(controllerScale.text) / 100;

    final int qty = int.tryParse(
          widget.data.printItemLayoutList?[0].itemQty ?? '1',
        ) ??
        1;

    qrControllers = List.generate(qty, (_) => ScreenshotController());
    super.initState();
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
        body: Container(
            // color: Colors.amber,
            child: Center(child: Image.memory(capturedImage))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          try {
                            Uint8List? capturedImageReceipt =
                                await screenshotControllerReceipt.capture(
                                    // delay: const Duration(milliseconds: 10),
                                    );
                            if (Platform.isIOS) {
                              showLoadingDialog();
                            }
                            if (capturedImageReceipt != null) {
                              log('Start receipt');
                              sendDataReceipt(
                                capturedImageReceipt,
                              );
                            }

                            Future.delayed(const Duration(seconds: 5),
                                () async {
                              log("Start qrcode");
                              // Capture screenshot
                              List<Uint8List> listQr = [];

                              for (int i = 0; i < qrControllers.length; i++) {
                                final Uint8List? qrImage =
                                    await qrControllers[i].capture(
                                        // delay: const Duration(milliseconds: 10),
                                        );

                                if (qrImage != null) {
                                  listQr.add(qrImage);
                                }
                              }
                              if (listQr.isNotEmpty) {
                                sendDataQr(listQr);
                              }
                            });
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.background_color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1.5,
                                blurRadius: 0.1,
                                offset: Offset(-1, 2),
                              ),
                            ],
                          ),
                          height: 50,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 30,
                                child: Image.asset(
                                  'assets/images/receipt.png',
                                  color: AppColor.baseColors,
                                ),
                              ),
                              Text(
                                'print_receipt'.tr,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BluetoothScreen()),
                          );

                          if (result != null) {
                            checkDevice();
                          }
                          setState(() {});
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColor.background_color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1.5,
                                blurRadius: 0.1,
                                offset: Offset(-1, 2),
                              ),
                            ],
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  height: 30,
                                  child: Image.asset(
                                    'assets/images/printer.png',
                                    color: AppColor.baseColors,
                                  )),
                              Text('select_printer'.tr,
                                  style: TextStyle(fontSize: 18)),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "printer_connecting:  " +
                          (isConnected == true ? "Success" : "Failed"),
                      style: TextStyle(
                          fontSize: 18, color: AppColor.whiteTextColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'scale:',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: controllerScale,
                        cursorColor: AppColor.baseColors,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.background_color,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColor.baseColors),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColor.baseColors),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    Text('%', style: TextStyle(fontSize: 25)),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          scaleSize = double.parse(controllerScale.text) / 100;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                            color: AppColor.baseColors,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'apply'.tr,
                            style: TextStyle(
                                color: AppColor.whiteTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Screenshot(
                controller: screenshotControllerReceipt,
                child: Container(
                  color: Colors.white,
                  // color: Colors.blue,
                  child: Transform.scale(
                    alignment: Alignment.topLeft,
                    scale: scaleSize, // make 80% of original size
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 620,
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1),
                        color: AppColor.background_color,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.8,
                            blurRadius: 20,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 29,
                                  child: Image.asset(
                                      "assets/images/kh_logistic_logo.png"),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'KH Logistics',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('វិក័យបត្រ'),
                                    Text('VAT: 0123456789'),
                                  ],
                                ),
                                QrImageView(
                                  data: '${widget.data.code}',
                                  version: QrVersions.auto,
                                  size: 80.0,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '#KH-LOGISTICS-0007',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                'លេខវិក័យបត្រ: ',
                              ),
                              Text(
                                '${widget.data.code}',
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'គោលដៅ: ${widget.data.destFrom} -> ${widget.data.destTo}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'កាលបរិច្ឆេទ: ',
                              ),
                              Text(
                                '${widget.data.printDate}',
                              ),
                            ],
                          ),
                          Table(
                            border: const TableBorder(
                              left: BorderSide(color: Colors.black, width: 1),
                              right: BorderSide(color: Colors.black, width: 1),
                              top: BorderSide(color: Colors.black, width: 1),

                              // NO bottom border
                              bottom: BorderSide.none,
                              horizontalInside: BorderSide.none,
                              verticalInside: BorderSide.none,
                            ),
                            children: [
                              TableRow(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'លេខអ្នកផ្ញើ: ${widget.data.senderTel}',
                                          ),
                                          Text(
                                              "លេខកអ្នកទទួល: ${widget.data.receiverTel}"),
                                        ],
                                      )),
                                  // Center(child: Text('Quantity')),
                                ],
                              )
                            ],
                          ),
                          Table(
                            border: TableBorder.all(),
                            children: [
                              // TableCell(child: Center(child: Text('Item'))),

                              TableRow(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Text('ទំនិញ'),
                                        Text('(តម្លៃ1ឯកតា)')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${widget.data.printItemLayoutList?[0].itemQty}(${widget.data.printItemLayoutList?[0].itemFee ?? ''})'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Center(child: Text('សម្គាល់')),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        '${ValueStatics.itemType} ${widget.data.printItemLayoutList?[0].itemName}'),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Center(child: Text('តម្លៃសេវា')),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        '${widget.data.transferFee}${"៛"} (ទូទាត់រួចរាល់)'),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Center(child: Text('តម្លៃសរុប')),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child:
                                        Text('${widget.data.totalFee}${"៛"}'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            'បោះពុម្ភ:${widget.data.printDate}(${widget.data.printBy}) ចេញដោយ: ${widget.data.printBy}',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.9 / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.data.destFrom}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${widget.data.senderTel}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.data.destTo}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${widget.data.receiverTel}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            '១- មិនទទួលខុសត្រូវទំនិញងាយបែកបាក់ ឬ ខូចគុណភាព។',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            '២- មិនទទួលបញ្ញើទំនិញខុសច្បាប់គ្រប់ប្រភេទ។',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            '៣- មិនទទួលបញ្ញើទំនិញងាយបង្កគ្រោះថ្នាក់។',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            '៤-បញ្ញើបាត់បង់ ក្រុមហ៊ុនទទួលសង ២០ដងនៃតម្លៃសេវាបញ្ញើ!ខូចខាត១៥ដង នៃតម្លៃបញ្ញើ។',
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true, // ✅ VERY IMPORTANT
                physics: const NeverScrollableScrollPhysics(), // ✅
                itemCount: int.tryParse(
                      widget.data.printItemLayoutList?[0].itemQty ?? '1',
                    ) ??
                    1,
                itemBuilder: (context, index) {
                  log('${index}');
                  return Screenshot(
                    controller: qrControllers[index],
                    child: Container(
                      color: Colors.white,
                      child: Transform.scale(
                        alignment: Alignment.topLeft,
                        scale: scaleSize, // make 80% of original size
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: 520,
                          decoration: BoxDecoration(
                            color: AppColor.background_color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 0.8,
                                blurRadius: 20,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                                child: Image.asset(
                                    'assets/images/kh_logistic_logo.png'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  '${widget.data.destFrom}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(Icons.arrow_downward_outlined),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  '${widget.data.destTo}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  '${widget.data.printItemLayoutList?[0].itemCode}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: QrImageView(
                                  data:
                                      '${widget.data.printItemLayoutList?[0].itemCode},${widget.data.receiverTel},${index + 1}',
                                  version: QrVersions.auto,
                                  size: 150.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  '${widget.data.receiverTel}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  '${ValueStatics.itemType} ${widget.data.printItemLayoutList?[0].itemName}(${index + 1}/${widget.data.printItemLayoutList?[0].itemQty})',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                    'កាលបរិច្ឆេទ:${widget.data.printDate}'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Spacer(),

              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: 300,
          height: 50, // match width and height for circle
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: AppColor.baseColors,
            child: Text("close".tr,
                style: TextStyle(
                    color: AppColor.whiteTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
