// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/forget_pass/verify_code_forgetpass.dart';
import 'package:mas_app/view/screens/register/main_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/colors.dart';
import '../../core/function/handling_data.dart';
import '../../data/data source/register.dart';

class ForgetPasswordController extends GetxController {
  GlobalKey<FormState> addNewPassGlobalKey = GlobalKey();
  GlobalKey<FormState> forgetPassGlobalKey = GlobalKey();

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordConfirmationController =
      TextEditingController();
  StatuesRequest statuesRequest = StatuesRequest.none;
  RegisterRemoteData registerRemoteData = RegisterRemoteData(Get.put(Api()));

  bool showPass_1 = true;
  bool showPass_2 = true;
  showPassword_1() {
    if (showPass_1 == false) {
      showPass_1 = true;
      update();
    } else {
      showPass_1 = false;
      update();
    }
  }

  showPassword_2() {
    if (showPass_2 == false) {
      showPass_2 = true;
      update();
    } else {
      showPass_2 = false;
      update();
    }
  }

  passwordValidate(String val, context) {
    if (val.isEmpty) {
      return S.of(context).errorPass_1;
    } else if (val.length < 8) {
      return S.of(context).errorPass_2;
    } else if (val.length > 20) {
      return S.of(context).errorPass_3;
    } else {
      return null;
    }
  }

  passwordConfirmationValidate(String val, context) {
    if (val.isEmpty) {
      return S.of(context).errorPhone_1;
    } else if (passwordController.text != passwordConfirmationController.text) {
      return S.of(context).errorConfirmPass_2;
    } else {
      return null;
    }
  }

  bool isValidPhoneNumber(String phoneNumber) {
    String p = r'^(?:\+965)?[5692]\d{7}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(phoneNumber);
  }

  phoneValidate(String val, context) {
    if (val.isEmpty) {
      return S.of(context).errorPhone_1;
    } else if (val.length < 8 || val.length > 8) {
      return S.of(context).errorPhone_3;
    } else {
      return null;
    }
  }

  addNewPass(context) async {
    if (addNewPassGlobalKey.currentState!.validate()) {
      statuesRequest = StatuesRequest.loading;
      update();

      var response = await registerRemoteData.forgetPassword(
          phoneController.text, passwordController.text);
      print(response);
      statuesRequest = handlingData(response);
      if (statuesRequest == StatuesRequest.success) {
        Map responseBody = response['data'];
        print("response :: $responseBody");
        sharedPreferences!.setString(
            "phone",
            responseBody['phone'].toString().contains("+965")
                ? responseBody['phone']
                : "+965${responseBody['phone']}");
        sharedPreferences!.setString("email", responseBody['email']);

        sharedPreferences!.setString("token", "${responseBody['token']}");
        sharedPreferences!
            .setString("country", "${responseBody['country']['name']}");
        sharedPreferences!.setString("address", "${responseBody['address']}");
        sharedPreferences!.setString("nameEn", "${responseBody['name']}");
        sharedPreferences!.setString("img", "${responseBody['image']}");

        sharedPreferences!
            .setString("governorateId", "${responseBody['governorate']['id']}");

        sharedPreferences!
            .setString("governorate", "${responseBody['governorate']['name']}");
        print(sharedPreferences!.getString("governorate"));

        sharedPreferences!.setString("pageStart", "typeOfUser");
        Get.off(() => const MainRegister());
      } else if (statuesRequest == StatuesRequest.unprocessableException) {
        messageHandleException(S.of(context).phoneNoteRegister, context);
      } else if (statuesRequest == StatuesRequest.socketException) {
        messageHandleException(S.of(context).noInternetApi, context);
      } else if (statuesRequest == StatuesRequest.serverException) {
        messageHandleException(S.of(context).serverException, context);
      } else if (statuesRequest == StatuesRequest.unExpectedException) {
        messageHandleException(S.of(context).unExcepectedException, context);
      } else if (statuesRequest == StatuesRequest.defaultException) {
        messageHandleException(S.of(context).errorForgetPass, context);
      } else if (statuesRequest == StatuesRequest.serverError) {
        messageHandleException(S.of(context).serverError, context);
      } else if (statuesRequest == StatuesRequest.timeoutException) {
        messageHandleException(S.of(context).timeOutException, context);
      } else if (statuesRequest == StatuesRequest.unauthorizedException) {
        messageHandleException(S.of(context).passwordNotCorrect, context);
      }
    } else {
      messageHandleException(S.of(context).errorConfirmPrivacy, context);
    }
    update();
  }

  forgetPass(context) async {
    if (forgetPassGlobalKey.currentState!.validate()) {
      statuesRequest = StatuesRequest.loading;
      update();
      var response = await registerRemoteData.sendOtpToResetPass(
        phoneController.text,
      );
      print(response);
      statuesRequest = handlingData(response);
      if (statuesRequest == StatuesRequest.success) {
        dynamic responseBody = response['data'];
        print("response :: $responseBody");

        sharedPreferences!.setString("pageStart", "verifyForgetPass");
        Get.to(() => const VerifyCodeForgetpass());
      } else if (statuesRequest == StatuesRequest.unprocessableException) {
        messageHandleException("${response['message']}", context);
      } else if (statuesRequest == StatuesRequest.socketException) {
        messageHandleException(S.of(context).noInternetApi, context);
      } else if (statuesRequest == StatuesRequest.serverException) {
        messageHandleException(S.of(context).serverException, context);
      } else if (statuesRequest == StatuesRequest.unExpectedException) {
        messageHandleException(S.of(context).unExcepectedException, context);
      } else if (statuesRequest == StatuesRequest.defaultException) {
        messageHandleException(S.of(context).errorForgetPass, context);
      } else if (statuesRequest == StatuesRequest.serverError) {
        messageHandleException(S.of(context).serverError, context);
      } else if (statuesRequest == StatuesRequest.timeoutException) {
        messageHandleException(S.of(context).timeOutException, context);
      } else if (statuesRequest == StatuesRequest.unauthorizedException) {
        messageHandleException(S.of(context).passwordNotCorrect, context);
      } else if (statuesRequest == StatuesRequest.badRequestException) {
        messageHandleException(S.of(context).phoneNoteRegister, context);
      }
    } else {
      messageHandleException(S.of(context).errorConfirmPrivacy, context);
    }
    update();
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
