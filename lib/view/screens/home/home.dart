// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/home/home_controller.dart';
import 'package:mas_app/controller/profile/profile_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';

import 'package:screen_go/extensions/responsive_nums.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(ProfileController());
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        bottomNavigationBar: GetBuilder<ProfileController>(
          builder: (controllerProfile) => Container(
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: LightMode.splash, width: 2))),
            child: BottomAppBar(
              height: 8.7.h,
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.registerText
                  : DarkMode.darkModeSplash,
              notchMargin: 4.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemNavigationBar(S.of(context).homePage, () {
                    controller.changePage(0);
                  },
                      controller.currentIndex == 0
                          ? Icons.home
                          : Icons.home_outlined,
                      25.w,
                      controller.currentIndex == 0
                          ? LightMode.splash
                          : sharedPreferences!.getBool("darkMode") == false
                              ? LightMode.registerButtonBorder
                              : DarkMode.whiteDarkColor),
                  itemNavigationBar(S.of(context).favouritePage, () {
                    controller.changePage(1);
                  },
                      controller.currentIndex == 1
                          ? Icons.favorite
                          : Icons.favorite_border,
                      18.w,
                      controller.currentIndex == 1
                          ? LightMode.splash
                          : sharedPreferences!.getBool("darkMode") == false
                              ? LightMode.registerButtonBorder
                              : DarkMode.whiteDarkColor),
                  itemNavigationBar(S.of(context).cardPage, () {
                    controller.changePage(3);
                  },
                      controller.currentIndex == 3
                          ? Icons.credit_card
                          : Icons.credit_card_outlined,
                      20.w,
                      controller.currentIndex == 3
                          ? LightMode.splash
                          : sharedPreferences!.getBool("darkMode") == false
                              ? LightMode.registerButtonBorder
                              : DarkMode.whiteDarkColor),
                  itemNavigationBar(S.of(context).profilePage, () {
                    controller.changePage(4);
                  },
                      controller.currentIndex == 4
                          ? Icons.person
                          : Icons.person_2_outlined,
                      20.w,
                      controller.currentIndex == 4
                          ? LightMode.splash
                          : sharedPreferences!.getBool("darkMode") == false
                              ? LightMode.registerButtonBorder
                              : DarkMode.whiteDarkColor),
                ],
              ),
            ),
          ),
        ),
        body: controller.pages.elementAt(controller.currentIndex),
      ),
    );
  }

  Widget itemNavigationBar(text, onTap, icon, width, color) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 5.w,
              color: color,
            ),
            SizedBox(height: .5.w),
            Text(
              text,
              style: GoogleFonts.tajawal(
                  color: color, fontWeight: FontWeight.w500, fontSize: 2.5.w),
            )
          ],
        ),
      ),
    );
  }
}
