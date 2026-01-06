import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class ShowSingleDialog {
  Future<void> showSingleDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.background_color,
          title: Text('notification'.tr),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('error qr code or qrcode have been scanned'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Center(
                  child: const Text(
                'ok',
                style: TextStyle(color: AppColor.baseColors),
              )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
