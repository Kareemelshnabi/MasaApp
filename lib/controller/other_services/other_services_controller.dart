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

      //services.addAll(responseBody.map((e) => ServiceModel.fromJson(e)));      print("response :: $responseBody");
    } else if (statuesRequest == StatuesRequest.socketException) {
      messageHandleException(
          "لا يوجد اتصال بالإنترنت. يرجى التحقق من اتصالك والمحاولة مرة أخرى");
    } else if (statuesRequest == StatuesRequest.serverException) {
      messageHandleException("لم يتم العثور على المورد المطلوب.");
    } else if (statuesRequest == StatuesRequest.unExpectedException) {
      messageHandleException("حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.");
    } else if (statuesRequest == StatuesRequest.defaultException) {
      messageHandleException("فشل إكمال العملية. الرجاء المحاولة مرة أخرى");
    } else if (statuesRequest == StatuesRequest.serverError) {
      messageHandleException(
          "الخادم غير متاح حاليًا. يرجى المحاولة مرة أخرى لاحقًا");
    } else if (statuesRequest == StatuesRequest.timeoutException) {
      messageHandleException(
          "انتهت مهلة الطلب. يرجى المحاولة مرة أخرى لاحقًا.");
    } else if (statuesRequest == StatuesRequest.unauthorizedException) {
      messageHandleException(
          "تم الوصول بشكل غير مصرح به. يرجى التحقق من بيانات الاعتماد الخاصة بك والمحاولة مرة أخرى.");
    }
    update();
  }

  messageHandleException(message) {
    Get.defaultDialog(
        title: "خطأ",
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
                    "اعادة المحاولة",
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
