import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/auth/sign_in.dart';
import 'package:kh_logistics_internal_demo/activity/menu_screen.dart';
import 'package:kh_logistics_internal_demo/api/auth.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/app_preference.dart';
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Auth().ckeckToken(context);
    loadLanguage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/kh_logistic_logo.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(
              color: AppColor.baseColors,
            )
          ],
        ),
      ),
    );
  }

  loadLanguage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(Constrain.LANGUAGE);
    log('Language Value: $value');

    if (value == Constrain.ENGLISH) {
      log('English');
      setState(() {
        Preference().setLanguage(prefs, Constrain.ENGLISH);
        Get.updateLocale(const Locale('en', 'US'));
      });
    } else {
      log('Khmer');
      setState(() {
        Preference().setLanguage(prefs, Constrain.KHMER);
        Get.updateLocale(const Locale('km', 'KH'));
      });
    }
  }
}
