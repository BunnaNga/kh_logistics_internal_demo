import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class InputOrScanItemToVan extends StatefulWidget {
  const InputOrScanItemToVan({super.key});

  @override
  State<InputOrScanItemToVan> createState() => _InputOrScanItemToVanState();
}

class _InputOrScanItemToVanState extends State<InputOrScanItemToVan> {
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
          title: Text('move_item_to_van'.tr),
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
                  SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/images/scan_qr.png',
                        color: AppColor.baseColors,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'total_scan:'.tr,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'item_available:'.tr,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Spacer(),
              Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
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
        ));
  }
}
