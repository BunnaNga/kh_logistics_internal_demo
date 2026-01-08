import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/customer_receive/customer_receive_goods.dart';
import 'package:kh_logistics_internal_demo/activity/customer_receive/customer_receive_scan.dart';
import 'package:kh_logistics_internal_demo/api/app_url.dart';
import 'package:kh_logistics_internal_demo/models/receive/customer_receive_check_model.dart';
import 'package:kh_logistics_internal_demo/models/receive/customer_receive_model.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomerReceiveRequest {
  Future<CustomerReceiveCheckModel> customerReceiveCheck(
      String code, BuildContext context) async {
    log('code is ${code}');
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('${AppUrl().baseUrl}/customer-receive/check');

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = prefs.getString(Constrain.TOKEN) ?? '';
    request.fields['code'] = code;

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['body']['status'] == true) {
        final dataResponse = CustomerReceiveCheckModel.fromJson(json);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerReceiveGoods(
              data: dataResponse,
              qrcodeScan: code,
            ),
          ),
        );
      } else {
        showSingleDialog(context, 'Error', "eror qrcode");
      }

      log('Customer receive check => : ${response.body}');
      return CustomerReceiveCheckModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }

  Future<CustomerReceiveModel> customerReceive(
      String code, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('${AppUrl().baseUrl}/customer-receive/receive');

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = prefs.getString(Constrain.TOKEN) ?? '';
    request.fields['code'] = code;

    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['body']['status'] == true) {
        showSingleDialog(context, 'Success', "Customer received goods");
      } else {
        showSingleDialog(context, 'Error', "eror qrcode");
      }
      log('Customer receive => : ${response.body}');
      return CustomerReceiveModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }

  Future<void> showSingleDialog(
      BuildContext context, String title, String content) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.background_color,
          title: Text('$title'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("$content"),
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
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerReceiveScan()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
