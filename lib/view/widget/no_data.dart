import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/main.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

Widget noData(text) {
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    height: 10.h,
    width: 60.w,
    child: DottedBorder(
      dashPattern: const [8, 4],
      radius: const Radius.circular(10),
      strokeWidth: 1.5,
      borderType: BorderType.RRect,
      color: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.splash
          : DarkMode.whiteDarkColor,
      child: Center(
        child: Text(
          text,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: GoogleFonts.tajawal(
              fontSize: 3.5.w,
              fontWeight: FontWeight.bold,
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.splash
                  : DarkMode.whiteDarkColor),
        ),
      ),
    ),
  );
}
