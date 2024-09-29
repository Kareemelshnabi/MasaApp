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

class SuccessLogin extends StatefulWidget {
  const SuccessLogin({super.key});

  @override
  State<SuccessLogin> createState() => _SuccessLoginState();
}

class _SuccessLoginState extends State<SuccessLogin> {
  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 3000),
      () {
        sharedPreferences!.setBool("visit", false);
        Get.off(() => const Home(),
            transition: Transition.upToDown,
            duration: const Duration(milliseconds: 800));
        sharedPreferences!.setString("pageStart", "Home");
        print(sharedPreferences!.getString("pageStart"));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
   
       Scaffold(
        backgroundColor:  sharedPreferences!.getBool("darkMode") == false
            ?  LightMode.registerText:DarkMode.darkModeSplash,
        body: Column(
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
    //  ),
    );
  }

  Widget textSuccess() {
    return Container(
      margin: EdgeInsets.only(top: 5.w, right: 4.w, left: 4.w),
      width: 90.w,
      child: Text(
        S.of(context).succseLogin,
        // "مرحبا بعودتك.لحظات و سيتم تحويلك للصفحة الرئيسية.",
        textAlign: TextAlign.center,
        style: GoogleFonts.tajawal(
          fontSize: 4.5.w,
          fontWeight: FontWeight.w500,
          color: sharedPreferences!.getBool("darkMode") == false
            ? LightMode.registerButtonBorder:DarkMode.whiteDarkColor,
        ),
      ),
    );
  }
}
