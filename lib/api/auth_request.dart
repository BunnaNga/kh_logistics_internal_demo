import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kh_logistics_internal_demo/activity/auth/sign_in.dart';
import 'package:kh_logistics_internal_demo/activity/menu_screen.dart';
import 'package:kh_logistics_internal_demo/api/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:kh_logistics_internal_demo/models/auth/login.dart';
import 'package:kh_logistics_internal_demo/models/auth/logout.dart';
import 'package:kh_logistics_internal_demo/models/auth/token.dart';
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:kh_logistics_internal_demo/util/show_dialog.dart';
import 'package:kh_logistics_internal_demo/util/app_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  void ckeckToken(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppUrl().baseUrl}/auth/checkToken'));
    request.headers['Authorization'] = prefs.getString(Constrain.TOKEN) ?? '';
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      log('hello');
      final result = TokenRespone.fromJson(jsonDecode(response.body));

      if (result.header!.statusCode == 200 && result.header!.result == true) {
        log('go to Menu Screen');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuScreen()),
        );
      } else {
        log('go to Menu Sign In Screen');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      }
    } else {
      throw Exception('Failed to load to server!!');
    }
  }

  void login(context, String username, String password) async {
    String deviceId = "";
    String deviceName = "";
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
      deviceId = iosInfo.utsname.sysname;
    }
    final prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppUrl().baseUrl}/auth/login'));
    request.fields['deviceId'] = deviceId;
    request.fields['deviceName'] = deviceName;
    request.fields['password'] = password;
    request.fields['username'] = username;
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      log('200');
      final logInResponse = LogInResponse.fromJson(jsonDecode(response.body));
      if (logInResponse.header!.statusCode == 200 &&
          logInResponse.header!.result == true) {
        log('Login Successful');
        Preference().setToken(prefs,
            "${logInResponse.body!.tokenType} ${logInResponse.body!.accessToken}");
        log("${logInResponse.body!.tokenType} ${logInResponse.body!.accessToken}");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MenuScreen(),
          ),
        );
      } else {
        ShowDialog.showSingleDialog(
            context, 'Error!', 'Something went wrong, please try again.');
      }
    } else {
      throw Exception('Failed to load to server!!');
    }
  }

  void logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    String deviceId = '';
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.utsname.sysname;
    }
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppUrl().baseUrl}/auth/logout'));
    request.headers['Authorization'] = prefs.getString(Constrain.TOKEN) ?? '';
    request.fields['deviceId'] = deviceId;
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final result = LogoutRespone.fromJson(jsonDecode(response.body));
      log('Logout Successful');
      if (result.header!.statusCode == 200 && result.header!.result == true) {
        Preference().clearToken(prefs);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => SignIn()), // replace with your login screen
          (route) => false, // remove all routes
        );
      } else {
        ShowDialog.showSingleDialog(
            context, 'Error!', 'Something went wrong, please try again.');
      }
    } else {
      throw Exception('Failed to load to server!!');
    }
  }
}
