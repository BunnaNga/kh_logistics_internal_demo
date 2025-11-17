import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/splash_screen.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/app_preference.dart';
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  int selectedLanguageIndex = 0;

  @override
  initState() {
    loadLanguage(context);
    super.initState();
  }

  void loadLanguage(BuildContext context) {
    getSharePref().then((value) {
      if (value == Constrain.ENGLISH) {
        setState(() {
          selectedLanguageIndex = 2;
          log('Selected Language Index: $selectedLanguageIndex');
        });
      } else {
        setState(() {
          selectedLanguageIndex = 1;
          log('Selected Language Index: $selectedLanguageIndex');
        });
      }
    });
  }

  Future<String?> getSharePref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constrain.LANGUAGE).toString();
  }

  Future setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await Preference().setLanguage(prefs, language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('change_language'.tr),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              selectedLanguageIndex == 2
                  ? Get.updateLocale(const Locale('km', 'KH'))
                  : null;
              await setLanguage(Constrain.KHMER);

              setState(() {
                selectedLanguageIndex = 1;
              });
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SplashScreen()),
                  (route) => false);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedLanguageIndex == 1
                        ? AppColor.baseColors
                        : AppColor.background_color,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: AppColor.baseColors),
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage("assets/images/cambodia.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          'ភាសាខ្មែរ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () async {
              await setLanguage(Constrain.ENGLISH);
              selectedLanguageIndex == 1
                  ? Get.updateLocale(const Locale('en', 'US'))
                  : null;

              setState(() {
                selectedLanguageIndex = 2;
              });
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SplashScreen()),
                  (route) => false);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedLanguageIndex == 2
                        ? AppColor.baseColors
                        : AppColor.background_color,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: AppColor.baseColors),
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/united_state.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          'English',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
