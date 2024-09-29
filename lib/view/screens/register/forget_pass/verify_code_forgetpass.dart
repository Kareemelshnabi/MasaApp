// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/register/verify_code_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/forget_pass/add_new_password.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/constant/images.dart';

class VerifyCodeForgetpass extends StatelessWidget {
  const VerifyCodeForgetpass({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeController());
    return Scaffold(
        body: OfflineBuilder(
      connectivityBuilder: (context, ConnectivityResult value, child) {
        final bool connected = value != ConnectivityResult.none;

        if (connected) {
          return GetBuilder<VerifyCodeController>(
            builder: (controller) =>
                controller.statuesRequest == StatuesRequest.loading
                    ? SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            appBarForgetPass(),
                            Image.asset(
                              ImagesLink.verifyImage,
                              width: 60.w,
                              height: 30.h,
                              fit: BoxFit.fill,
                            ),
                            bodyVerifyCode(),
                            otpRegister(controller.verifyCodeForgetPass,
                                (String verificationCode) {
                              controller.verifyCodeForgetPass =
                                  verificationCode;
                            }),
                            onBtnClick(
                                sharedPreferences!.getString("local") == "ar"
                                    ? "إرسال"
                                    : "Send", () {
                              //controller.verifyResetPass(context);
                              Get.offAll(() => const AddNewPassword());
                            })
                          ],
                        ),
                      ),
          );
        } else {
          return SizedBox(
              height: 100.h,
              width: 100.w,
              child: const Center(child: Text("no internet ............ !")));
        }
      },
      child: const CircularProgressIndicator(),
    )
        // ),
        );
  }

  Widget onBtnClick(text, onPress) {
    return Container(
      margin: EdgeInsets.only(top: 1.h),
      width: 90.w,
      height: 6.h,
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

  Widget bodyVerifyCode() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 3.h, bottom: 3.h, right: 5.w, left: 5.w),
        child: Text(
          sharedPreferences!.getString("local") == "en"
              ? "Please enter the code sent to your phone number so you can reset your password."
              : "من فضلك قم بإدخال الرمز المرسل الى رقم الهاتف الخاص بك حتى تستطيع اعادة تعيين كلمة المرور.",
          textAlign: TextAlign.center,
          style: GoogleFonts.tajawal(
            fontSize: 3.5.w,
            fontWeight: FontWeight.w500,
            color: LightMode.typeUserBody,
          ),
        ),
      ),
    );
  }

  Widget otpRegister(verifyCode, onSubmit) {
    return Center(
      child: SizedBox(
        height: 12.h,
        width: 90.w,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: OtpTextField(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            textStyle: GoogleFonts.tajawal(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.splash
                    : DarkMode.whiteDarkColor),
            fieldWidth: 12.w,
            fieldHeight: 7.h,
            borderColor: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.registerButton
                : DarkMode.buttonDarkColor,
            borderWidth: 2,
            numberOfFields: 4,
            margin: EdgeInsets.only(right: 2.w, left: 2.w),
            fillColor: sharedPreferences!.getBool("darkMode") == false
                ? Colors.white
                : DarkMode.darkModeSplash,
            filled: false,

            borderRadius: BorderRadius.circular(20),
            showFieldAsBox: true,
            disabledBorderColor: LightMode.registerButton,
            enabledBorderColor: LightMode.registerButton,

            onSubmit: onSubmit, // end onSubmit
          ),
        ),
      ),
    );
  }

  Widget appBarForgetPass() {
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
                    sharedPreferences!.setString("pageStart", "typeOfUser");
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
          ),
          SizedBox(
            width: 60.w,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h),
              child: Text(
                sharedPreferences!.getString("local") == "ar"
                    ? "التحقق من الرمز"
                    : "verify code",
                style: GoogleFonts.tajawal(
                  fontSize: 5.w,
                  fontWeight: FontWeight.bold,
                  color: LightMode.typeUserTitle,
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w, child: Container()),
        ],
      ),
    );
  }
}
