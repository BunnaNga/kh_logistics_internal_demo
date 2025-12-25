import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/receipt_print_screen.dart';
import 'package:kh_logistics_internal_demo/models/goods_transfer/goods_transfer_add_respone.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<GoodsTransferAddRespone> dataList = [
    GoodsTransferAddRespone(
      body: Body(
        status: true,
        message: "Test print",
        data: [
          Data.fromJson({
            "code": "BBP-0072512-000049",
            "destFrom": "សាខា ផ្សារឈូកមាស",
            "destTo": "សាខាក្រាំងធ្វើក្នុង(បុរីវ៉ារីណា)",
            "senderTel": "015644233",
            "receiverTel": "089655234",
            "transferFee": "1.0",
            "deliveryFee": "0.0",
            "totalFee": "1.0",
            "printDate": "24/12/2025 10:31:29",
            "printBy": "admin",
            "created": "24/12/2025 10:31:29",
            "createdBy": "admin",
            "branchFName": "សាខា ផ្សារឈូកមាស",
            "branchFTel": "016 267 603",
            "branchTName": "សាខាក្រាំងធ្វើក្នុង(បុរីវ៉ារីណា)",
            "branchTTel": "016 267 603",
            "deliveryDestination": "",
            "paidBy": 1,
            "isCod": 0,
            "printItemLayoutList": [
              {
                "itemCode": "BBP-0072512-000049-1",
                "itemName": "Heidi",
                "itemQty": "1",
                "itemFee": "10.0 \$"
              }
            ]
          })
        ],
      ),
    ),
  ];
  // List<Data> dataList =

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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReceiptPrintScreen(
                            data: dataList[0].body!.data![0])));
              },
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
