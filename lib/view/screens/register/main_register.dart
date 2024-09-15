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
              // Container(
              //   decoration: BoxDecoration(
              //       color: LightMode.onBoardOneCircle, shape: BoxShape.circle),
              //   padding: EdgeInsets.only(right: 2.w, left: 2.w),
              //   margin: EdgeInsets.only(top: 6.h, right: 5.w),
              //   child: IconButton(
              //       onPressed: () {
              //         Get.back();
              //       },
              //       icon: Icon(
              //         Icons.arrow_back_ios,
              //         size: 6.w,
              //         color: LightMode.onBoardOneIcon,
              //       )),
              // ),
              Container(
                height: 55.h,
                width: 100.w,
                margin: EdgeInsets.only(top: 45.h),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: LightMode.registerText),
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
                      Colors.black,
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
                          "تسجيل الدخول كزائر ؟ ",
                          style: GoogleFonts.tajawal(
                              color: LightMode.registerButtonBorder,
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
                            "نسجيل",
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
                color: LightMode.onBoardOneText,
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
                color: LightMode.registerButtonBorder,
              ),
            ),
            Text(
              " ${S.of(context).or} ",
              style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w700, fontSize: 3.5.w),
            ),
            Container(
              margin: EdgeInsets.only(left: 2.w),
              width: 20.w,
              child: Divider(
                thickness: 1,
                color: LightMode.registerButtonBorder,
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
            side: BorderSide(color: LightMode.registerButtonBorder),
            backgroundColor: Colors.white),
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
                  color: LightMode.registerButtonBorder,
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
            side: BorderSide(color: LightMode.registerButtonBorder),
            backgroundColor: Colors.white),
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
                  color: LightMode.registerButtonBorder,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
