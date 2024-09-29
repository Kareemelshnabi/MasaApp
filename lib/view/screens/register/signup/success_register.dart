import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class SuccessRegister extends StatefulWidget {
  const SuccessRegister({super.key});

  @override
  State<SuccessRegister> createState() => _SuccessRegisterState();
}

class _SuccessRegisterState extends State<SuccessRegister> {
  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 3000),
      () async {
        sharedPreferences!.setBool("visit", false);
        await sharedPreferences!.setString("pageStart", "Home");
        Get.offAll(() => const Home(),
            transition: Transition.upToDown,
            duration: const Duration(milliseconds: 800));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImagesLink.successLoginImage,
              width: 50.w,
              height: 15.h,
              fit: BoxFit.fill,
            ),
            textSuccess()
          ],
        ),
      ),
      //     ),
    );
  }

  Widget textSuccess() {
    return Container(
      margin: EdgeInsets.only(top: 5.w),
      width: 90.w,
      child: Text(
        S.of(context).succsesSign,
        textAlign: TextAlign.center,
        style: GoogleFonts.tajawal(
          fontSize: 5.w,
          fontWeight: FontWeight.w500,
          color: sharedPreferences!.getBool("darkMode") == false
              ? LightMode.registerButtonBorder
              : DarkMode.whiteDarkColor,
        ),
      ),
    );
  }
}
