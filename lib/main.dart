import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/locale.dart';
import 'package:kh_logistics_internal_demo/util/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColor.baseColors, // background color
      statusBarIconBrightness: Brightness.light, // white icons
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      // fallbackLocale: Locale('km', 'KH'),
      fallbackLocale: Locale('en', 'US'),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.background_color,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.baseColors,
          foregroundColor: AppColor.whiteTextColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColor.baseColors,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}
