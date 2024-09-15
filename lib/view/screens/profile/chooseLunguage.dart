// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ChooseLunguage extends StatelessWidget {
  const ChooseLunguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightMode.splash,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBarProfile(),
            Container(
              width: 100.w,
              height: 90.h,
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.only(top: 5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.w),
                    topRight: Radius.circular(4.w)),
                color: LightMode.registerText,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "اللغة",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.tajawal(
                          fontSize: 4.w,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Icon(
                        Icons.translate,
                        color: LightMode.splash,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  btnClick(() {
                  //  sharedPreferences!.setString("local", "ar");
                    Get.off(() => const Home());
                  }, "العربية"),
                  SizedBox(
                    height: 3.w,
                  ),
                  btnClick(() {
                 //   sharedPreferences!.setString("local", "en");
                    Get.off(() => const Home());
                  }, "English")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget btnClick(onPress, lang) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.w),
        border: Border(
            bottom: BorderSide(
                color: LightMode.registerButtonBorder.withOpacity(.2),
                width: 3))),
    width: 50.w,
    height: 5.h,
    child: ElevatedButton(
        onPressed: onPress,
        child: Text(
          lang,
          style:
              GoogleFonts.tajawal(fontSize: 3.5.w, fontWeight: FontWeight.w500),
        )),
  );
}

Widget appBarProfile() {
  return SizedBox(
    width: 100.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(top: 7.w),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: LightMode.registerText,
                )),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h, right: 23.w),
            child: Text(
              "اختر اللغة",
              style: GoogleFonts.tajawal(
                fontSize: 5.w,
                fontWeight: FontWeight.bold,
                color: LightMode.registerText,
              ),
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    ),
  );
}
