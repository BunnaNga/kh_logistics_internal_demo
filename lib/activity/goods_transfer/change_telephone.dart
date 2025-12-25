import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class ChangeTelephone extends StatefulWidget {
  final String code;
  final String senderTelephone;
  final String receiverTelephone;

  const ChangeTelephone({
    super.key,
    required this.code,
    required this.senderTelephone,
    required this.receiverTelephone,
  });

  @override
  State<ChangeTelephone> createState() => _ChangeTelephoneState();
}

class _ChangeTelephoneState extends State<ChangeTelephone> {
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
                Text('llasdfi2938'),
              ],
            ),
            SizedBox(height: 20),
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
}
