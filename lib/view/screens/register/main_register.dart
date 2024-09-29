import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/register/register_controller.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:mas_app/view/screens/register/login/login.dart';
import 'package:mas_app/view/screens/register/signup/signup.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

import '../../../core/constant/colors.dart';
import '../../../core/constant/images.dart';

class MainRegister extends StatelessWidget {
  const MainRegister({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImagesLink.mainRegisterImage,
                ),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 55.h,
                width: 100.w,
                margin: EdgeInsets.only(top: 45.h),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerText
                        : DarkMode.darkModeSplash),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    onBtnClick(
                        // "إنشاء حساب",
                        S.of(context).signup, () {
                      sharedPreferences!.setBool("visit", false);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ));
                    }),
                    onBtnClick(

                        // "تسجيل الدخول",
                        S.of(context).login, () {
                      sharedPreferences!.setBool("visit", true);

                      Get.to(() => const LoginPage());
                    }),
                    rowOfDivider(context),
                    btnRegisterFaceAndApple(
                      () {
                        controller.messageNotEnable(context);
                      },
                      Icons.facebook_outlined,
                      // "تسجيل الدخول بواسطة الفيسبوك",
                      S.of(context).facebook,
                      Colors.blue.shade900,
                    ),
                    btnRegisterFaceAndApple(
                      () {
                        controller.messageNotEnable(context);
                      },
                      Icons.apple_outlined,
                      //   "تسجيل الدخول بواسطة الأيكلاود",
                      S.of(context).icloud,
                      sharedPreferences!.getBool("darkMode") == false
                          ? Colors.black
                          : DarkMode.whiteDarkColor,
                    ),
                    btnRegisterGoogle(() {
                      controller.messageNotEnable(context);
                    },
                        // "تسجيل الدخول بواسطة جوجل"
                        S.of(context).google),
                    SizedBox(
                      width: 2.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).mainAutrhVisitLogin,
                          style: GoogleFonts.tajawal(
                              color: sharedPreferences!.getBool("darkMode") ==
                                      false
                                  ? LightMode.registerButtonBorder
                                  : DarkMode.whiteDarkColor,
                              fontSize: 4.w,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            sharedPreferences!.setString("img", "");
                            sharedPreferences!.setBool("visit", true);
                            Get.offAll(() => const Home());
                          },
                          child: Text(
                            S.of(context).login,
                            style: GoogleFonts.tajawal(
                                color: LightMode.splash,
                                fontSize: 4.5.w,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget onBtnClick(text, onPress) {
    return Container(
      margin: EdgeInsets.only(top: 1.h),
      width: 90.w,
      height: 5.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: LightMode.typeUserButton),
          onPressed: onPress,
          child: Text(
            text,
            style: GoogleFonts.tajawal(
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.onBoardOneText
                    : DarkMode.darkModeSplash,
                fontSize: 4.w,
                fontWeight: FontWeight.w500),
          )),
    );
  }

  Widget rowOfDivider(context) {
    return Center(
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(top: 7.w, bottom: 7.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 2.w),
              width: 20.w,
              child: Divider(
                thickness: 1,
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.registerButtonBorder
                    : DarkMode.whiteDarkColor,
              ),
            ),
            Text(
              " ${S.of(context).or} ",
              style: GoogleFonts.tajawal(
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? LightMode.registerButtonBorder
                      : DarkMode.whiteDarkColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 3.5.w),
            ),
            Container(
              margin: EdgeInsets.only(left: 2.w),
              width: 20.w,
              child: Divider(
                thickness: 1,
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.registerButtonBorder
                    : DarkMode.whiteDarkColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget btnRegisterFaceAndApple(onPress, icon, text, color) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      height: 5.h,
      width: 90.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.registerButtonBorder
                    : DarkMode.whiteDarkColor),
            backgroundColor: sharedPreferences!.getBool("darkMode") == false
                ? Colors.white
                : DarkMode.darkModeSplash),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 7.w, color: color),
            SizedBox(
              width: 4.w,
            ),
            Text(
              text,
              style: GoogleFonts.tajawal(
                  fontSize: 3.5.w,
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? LightMode.registerButtonBorder
                      : DarkMode.whiteDarkColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget btnRegisterGoogle(onPress, text) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      height: 5.h,
      width: 90.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.registerButtonBorder
                    : DarkMode.whiteDarkColor),
            backgroundColor: sharedPreferences!.getBool("darkMode") == false
                ? Colors.white
                : DarkMode.darkModeSplash),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              ImagesLink.googleImage,
              width: 6.w,
              height: 6.w,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              text,
              style: GoogleFonts.tajawal(
                  fontSize: 3.5.w,
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? LightMode.registerButtonBorder
                      : DarkMode.whiteDarkColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
