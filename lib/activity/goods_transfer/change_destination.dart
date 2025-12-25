import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/destination_screen.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/goods_transfer.dart';
import 'package:kh_logistics_internal_demo/api/goods_transfer_request.dart';
import 'package:kh_logistics_internal_demo/models/goods_transfer/change_destination_respone.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class ChangeDestination extends StatefulWidget {
  final int id;
  final String code;
  final String desFrom;
  final String desTo;
  final String senderTel;
  final String receiverTel;
  const ChangeDestination({
    super.key,
    required this.id,
    required this.code,
    required this.desFrom,
    required this.desTo,
    required this.senderTel,
    required this.receiverTel,
  });

  @override
  State<ChangeDestination> createState() => _ChangeDestinationState();
}

class _ChangeDestinationState extends State<ChangeDestination> {
  TextEditingController senderController = TextEditingController();
  TextEditingController receiverController = TextEditingController();
  TextEditingController extraFeeController = TextEditingController();

  @override
  void initState() {
    senderController.text = widget.senderTel;
    receiverController.text = widget.receiverTel;

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
        title: Text('change_destination'),
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
                  controller: senderController,
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: senderController.text,
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
                  controller: receiverController,
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: receiverController.text,
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
                  Text("${'destination_to'.tr} ${'(new)'.tr}"),
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
                  onTap: () async {
                    //               int id,
                    // int branchId,
                    // String sendderTel,
                    // String receiverTel,
                    // String destinationToId,
                    // int extraPrice)
                    // Navigator.pop(context);
                    ChangeDestinationRespone respone =
                        await GoodsTransferRequest().changeDestination(
                      widget.id,
                      ValueStatics.destinationFromId!,
                      senderController.text,
                      receiverController.text,
                      ValueStatics.destinationToId.toString(),
                      int.parse(extraFeeController.text),
                    );
                    ValueStatics.destinationFromTitle = '';
                    ValueStatics.destinationToTitle = '';
                    ValueStatics.destinationFromId = 0;
                    ValueStatics.destinationToId = 0;
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
            )
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
          backgroundColor: AppColor.background_color,
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
              },
              child: Text(
                "OK",
                style: TextStyle(color: AppColor.baseColors),
              ),
            ),
          ],
        );
      },
    );
  }
}
