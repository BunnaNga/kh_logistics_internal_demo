import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/customer_receive/customer_receive.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/goods_transfer.dart';
import 'package:kh_logistics_internal_demo/activity/move_item_from_van/move_item_from_van.dart';
import 'package:kh_logistics_internal_demo/activity/move_item_to_van/move_item_to_van.dart';
import 'package:kh_logistics_internal_demo/activity/reports/reports.dart';
import 'package:kh_logistics_internal_demo/activity/user_setting/change_language.dart';
import 'package:kh_logistics_internal_demo/activity/user_setting/log_out.dart';
import 'package:kh_logistics_internal_demo/activity/user_setting/setting.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/app_version.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Map<String, dynamic>> mainFunctionList = [
    {
      'title': 'goods_transfer'.tr,
      'iconPath': 'assets/images/ic_goods_transfer.png',
    },
    {
      'title': 'move_item_to_van'.tr,
      'iconPath': 'assets/images/ic_move_goods_to_van.png',
    },
    {
      'title': 'move_item_from_van'.tr,
      'iconPath': 'assets/images/ic_receive_goods_from_van.png',
    },
    {
      'title': 'customer_receive'.tr,
      'iconPath': 'assets/images/ic_receive_goods.png',
    },
    {
      'title': 'reports'.tr,
      'iconPath': 'assets/images/ic_reports.png',
    },
  ];
  List<Widget> mainFunctionScreens = [
    GoodsTransfer(),
    MoveItemToVan(),
    MoveItemFromVan(),
    CustomerReceive(),
    Reports(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background_color,
      drawer: Drawer(
        backgroundColor: AppColor.background_color,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              // color: Colors.blue,
              child: Center(
                child: SizedBox(
                    height: 120,
                    width: 150,
                    child: Image.asset('assets/images/kh_logistic_logo.jpg')),
              ),
            ),
            Container(
              // color: AppColor.baseColors,
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: AppColor.baseColors,
                ),
                title: Text(
                  'setting'.tr,
                  style: TextStyle(color: AppColor.baseColors),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Setting()));
                },
              ),
            ),
            Container(
              // color: AppColor.baseColors,
              child: ListTile(
                leading: Icon(
                  color: AppColor.baseColors,
                  Icons.language_rounded,
                ),
                title: Text(
                  'change_language'.tr,
                  style: TextStyle(color: AppColor.baseColors),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeLanguage()));
                },
              ),
            ),
            Container(
              // color: AppColor.baseColors,
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: AppColor.baseColors,
                ),
                title: Text(
                  'logout'.tr,
                  style: TextStyle(color: AppColor.baseColors),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogOut()));
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColor.background_color, // change drawer icon color
        ),
        centerTitle: true,
        title: Text(
          'home'.tr,
          style: TextStyle(
              color: AppColor.whiteTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColor.baseColors,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, right: 10),
                        child: SizedBox(
                          height: 20,
                          child: Image.asset(
                            'assets/images/ic_user.png',
                            color: AppColor.background_color,
                          ),
                        ),
                      ),
                      Text('username'.tr,
                          style: TextStyle(
                              fontSize: 16, color: AppColor.whiteTextColor)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${'version'.tr} ${AppVersion.version}',
                          style: TextStyle(
                              fontSize: 16, color: AppColor.whiteTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 25.0,
            childAspectRatio: 1.2,
          ),
          itemCount: mainFunctionList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => mainFunctionScreens[index],
                  ),
                );
              },
              child: mainFunctions(
                  title: mainFunctionList[index]['title'],
                  iconPath: mainFunctionList[index]['iconPath']),
            );
          },
        ),
      ),
    );
  }

  Widget mainFunctions({required String title, required String iconPath}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.background_color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.8,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Image.asset(
                iconPath,
                height: 50,
                width: 50,
                // color: AppColor.textColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
