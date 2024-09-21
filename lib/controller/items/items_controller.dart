// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/function/handling_data.dart';
import 'package:mas_app/data/data%20source/orders.dart';
import 'package:mas_app/data/data%20source/products.dart';
import 'package:mas_app/data/data%20source/register.dart';
import 'package:mas_app/data/data%20source/search.dart';
import 'package:mas_app/data/model/country_model.dart';
import 'package:mas_app/data/model/product_model.dart';
import 'package:mas_app/data/model/store_order_model.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/main_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ItemsController extends GetxController {
  RegisterRemoteData registerRemoteData = RegisterRemoteData(Get.put(Api()));

  CountryMoodel? countryMoodel;
  String governorateId = '';
  String governorateName = '';
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
  int? categoryId;

  StatuesRequest statuesRequest = StatuesRequest.none;
  ProductsRemoteData productsRemoteData = ProductsRemoteData(Get.put(Api()));
  List<ProductModel> products = [];
  SearchRemoteData searchRemoteData = SearchRemoteData(Get.put(Api()));

  bool isSearch = false;
  List<ProductModel> searchItems = [];

  OrdersRemoteData ordersRemoteData = OrdersRemoteData(Get.put(Api()));
  bool succsess = false;
  StoreOrderModel? storeOrderModel;
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

  storeOrder(orderId, orderType, orderQuantity) async {
    succsess = false;
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await ordersRemoteData.storeOrder(
        sharedPreferences!.getString("token"),
        orderId.toString(),
        orderType.toString(),
        orderQuantity.toString(),
        governorateId,
        sharedPreferences!.getString("lat"),
        sharedPreferences!.getString("lng"));
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      Map<String, dynamic> responseBody = response['data'];

      storeOrderModel = StoreOrderModel.fromJson(responseBody);
      print("succse store order");
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

  checkSearch(value) async {
    if (value == "") {
      isSearch = false;
      update();
    } else {
      isSearch = true;
      await search();
      update();
    }
  }

  search() async {
    searchItems.clear();
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await searchRemoteData.getData(searchController.text);
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      List responseBody = response['data']['items'];
      searchItems = [];

      searchItems.addAll(responseBody.map((e) => ProductModel.fromJson(e)));
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

  getProducts() async {
    products.clear();
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await productsRemoteData.getData(categoryId);
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      List responseBody = response['data']['items'];

      products.addAll(responseBody.map((e) => ProductModel.fromJson(e)));
      print("response :: $products");
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

  getCountries(context) async {
    var response = await registerRemoteData.getCountry();
    print(response);

    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      Map<String, dynamic> responseBody = response['data'][0];
      print("response :: $responseBody");
      countryMoodel = CountryMoodel.fromJson(responseBody);
    } else if (statuesRequest == StatuesRequest.unprocessableException) {
      messageHandleException(
        "خطأ",
      );
    } else if (statuesRequest == StatuesRequest.socketException) {
      messageHandleException(
        S.of(context).noInternetApi,
      );
    } else if (statuesRequest == StatuesRequest.serverException) {
      messageHandleException(
        S.of(context).serverException,
      );
    } else if (statuesRequest == StatuesRequest.unExpectedException) {
      messageHandleException(
        S.of(context).unExcepectedException,
      );
    } else if (statuesRequest == StatuesRequest.defaultException) {
      messageHandleException(
        S.of(context).errorPhoneUseBeforeApi,
      );
    } else if (statuesRequest == StatuesRequest.serverError) {
      messageHandleException(
        S.of(context).serverError,
      );
    } else if (statuesRequest == StatuesRequest.timeoutException) {
      messageHandleException(
        S.of(context).timeOutException,
      );
    } else if (statuesRequest == StatuesRequest.unauthorizedException) {
      messageHandleException(
        S.of(context).passwordNotCorrect,
      );
    }

    update();
  }

  showDialogGovernate() {
    return showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 80.w,
          height: 50.h,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 5.w),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.w),
                      topRight: Radius.circular(2.w)),
                  color: LightMode.splash,
                ),
                width: 80.w,
                height: 8.h,
                child: Text(
                  "اختار محافظتك",
                  style: GoogleFonts.tajawal(
                      fontSize: 5.w,
                      color: LightMode.registerText,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 80.w,
                height: 42.h,
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            governorateId = countryMoodel!
                                .governorates![index].id
                                .toString();
                            governorateName =
                                countryMoodel!.governorates![index].name!;

                            Get.back();
                            update();
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 3.w, right: 5.w),
                            height: 6.h,
                            width: 80.w,
                            child: Text(
                              countryMoodel!.governorates![index].name!,
                              style: GoogleFonts.tajawal(
                                  fontSize: 4.w,
                                  color: LightMode.registerButtonBorder,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: countryMoodel!.governorates!.length),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

   messageAddressDelivery(onPressConfirm) {
    Get.defaultDialog(
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        title: "تأكيد العنوان",
        titleStyle: GoogleFonts.tajawal(
            fontSize: 5.w,
            color: LightMode.registerButtonBorder,
            fontWeight: FontWeight.w500),
        content: Builder(builder: (context) {
          return GetBuilder<ItemsController>(
            builder: (controller) => Container(
              margin: EdgeInsets.only(right: 3.w, left: 3.w, bottom: 3.w),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await showDialogGovernate();

                      // messageAddressDelivery(onPressConfirm);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 5.w),

                      alignment: Alignment.centerRight,
                      width: 70.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.w),
                          border: Border.all(color: LightMode.splash)),
                      child: Text(
                        governorateName,
                        style: GoogleFonts.tajawal(
                            fontSize: 4.w,
                            color: LightMode.splash,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: onPressConfirm,
                        child: Container(
                          alignment: Alignment.center,
                          width: 30.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                              color: LightMode.splash,
                              borderRadius: BorderRadius.circular(4.w),
                              border: Border.all(
                                  color: LightMode.splash, width: 2)),
                          child: Text(
                            "تأكيد",
                            style: GoogleFonts.tajawal(
                                fontSize: 4.w,
                                color: LightMode.registerText,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 30.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                              color: LightMode.registerText,
                              borderRadius: BorderRadius.circular(4.w),
                              border: Border.all(
                                  color: LightMode.splash, width: 2)),
                          child: Text(
                            "إلغاء",
                            style: GoogleFonts.tajawal(
                                fontSize: 4.w,
                                color: LightMode.splash,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
 
  @override
  void onInit() {
    governorateName = sharedPreferences!.getString("governorate") == null
        ? ""
        : sharedPreferences!.getString("governorate")!;
    governorateId = sharedPreferences!.getString("governorateId") == null
        ? ""
        : sharedPreferences!.getString("governorateId")!;

    getCountries(Get.context);
    initSpeech();
    categoryId = Get.arguments['categoryId'];
    getProducts();
    super.onInit();
  }
}
