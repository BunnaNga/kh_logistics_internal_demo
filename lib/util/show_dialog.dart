import 'package:flutter/material.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class ShowDialog {
  // Make it static so you can call it without creating an instance
  static void showSingleDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.background_color,
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(color: AppColor.baseColors),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showConfirmDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.background_color,
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColor.baseColors),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(color: AppColor.baseColors),
              ),
            ),
          ],
        );
      },
    );
  }
}
