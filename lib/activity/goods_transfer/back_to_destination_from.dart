import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/destination_screen.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/goods_information.dart';
import 'package:kh_logistics_internal_demo/api/goods_transfer_request.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class BackToDestinationFrom extends StatefulWidget {
  final int id;
  final String code;
  final int desFromId;
  final String desFrom;
  final String desTo;
  final String senderTelephone;
  final String receiverTelephone;

  const BackToDestinationFrom({
    super.key,
    required this.id,
    required this.code,
    required this.desFromId,
    required this.desFrom,
    required this.desTo,
    required this.receiverTelephone,
    required this.senderTelephone,
  });

  @override
  State<BackToDestinationFrom> createState() => _BackToDestinationFromState();
}

class _BackToDestinationFromState extends State<BackToDestinationFrom> {
  TextEditingController extraFeeController = TextEditingController();

  // String statusText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('back_to_destination_from'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('លេខវិក្កយបត្រ'),
                Text(widget.code),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ពីទិសដៅ'),
                Text(widget.desFrom),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ទៅកាន់ទិសដៅ(ចាស់)'),
                Text(widget.desTo),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('branch'.tr),
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
                  // controller: senderController,
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: widget.senderTelephone,
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
                  // controller: senderController,
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: widget.receiverTelephone,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('extra_fee'.tr),
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
                  controller: extraFeeController,
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: '0',
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
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.44,
                    decoration: BoxDecoration(
                        color: AppColor.baseColors,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "cancel".tr,
                        style: TextStyle(
                            color: AppColor.whiteTextColor, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    GoodsTransferRequest().returnDestination(
                        widget.id,
                        widget.desFromId,
                        widget.senderTelephone,
                        widget.receiverTelephone,
                        int.parse(extraFeeController.text));
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.44,
                    decoration: BoxDecoration(
                        color: AppColor.baseColors,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "save".tr,
                        style: TextStyle(
                            color: AppColor.whiteTextColor, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
