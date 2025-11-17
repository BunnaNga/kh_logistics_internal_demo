import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text('choose_printer'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.baseColors, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/images/printer.jpg"),
                        ),
                        Container(
                          color: AppColor.baseColors,
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Center(
                            child: Text(
                              "BLUETOOTH",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.whiteTextColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: AppColor.baseColors,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('choose_printer'.tr,
                      style: TextStyle(
                          color: AppColor.whiteTextColor, fontSize: 18)),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('no_device_connect'.tr,
                style: TextStyle(fontSize: 18, color: AppColor.baseColors)),
            SizedBox(height: 50),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: AppColor.baseColors,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('print_test'.tr,
                      style: TextStyle(
                          color: AppColor.whiteTextColor, fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
