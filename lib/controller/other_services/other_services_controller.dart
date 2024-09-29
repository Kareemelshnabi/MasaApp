// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/function/handling_data.dart';
import 'package:mas_app/data/data%20source/services.dart';
import 'package:mas_app/data/model/service_model.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class OtherServicesController extends GetxController {
  List<ServiceModel> services = [];
  StatuesRequest statuesRequest = StatuesRequest.none;
  ServicesRemoteData servicesRemoteData = ServicesRemoteData(Get.put(Api()));
  getServices() async {
    services.clear();
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await servicesRemoteData.getData();
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      List responseBody = response['data']['items'];
      for (int index = 4; index < responseBody.length; index++) {
        services.add(ServiceModel.fromJson(responseBody[index]));
      }
      return services;

    } else if (statuesRequest == StatuesRequest.socketException) {
      messageHandleException(
         S.of(Get.context!).noInternetApi);
    } else if (statuesRequest == StatuesRequest.serverException) {
      messageHandleException(S.of(Get.context!).serverException);
    } else if (statuesRequest == StatuesRequest.unExpectedException) {
      messageHandleException(S.of(Get.context!).unExcepectedException);
    } else if (statuesRequest == StatuesRequest.defaultException) {
      messageHandleException(S.of(Get.context!).defultException);
    } else if (statuesRequest == StatuesRequest.serverError) {
      messageHandleException(
         S.of(Get.context!).serverError);
    } else if (statuesRequest == StatuesRequest.timeoutException) {
      messageHandleException(
         S.of(Get.context!).timeOutException);
    } else if (statuesRequest == StatuesRequest.unauthorizedException) {
      messageHandleException(
         S.of(Get.context!).errorUnAuthorized);
    }
    update();
  }

  messageHandleException(message) {
    Get.defaultDialog(
        title:S.of(Get.context!).error,
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
                   S.of(Get.context!).tryAgain,
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
