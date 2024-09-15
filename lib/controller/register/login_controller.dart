// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/function/handling_data.dart';
import 'package:mas_app/data/data%20source/register.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/login/verify_code_login.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginGlobalKey = GlobalKey();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  StatuesRequest statuesRequest = StatuesRequest.none;
  RegisterRemoteData registerRemoteData = RegisterRemoteData(Get.put(Api()));
  bool showPass = true;
  String verificationId = '';

  showPassword() {
    if (showPass == false) {
      showPass = true;
      update();
    } else {
      showPass = false;
      update();
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
    } else if (!val.isPhoneNumber) {
      return S.of(context).errorPhone_2;
    } else if (!isValidPhoneNumber(val)) {
      return S.of(context).errorPhone_3;
    } else if (isValidPhoneNumber(val)) {
      return null;
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

  Future<void> verifyPhoneNumber() async {
    print("mmmmmmmmmmmmm");
    FirebaseAuth.instance.setLanguageCode('en'); // Set locale for SMS messages

    await FirebaseAuth.instance.verifyPhoneNumber(
      // phoneNumber: phoneController.text, // Example: +1234567890
      phoneNumber: "+201281265373",
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("phoneeeeeeeee");
        // Automatically sign in when the verification is completed (optional)
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle the error
        print('Phone number verification failed: ${e.message}');
      },
      codeSent: (String verifyId, int? resendToken) {
        // Save the verification ID to verify later

        verificationId = verifyId;
        update();
      },
      codeAutoRetrievalTimeout: (String verifyId) {
        print("jjjjjjjjjjj");
        verificationId = verifyId;
        update();
      },
      timeout: const Duration(seconds: 120),
      forceResendingToken: null,
    );
  }

  login(context) async {
    if (loginGlobalKey.currentState!.validate()) {
      print("nnn");
      statuesRequest = StatuesRequest.loading;
      update();
      var response = await registerRemoteData.login(
          phoneController.text, passwordController.text);
      print(response);
      statuesRequest = handlingData(response);
      if (statuesRequest == StatuesRequest.success) {
        await verifyPhoneNumber();
        Map responseBody = response['data'];
        print("response :: $responseBody");
        print("response :: ${responseBody['name']}");

        sharedPreferences!.setString("nameEn", "${responseBody['name']}");

        sharedPreferences!.setString("token", "${responseBody['token']}");

        sharedPreferences!.setString("email", "${responseBody['email']}");
        sharedPreferences!.setString("password", passwordController.text);
        sharedPreferences!.setString("address", "${responseBody['address']}");
        sharedPreferences!.setString("phone", "${responseBody['phone']}");
        sharedPreferences!.setString("img", "${responseBody['image']}");
        sharedPreferences!
            .setString("country", "${responseBody['country']['name']}");
        sharedPreferences!.setString("lat", "${responseBody['lat']}");
        sharedPreferences!.setString("lng", "${responseBody['lng']}");
        sharedPreferences!
            .setString("governorate", "${responseBody['governorate']['name']}");
        print(sharedPreferences!.getString("governorate"));
        sharedPreferences!
            .setString("governorateId", "${responseBody['governorate']['id']}");

        sharedPreferences!.setString("pageStart", "verifyLogin");
        Get.to(() => const VerifyCodeLogin());
      } else if (statuesRequest == StatuesRequest.socketException) {
        messageHandleException(S.of(context).noInternetApi, context);
      } else if (statuesRequest == StatuesRequest.serverException) {
        messageHandleException(S.of(context).serverException, context);
      } else if (statuesRequest == StatuesRequest.unExpectedException) {
        messageHandleException(S.of(context).unExcepectedException, context);
      } else if (statuesRequest == StatuesRequest.defaultException) {
        messageHandleException(S.of(context).passwordNotCorrect, context);
      } else if (statuesRequest == StatuesRequest.serverError) {
        messageHandleException(S.of(context).serverError, context);
      } else if (statuesRequest == StatuesRequest.timeoutException) {
        messageHandleException(S.of(context).timeOutException, context);
      } else if (statuesRequest == StatuesRequest.unauthorizedException) {
        messageHandleException(S.of(context).passwordNotCorrect, context);
      }
      update();
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
