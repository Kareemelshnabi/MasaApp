import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/register/login_controller.dart';
import 'package:mas_app/controller/register/register_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class VerifyCodeController extends GetxController {
  String verifyCodeRegister = "";
  String verifyCodeLogin = "";
  String verifyCodeForgetPass = "";

  StatuesRequest statuesRequest = StatuesRequest.none;
  RegisterController signcontroller = Get.put(RegisterController());
  LoginController loginController = Get.put(LoginController());

 
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
