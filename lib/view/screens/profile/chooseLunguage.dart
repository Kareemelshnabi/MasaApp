// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/dark_mode_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ChooseLunguage extends StatelessWidget {
  const ChooseLunguage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DarkModeController());
    return Scaffold(
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.splash
          : DarkMode.darkModeSplash,
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
                border: sharedPreferences!.getBool("darkMode") == false
                    ? null
                    : Border(top: BorderSide(color: DarkMode.buttonDarkColor)),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.w),
                    topRight: Radius.circular(4.w)),
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.registerText
                    : DarkMode.darkModeSplash,
              ),
              child: GetBuilder<DarkModeController>(
                builder: (controller) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).lang,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            color:
                                sharedPreferences!.getBool("darkMode") == false
                                    ? LightMode.registerButtonBorder
                                    : DarkMode.whiteDarkColor,
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
                    btnClick(() async {
                      controller.changLang("ar");
                    }, "العربية"),
                    SizedBox(
                      height: 3.w,
                    ),
                    btnClick(() async {
                      controller.changLang("en");
                    }, "English")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget btnClick(onPress, lang) {
  return sharedPreferences!.getBool("darkMode") == false
      ? Container(
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
                style: GoogleFonts.tajawal(
                  fontSize: 3.5.w,
                  fontWeight: FontWeight.w500,
                ),
              )),
        )
      : InkWell(
          onTap: onPress,
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? null
                      : DarkMode.white_2DarkColor,
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border(
                      bottom: BorderSide(
                          color: LightMode.registerButtonBorder.withOpacity(.2),
                          width: 3))),
              width: 50.w,
              height: 5.h,
              child: Text(
                lang,
                style: GoogleFonts.tajawal(
                  fontSize: 3.5.w,
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? null
                      : DarkMode.whiteDarkColor,
                  fontWeight: FontWeight.w500,
                ),
              )),
        );
}

Widget appBarProfile() {
  return SizedBox(
    width: 100.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 20.w,
          child: Padding(
            padding: EdgeInsets.only(top: 7.w),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  size: 6.w,
                  Icons.arrow_back_ios,
                  color: LightMode.registerText,
                )),
          ),
        ),
        SizedBox(
          width: 60.w,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h),
            child: Text(
              S.of(Get.context!).lang,
              style: GoogleFonts.tajawal(
                fontSize: 5.w,
                fontWeight: FontWeight.bold,
                color: LightMode.registerText,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    ),
  );
}
