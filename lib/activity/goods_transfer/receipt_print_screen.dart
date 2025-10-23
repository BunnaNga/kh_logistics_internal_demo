import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/bluetooth.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class ReceiptPrintScreen extends StatefulWidget {
  const ReceiptPrintScreen({super.key});

  @override
  State<ReceiptPrintScreen> createState() => _ReceiptPrintScreenState();
}

class _ReceiptPrintScreenState extends State<ReceiptPrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 20),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 1,
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
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BluetoothScreen()),
                        );
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
                    "printer_connecting:",
                    style:
                        TextStyle(fontSize: 18, color: AppColor.whiteTextColor),
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
                      cursorColor: AppColor.baseColors,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.background_color,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: AppColor.baseColors),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: AppColor.baseColors),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Text('%', style: TextStyle(fontSize: 25)),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {},
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
            Spacer(),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.baseColors,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'close'.tr,
                          style: TextStyle(
                              color: AppColor.whiteTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
