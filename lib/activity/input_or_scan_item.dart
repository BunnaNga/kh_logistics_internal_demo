import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/menu_screen.dart';
import 'package:kh_logistics_internal_demo/activity/qr_code_scaner.dart';
import 'package:kh_logistics_internal_demo/api/move_item_from_van_request.dart';
import 'package:kh_logistics_internal_demo/api/move_item_to_van_request.dart';
import 'package:kh_logistics_internal_demo/models/move_item_from_van/move_item_from_van_model.dart';
import 'package:kh_logistics_internal_demo/models/move_item_to_van/move_item_to_van_model.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/show_single_dialog.dart';

class InputOrScanItem extends StatefulWidget {
  final int moveType;
  final String date;
  final int branchId;
  final int vanId;
  final int? destinationToId;
  final String? departureTime;
  final String? scanCode;
  final String? sysCode;
  final int? type;
  const InputOrScanItem({
    super.key,
    required this.moveType,
    required this.date,
    required this.branchId,
    this.destinationToId,
    required this.vanId,
    this.departureTime,
    this.scanCode,
    this.sysCode,
    this.type,
  });

  @override
  State<InputOrScanItem> createState() => _InputOrScanItemState();
}

class _InputOrScanItemState extends State<InputOrScanItem> {
  List listItem = [];
  @override
  void initState() {
    log('Inite data scan code =>\n moveType:${widget.moveType}\n date:${widget.date}\n brand id:${widget.branchId}\n destinationId:${widget.destinationToId}\n vanId:${widget.vanId}\n departureTime:${widget.departureTime}\n sysCode:${widget.sysCode}\n type:${widget.type}');
    super.initState();
  }

  // void loadDestinations() async {
  //   // if (widget.destinationType == 1) {
  //   //   DestinationFromRespone response = await Destination().destinationFrom('');

  //   //   setState(() {
  //   //     destinationList = response.body?.data ?? [];
  //   //   });
  //   // } else {
  //   //   DestinationToRespone response = await Destination()
  //   //       .destinationTo('', ValueStatics.destinationFromId!);

  //   //   setState(() {
  //   //     destinationList = response.body?.data ?? [];
  //   //   });
  //   // }
  //   MoveItemToVanModel response = await MoveItemToVanRequest().moveItemToVan(
  //     widget.date,
  //     widget.branchId,
  //     widget.destinationToId,
  //     widget.vanId!,
  //     widget.departureTime!,
  //     widget.scanCode!,
  //     widget.sysCode!,
  //     widget.type!,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.moveType == 1
            ? 'move_item_to_van'.tr
            : 'move_item_from_van'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    cursorColor: AppColor.baseColors,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.background_color,
                      hintText: 'enter_item_code'.tr,
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
                InkWell(
                  onTap: () async {
                    final resultQrcode = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QrCodeScaner()));

                    log('Scanned QR Code: $resultQrcode');
                    if (resultQrcode != null && widget.moveType == 1) {
                      MoveItemToVanModel result =
                          await MoveItemToVanRequest().moveItemToVan(
                        widget.date,
                        widget.branchId,
                        widget.destinationToId!,
                        widget.vanId,
                        widget.departureTime!,
                        resultQrcode.toString(),
                        widget.sysCode!,
                        widget.type!,
                      );
                      if (result.body != null && result.body!.status == true) {
                        setState(() {
                          listItem.add(result.body!.data![0]);
                        });
                        log('Added item to list to vam : ${result.body!.toJson()}');
                      } else {
                        setState(() {
                          ShowSingleDialog().showSingleDialog(context);
                        });
                        log('No data found in the response for the scanned code.');
                      }
                    } else if (resultQrcode != null && widget.moveType == 2) {
                      MoveItemFromVanModel result =
                          await MoveItemFromVanRequest().moveItemFromVan(
                        widget.date,
                        widget.branchId,
                        widget.vanId,
                        resultQrcode.toString(),
                        widget.sysCode!,
                      );
                      if (result.body != null && result.body!.status == true) {
                        setState(() {
                          listItem.add(result.body!.data![0]);
                        });

                        log('Added item to list from van : ${result.body!.toJson()}');
                      } else {
                        setState(() {
                          ShowSingleDialog().showSingleDialog(context);
                        });
                        log('No data found in the response for the scanned code.');
                      }
                    }
                  },
                  child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/images/scan_qr.png',
                        color: AppColor.baseColors,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'total_scan:'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'item_available:'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: listItem.length,
                  itemBuilder: (context, index) {
                    final data = listItem[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.baseColors,
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      'item_code'.tr,
                                      style: TextStyle(
                                        color: AppColor.background_color,
                                      ),
                                    ),
                                  ),
                                  Text(': ',
                                      style: TextStyle(
                                          color: AppColor.background_color)),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        data.itemCode ?? '',
                                        style: TextStyle(
                                          color: AppColor.background_color,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      'receiver_telephone'.tr,
                                      style: TextStyle(
                                        color: AppColor.background_color,
                                      ),
                                    ),
                                  ),
                                  Text(': ',
                                      style: TextStyle(
                                          color: AppColor.background_color)),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        data.receiverTel ?? '',
                                        style: TextStyle(
                                          color: AppColor.background_color,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      'destination_to'.tr,
                                      style: TextStyle(
                                        color: AppColor.background_color,
                                      ),
                                    ),
                                  ),
                                  Text(': ',
                                      style: TextStyle(
                                          color: AppColor.background_color)),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        data.destinationToName ?? '',
                                        style: TextStyle(
                                          color: AppColor.background_color,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenuScreen()),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.baseColors,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        'finish'.tr,
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
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 20),
      //   child: Container(
      //     width: 300,
      //     height: 50, // match width and height for circle
      //     decoration: BoxDecoration(
      //       border: Border.all(width: 1, color: AppColor.background_color),
      //     ),
      //     child: FloatingActionButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       backgroundColor: AppColor.baseColors,
      //       child: Text("finish".tr,
      //           style: TextStyle(
      //               color: AppColor.whiteTextColor,
      //               fontSize: 20,
      //               fontWeight: FontWeight.bold)),
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
