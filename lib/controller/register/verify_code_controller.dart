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
import 'package:mas_app/view/screens/register/signup/success_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class VerifyCodeController extends GetxController {
  String verifyCodeRegister = "";
  String verifyCodeLogin = "";
  String verifyCodeForgetPass = "";

  StatuesRequest statuesRequest = StatuesRequest.none;
  RegisterRemoteData registerRemoteData = RegisterRemoteData(Get.put(Api()));

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

  verifySign(context) async {
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await registerRemoteData.verifySign(
      sharedPreferences!.getString("phone"),
      verifyCodeRegister,
    );
    print(response);

    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      dynamic responseBody = response['data'];
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
      sharedPreferences!.setString("lat", "${responseBody['lat']}");
      sharedPreferences!.setString("lng", "${responseBody['lng']}");
      sharedPreferences!
          .setString("governorateId", "${responseBody['governorate']['id']}");

      sharedPreferences!
          .setString("governorate", "${responseBody['governorate']['name']}");
      print(sharedPreferences!.getString("governorate"));
      sharedPreferences!.setString("pageStart", "Home");
      Get.offAll(() => const SuccessRegister());
    } else if (statuesRequest == StatuesRequest.unprocessableException) {
      messageHandleException("رقم الهاتف مسجل من قبل", context);
    } else if (statuesRequest == StatuesRequest.socketException) {
      messageHandleException(S.of(context).noInternetApi, context);
    } else if (statuesRequest == StatuesRequest.serverException) {
      messageHandleException(S.of(context).serverException, context);
    } else if (statuesRequest == StatuesRequest.unExpectedException) {
      messageHandleException(S.of(context).unExcepectedException, context);
    } else if (statuesRequest == StatuesRequest.defaultException) {
      messageHandleException(S.of(context).errorPhoneUseBeforeApi, context);
    } else if (statuesRequest == StatuesRequest.serverError) {
      messageHandleException(S.of(context).serverError, context);
    } else if (statuesRequest == StatuesRequest.timeoutException) {
      messageHandleException(S.of(context).timeOutException, context);
    } else if (statuesRequest == StatuesRequest.unauthorizedException) {
      messageHandleException(S.of(context).errorUnAuthorized, context);
    }
  }

  reSendOtp(context) async {
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await registerRemoteData.reSendOtp(
      sharedPreferences!.getString("phone"),
    );
    print(response);

    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      dynamic responseBody = response['data'];
      print("response :: $responseBody");
    } else if (statuesRequest == StatuesRequest.unprocessableException) {
      messageHandleException("رقم الهاتف مسجل من قبل", context);
    } else if (statuesRequest == StatuesRequest.socketException) {
      messageHandleException(S.of(context).noInternetApi, context);
    } else if (statuesRequest == StatuesRequest.serverException) {
      messageHandleException(S.of(context).serverException, context);
    } else if (statuesRequest == StatuesRequest.unExpectedException) {
      messageHandleException(S.of(context).unExcepectedException, context);
    } else if (statuesRequest == StatuesRequest.defaultException) {
      messageHandleException(S.of(context).errorPhoneUseBeforeApi, context);
    } else if (statuesRequest == StatuesRequest.serverError) {
      messageHandleException(S.of(context).serverError, context);
    } else if (statuesRequest == StatuesRequest.timeoutException) {
      messageHandleException(S.of(context).timeOutException, context);
    } else if (statuesRequest == StatuesRequest.unauthorizedException) {
      messageHandleException(S.of(context).errorUnAuthorized, context);
    }
  }

verifyResetPass(context)async{


}
}
