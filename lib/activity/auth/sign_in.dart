import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/api/auth_request.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Image.asset('assets/images/kh_logistic_logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextField(
                controller: usernameController,
                cursorColor: AppColor.baseColors,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.background_color,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppColor.baseColors,
                  ),
                  hintText: 'username'.tr,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColor.baseColors),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColor.baseColors),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextField(
                controller: passwordController,
                cursorColor: AppColor.baseColors,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.background_color,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppColor.baseColors,
                  ),
                  hintText: 'password'.tr,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColor.baseColors),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColor.baseColors),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
            InkWell(
              onTap: () async {
                Auth().login(
                    context, usernameController.text, passwordController.text);
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.baseColors,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'sign_in'.tr,
                    style: TextStyle(
                        color: AppColor.whiteTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'ភាសាខ្មែរ',
                      style: TextStyle(color: AppColor.baseColors),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'English',
                      style: TextStyle(color: AppColor.baseColors),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
