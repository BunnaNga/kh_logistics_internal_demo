import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/receipt_print_screen.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class GoodsInformation extends StatefulWidget {
  const GoodsInformation({super.key});

  @override
  State<GoodsInformation> createState() => _GoodsInformationState();
}

class _GoodsInformationState extends State<GoodsInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColors,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.whiteTextColor,
            )),
        title: Text(
          "goods_information".tr,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.whiteTextColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text(
                    'item_type'.tr,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '*',
                    style: TextStyle(color: AppColor.baseColors),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
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
                      Text('please_select'.tr),
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
                  Text('item_name'.tr),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: TextField(
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: 'enter_item_name'.tr,
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
                  Text('item_value'.tr),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 110,
                    child: TextField(
                      cursorColor: AppColor.baseColors,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.background_color,
                        hintText: '0.00'.tr,
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
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2, color: AppColor.baseColors),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackTextColor,
                              ),
                            ),
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
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Text('quantity'.tr),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        child: TextField(
                          cursorColor: AppColor.baseColors,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.background_color,
                            hintText: '0',
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
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Text('unit_fee'.tr),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        child: TextField(
                          cursorColor: AppColor.baseColors,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.background_color,
                            hintText: '0',
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
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('total_fee'.tr),
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
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: '0.00',
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
            Spacer(),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReceiptPrintScreen()),
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
                        'paid'.tr,
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
}
