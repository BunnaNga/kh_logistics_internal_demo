import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/destination_screen.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/goods_information.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/goods_transfer_history.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class GoodsTransfer extends StatefulWidget {
  const GoodsTransfer({super.key});

  @override
  State<GoodsTransfer> createState() => _GoodsTransferState();
}

class _GoodsTransferState extends State<GoodsTransfer> {
  TextEditingController senderController = TextEditingController();
  TextEditingController receiverController = TextEditingController();
  bool isSender = false;
  bool isReceiver = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColors,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.whiteTextColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "input_goods_transfer".tr,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.whiteTextColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoodsTransferHistory(),
                    ),
                  );
                },
                child: Text(
                  "goods_transfer_history".tr,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.whiteTextColor),
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('destination_from'.tr),
                  SizedBox(width: 5),
                  Text(
                    '*',
                    style: TextStyle(color: AppColor.baseColors),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DestinationScreen(
                            destinationType: 1,
                            destinationTitle: 'Destination From',
                          )),
                );
                if (result != null) {
                  setState(() {});
                }
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // optional background color
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColor.baseColors, // yellow border
                    width: 2, // thickness of border
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ValueStatics.destinationFromTitle.isEmpty
                          ? 'please_select'.tr
                          : ValueStatics.destinationFromTitle),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: AppColor.baseColors,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('destination_to'.tr),
                  SizedBox(width: 5),
                  Text(
                    '*',
                    style: TextStyle(color: AppColor.baseColors),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if (ValueStatics.destinationFromTitle.isEmpty) {
                  errorDialog(context, 'infor',
                      'Please select destination from first!');
                } else {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DestinationScreen(
                              destinationType: 2,
                              destinationTitle: 'Destination To',
                            )),
                  );
                  if (result != null) {
                    setState(() {});
                  }
                }

                // DestinationScreen(
                //     destinationTitle: "Destination To", destinationType: 2);
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // optional background color
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColor.baseColors, // yellow border
                    width: 2, // thickness of border
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ValueStatics.destinationToTitle.isEmpty
                          ? 'please_select'.tr
                          : ValueStatics.destinationToTitle),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: AppColor.baseColors,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('sender_telephone'.tr),
                  SizedBox(width: 5),
                  Text(
                    '*',
                    style: TextStyle(color: AppColor.baseColors),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: senderController,
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: 'Ex.012 xxx xxx',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                  onChanged: (value) {
                    final isValidPhone =
                        RegExp(r'^0[0-9]{8,10}$').hasMatch(value);
                    setState(() {
                      isSender = isValidPhone;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('receiver_telephone'.tr),
                  SizedBox(width: 5),
                  Text(
                    '*',
                    style: TextStyle(color: AppColor.baseColors),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: receiverController,
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: 'Ex.012 xxx xxx',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                  onChanged: (value) {
                    final isValidPhone =
                        RegExp(r'^0[0-9]{8,10}$').hasMatch(value);
                    setState(() {
                      isReceiver = isValidPhone;
                    });
                  },
                ),
              ),
            ),
            Spacer(),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    if (ValueStatics.destinationFromTitle.isEmpty ||
                        ValueStatics.destinationToTitle.isEmpty) {
                      if (ValueStatics.destinationFromTitle.isEmpty) {
                        errorDialog(
                            context, 'infor', 'please select destination from');
                      } else {
                        errorDialog(
                            context, 'infor', 'please select destination to');
                      }
                    } else {
                      if (senderController.text.isEmpty ||
                          receiverController.text.isEmpty) {
                        if (senderController.text.isEmpty &&
                            receiverController.text.isEmpty) {
                          errorDialog(
                              context, 'infor', 'please input sender number');
                        } else if (senderController.text.isEmpty) {
                          errorDialog(
                              context, 'infor', 'please input sender number');
                        } else if (receiverController.text.isEmpty) {
                          errorDialog(
                              context, 'infor', 'please input receiver number');
                        }
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoodsInformation()),
                        ).then((value) {
                          setState(() {
                            senderController.clear();
                            receiverController.clear();
                            ValueStatics.destinationToTitle = '';
                            ValueStatics.destinationFromTitle = '';
                            ValueStatics.destinationFromId = 0;
                          });
                        });
                        // if (result != null) {
                        //   log('hellow');

                        // }
                      }
                    }

                    log('sender is : ${isSender}. receiver is : ${isReceiver}');
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.baseColors,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        'continue'.tr,
                        style: TextStyle(
                            color: AppColor.whiteTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void errorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ValueStatics.destinationFromId = 0;
    ValueStatics.destinationFromTitle = '';
    ValueStatics.destinationToTitle = '';
    senderController.dispose();
    receiverController.dispose();

    super.dispose();
  }
}
