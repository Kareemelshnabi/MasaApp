// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/function/handling_data.dart';
import 'package:mas_app/data/data%20source/orders.dart';
import 'package:mas_app/data/data%20source/search.dart';
import 'package:mas_app/data/data%20source/services.dart';
import 'package:mas_app/data/model/product_model.dart';
import 'package:mas_app/data/model/service_model.dart';
import 'package:mas_app/data/model/store_order_model.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/main_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePageController extends GetxController {
  SpeechToText speechToText = SpeechToText();

  bool speechEnabled = false;
  // String wordsSpoken = "";
  double confidenceLevel = 0;
  void initSpeech() async {
    print("initialized");
    speechEnabled = await speechToText.initialize();
    print(speechEnabled);
    update();
  }

  void startListening() async {
    await speechToText.listen(
      onResult: onSpeechResult,
      // translate to arabic => by default english
      localeId: "ar",
    );

    confidenceLevel = 0;
    update();
  }

  void stopListening() async {
    await speechToText.stop();
    update();
  }

  void onSpeechResult(result) async {
    searchController.text = "${result.recognizedWords}";
    print("  result >>${result.recognizedWords}");
    if (searchController.text == "") {
      isSearch = false;
      update();
    } else {
      isSearch = true;
      await search();
      update();
    }
    confidenceLevel = result.confidence;
    update();
  }

  TextEditingController searchController = TextEditingController();
  List<ServiceModel> services = [];
  StatuesRequest statuesRequest = StatuesRequest.none;
  ServicesRemoteData servicesRemoteData = ServicesRemoteData(Get.put(Api()));
  SearchRemoteData searchRemoteData = SearchRemoteData(Get.put(Api()));

  bool isSearch = false;
  List<ProductModel> searchItems = [];
  bool succsess = false;
  OrdersRemoteData ordersRemoteData = OrdersRemoteData(Get.put(Api()));

  StoreOrderModel? storeOrderModel;
  String lat = '';
  String lng = '';

  storeOrder(orderId, orderType, orderQuantity) async {
    succsess = false;
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await ordersRemoteData.storeOrder(
        sharedPreferences!.getString("token"),
        orderId.toString(),
        orderType.toString(),
        orderQuantity.toString(),
        sharedPreferences!.getString("lat"),
        sharedPreferences!.getString("lng"));
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      Map<String, dynamic> responseBody = response['data'];

      storeOrderModel = StoreOrderModel.fromJson(responseBody);
      succsess = true;
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

  checkSearch(String value) async {
    print(value);
    if (value == "") {
      isSearch = false;
      update();
    } else {
      isSearch = true;
      await search();
      update();
    }
  }

  message(message) {
    Get.defaultDialog(
        title: "خطأ",
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                    fontSize: 3.5.w,
                    color: LightMode.registerButtonBorder,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.off(() => const MainRegister());
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
                          "إنشاء حساب",
                          style: GoogleFonts.tajawal(
                              fontSize: 4.w,
                              color: LightMode.registerText,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: LightMode.splash),
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      width: 30.w,
                      height: 5.h,
                      child: Center(
                        child: Text(
                          "إلغاء",
                          style: GoogleFonts.tajawal(
                              fontSize: 4.w,
                              color: LightMode.splash,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  search() async {
    searchItems.clear();
    print("  search    .... $searchItems");
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await searchRemoteData.getData(searchController.text);
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      List responseBody = response['data']['items'];
      searchItems = [];
      searchItems.addAll(responseBody.map((e) => ProductModel.fromJson(e)));
      print("search item >>>>> $searchItems");
      //return searchItems;
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

  getServices() async {
    services.clear();
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await servicesRemoteData.getData();
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      List responseBody = response['data']['items'];
      if (responseBody.isEmpty) {
      } else {
        for (int index = 0;
            responseBody.length == 1
                ? index < 1
                : responseBody.length == 2
                    ? index < 2
                    : responseBody.length == 3
                        ? index < 3
                        : index < 4;
            index++) {
          services.add(ServiceModel.fromJson(responseBody[index]));
        }
      }
      //  return services;
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

  @override
  void onInit() {
    // sharedPreferences!.clear();
    initSpeech();

    // getLocation();
    getServices();

    super.onInit();
  }
}
