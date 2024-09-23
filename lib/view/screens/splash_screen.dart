import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:mas_app/view/screens/register/main_register.dart';
import 'package:mas_app/view/screens/register/signup/verify_code_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

import 'on_boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        print("page>>>>>> ${sharedPreferences!.getString("pageStart")}");

        if (sharedPreferences!.getString("pageStart") == "typeOfUser") {
          Get.off(() => const MainRegister());
        } else if (sharedPreferences!.getString("pageStart") == "Home") {
          Get.off(() => const Home());
        } else if (sharedPreferences!.getString("pageStart") ==
            "verifyregister") {
          Get.off(() => const VerifyCodeRegister());
        } else {
          Get.off(() => const OnBoarding());
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:sharedPreferences!.getBool("darkMode")==false? LightMode.splash:DarkMode.darkModeSplash,
      body: Center(
        child: SizedBox(
          width: 70.w,
          height: 15.h,
          child: Image.asset(
            ImagesLink.splashImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
