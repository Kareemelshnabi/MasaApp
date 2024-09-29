import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/profile/profile_controller.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/function/handling_data.dart';
import 'package:mas_app/data/data%20source/orders.dart';
import 'package:mas_app/data/model/order_model.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/profile/edit_profile.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class MyOrderInfoController extends GetxController {
  TextEditingController controllerArea = TextEditingController();
  TextEditingController controllerBloc = TextEditingController();
  TextEditingController controllerStreet = TextEditingController();
  TextEditingController controllerHouseNum = TextEditingController();
  TextEditingController controllerGovernorate = TextEditingController();
  StatuesRequest statuesRequest = StatuesRequest.none;
  OrdersRemoteData ordersRemoteData = OrdersRemoteData(Get.put(Api()));

  bool edit = false;
  bool showInfo = false;
  bool showAddress = false;
  int? typeIndex;
  String? page;
  Map<String, dynamic> order = {};
  OrderModel? orderModel;
  changeShow(show) {
    if (show == "info" && showInfo == false) {
      showInfo = true;
      update();
    } else if (show == "info" && showInfo == true) {
      showInfo = false;
      update();
    } else if (show == "address" && showAddress == false) {
      showAddress = true;
      update();
    } else if (show == "address" && showAddress == true) {
      showAddress = false;
      update();
    }
  }

  canEdit() {
    if (edit == true) {
      edit = false;
      update();
    } else {
      edit = true;
      update();
    }
  }

  showMessage() {
    Get.defaultDialog(
        titlePadding: EdgeInsets.only(top: 7.w),
        titleStyle: GoogleFonts.tajawal(
            color: LightMode.registerButtonBorder,
            fontSize: 5.w,
            fontWeight: FontWeight.bold),
        backgroundColor: LightMode.registerText,
        title: S.of(Get.context!).deliveryAddress,
        content: Container(
          padding: EdgeInsets.all(5.w),
          width: 100.w,
          height: 18.h,
          child: Column(
            children: [
              Text(
                S.of(Get.context!).messageAddress,
                style: GoogleFonts.tajawal(
                    color: LightMode.registerButtonBorder,
                    fontSize: 4.w,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      ProfileController controller =
                          Get.put(ProfileController());
                      controller.englishNameController.text =
                          sharedPreferences!.getString("nameEn")!;
                      controller.emailController.text =
                          sharedPreferences!.getString("email")!;
                      controller.phoneController.text =
                          sharedPreferences!.getString("phone")!;
                      controller.imagerequest =
                          sharedPreferences!.getString("img")!;
                      controller.addressController.text =
                          sharedPreferences!.getString("address")!;
                      controller.countryController.text =
                          sharedPreferences!.getString("country")!;
                      controller.governorateController.text =
                          sharedPreferences!.getString("governorate")!;

                      Get.to(() => const EditProfile());
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
                          S.of(Get.context!).yes,
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
                        border: Border.all(color: LightMode.splash, width: 2),
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      width: 30.w,
                      height: 5.h,
                      child: Center(
                        child: Text(
                          S.of(Get.context!).no,
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

  messageHandleException(message) {
    Get.defaultDialog(
        title: S.of(Get.context!).error,
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

  getOrderById(orderId) async {
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await ordersRemoteData.getOrderById(
        sharedPreferences!.getString("token"), orderId);
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      dynamic responseBody = response['data'];
      orderModel = OrderModel.fromJson(responseBody);
    }else if (statuesRequest == StatuesRequest.socketException) {
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

  @override
  void onInit() {
    page = Get.arguments['page'];
    controllerArea.text = sharedPreferences!.getString("country")!;
    controllerArea.text = "الكويت";
    controllerBloc.text = sharedPreferences!.getString("address")!;
    controllerGovernorate.text = sharedPreferences!.getString("governorate")!;
    order = Get.arguments["data"];
    orderModel = OrderModel.fromJson(order);

    super.onInit();
  }
}
