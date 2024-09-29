import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/function/handling_data.dart';
import 'package:mas_app/data/data%20source/orders.dart';
import 'package:mas_app/data/model/order_model.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/chat/chat.dart';
import 'package:mas_app/view/screens/orders/my_order_info.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class FirebaseNotification {
  StatuesRequest statuesRequest = StatuesRequest.none;
  OrdersRemoteData ordersRemoteData = OrdersRemoteData(Get.put(Api()));
  OrderModel? orderModel;

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
    Get.appUpdate();
    var response = await ordersRemoteData.getOrderById(
        sharedPreferences!.getString("token"), orderId);
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      dynamic responseBody = response['data'];
      orderModel = OrderModel.fromJson(responseBody);
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
    Get.appUpdate();
  }

  final firebaseMessagin = FirebaseMessaging.instance;

  Future<void> intilizeNotification() async {
    await firebaseMessagin.requestPermission();
    String? token = await firebaseMessagin.getToken();
    log("$token");
    handelBackGround();
  }

  // handel notification
  void handelMassage(RemoteMessage? remotemess) async {
    if (remotemess == null) return;
    log("1");
    log("${remotemess.data}");
    if (remotemess.data['chat_id'] != "" &&
        remotemess.data['chat_id'] != null &&
        remotemess.data['chat_name'] != "" &&
        remotemess.data['chat_name'] != null) {
      Get.to(() => const ChatPage(), arguments: {
        "nameOfOrder": remotemess.data['chat_name'],
        "chatId": int.parse(remotemess.data['chat_id'].toString()),
        "imageUser": sharedPreferences!.getString("img")
      });
    } else if (remotemess.data['order_id'] != "" &&
        remotemess.data['order_id'] != null) {
      // log("hhh" + remotemess.data['order_id']);
      await getOrderById(remotemess.data['order_id']);
      print(orderModel);
      Get.to(() => const MyOrderInfo(),
          arguments: {"page": "page", "data": orderModel!.toJson()});
    } else {}
  }

  Future<void> handelBackGround() async {
    firebaseMessagin.getInitialMessage().then(handelMassage);
    FirebaseMessaging.onMessageOpenedApp.listen(handelMassage);
  }
}
