import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/register/login_controller.dart';
import 'package:mas_app/controller/register/register_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/view/screens/register/login/succcess_login.dart';
import 'package:mas_app/view/screens/register/signup/success_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class VerifyCodeController extends GetxController {
  String verifyCodeRegister = "";
  String verifyCodeLogin = "";
  String verifyCodeForgetPass = "";

  StatuesRequest statuesRequest = StatuesRequest.none;
  RegisterController signcontroller = Get.put(RegisterController());
  LoginController loginController = Get.put(LoginController());

  Future<void> verifyCodeSign() async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: signcontroller.verificationId,
        smsCode: verifyCodeRegister,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAll(() => const SuccessRegister());

      print('Phone number verified successfully!');
    } catch (e) {
      messageHandleException("الكود المدخل خطأ", Get.context);
      print('Error verifying code: $e');
    }
  }

  Future<void> verifyCodeLoginController() async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: loginController.verificationId,
        smsCode: verifyCodeLogin,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAll(() => const SuccessLogin());

      print('Phone number verified successfully!');
    } catch (e) {
      messageHandleException("الكود المدخل خطأ", Get.context);
      print('Error verifying code: $e');
    }
  }

  messageHandleException(message, context) {
    Get.defaultDialog(
        title: S.of(context).error,
        content: Column(
          children: [
            Text(
              message,
              style: GoogleFonts.tajawal(
                  fontSize: 3.5.w,
                  color: LightMode.registerButtonBorder,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5.w,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: LightMode.splash,
                  borderRadius: BorderRadius.circular(3.w),
                ),
                width: 30.w,
                height: 5.h,
                child: Center(
                  child: Text(
                    S.of(context).tryAgain,
                    style: GoogleFonts.tajawal(
                        fontSize: 4.w,
                        color: LightMode.registerText,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
