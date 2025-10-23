import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kh_logistics_internal_demo/activity/menu_screen.dart';
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
    loadLanguage(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/ic_user"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  loadLanguage(BuildContext context) {
    getSharePref().then((value) {
      if (value == Constrain.ENGLISH) {
        log('English');
        // ChangeLanguage.language = 'en';
        setState(() {
          Get.updateLocale(const Locale('en', 'US'));
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MenuScreen(),
          ),
        );
      } else {
        log('Khmer');
        // ChangeLanguage.language = 'kh';
        setState(() {
          Get.updateLocale(const Locale('kh', 'KH'));
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MenuScreen(),
          ),
        );
      }
    });
  }

  Future<String?> getSharePref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constrain.LANGUAGE).toString();
  }
}
