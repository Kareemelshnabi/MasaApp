import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:mas_app/view/screens/profile/contact_us.dart';
import 'package:mas_app/view/screens/profile/faq.dart';
import 'package:mas_app/view/screens/profile/policy_page.dart';
import 'package:mas_app/view/screens/profile/services_page.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class InfoAboutUs extends StatelessWidget {
  const InfoAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      body: Column(
        children: [
          appBarMyOrders(context),
          boxClick("الأسئلة الشائعة", () {
            Get.to(() => const FaqPage());
          }),
          boxClick("سياسة الخصوصية", () {
            Get.to(() => const PolicyPage());
          }),
          boxClick("شروط الخدمة", () {
            Get.to(() => const ServicesPage());
          }),
          boxClick("تواصل معنا", () {
            Get.to(() => const ContactUs());
          }),
          boxClick("انستقرام", () {}),
          boxClick("فيسبوك", () {}),
          //     boxClick("منصة ماسا", () {}),
        ],
      ),
    );
  }
}

Widget boxClick(text, onPress) {
  return InkWell(
    onTap: onPress,
    child: Container(
      margin: EdgeInsets.only(right: 5.w, left: 5.w, top: 7.w),
      padding: EdgeInsets.only(
        right: 3.w,
        left: 2.w,
      ),
      width: 100.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: LightMode.splash),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.tajawal(
                color: LightMode.splash,
                fontSize: 4.w,
                fontWeight: FontWeight.w500),
          ),
          IconButton(
              onPressed: onPress,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: LightMode.splash,
                size: 5.w,
              ))
        ],
      ),
    ),
  );
}

Widget appBarMyOrders(context) {
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
                  Navigator.canPop(context)
                      ? Get.back()
                      : Get.off(() => const Home());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 6.w,
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? LightMode.registerButtonBorder
                      : DarkMode.whiteDarkColor,
                )),
          ),
        ),
        SizedBox(
          width: 60.w,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h),
            child: Text(
              "معلومات عنا",
              style: GoogleFonts.tajawal(
                fontSize: 5.w,
                fontWeight: FontWeight.bold,
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.typeUserTitle
                    : DarkMode.whiteDarkColor,
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
