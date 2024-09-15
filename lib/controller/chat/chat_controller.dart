// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/function/handling_data.dart';
import 'package:mas_app/data/data%20source/chats.dart';
import 'package:mas_app/data/data%20source/orders.dart';
import 'package:mas_app/data/model/chat_model.dart';
import 'package:mas_app/data/model/order_model.dart';
import 'package:mas_app/data/model/payment_model.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/orders/my_order_info.dart';
import 'package:mas_app/view/screens/payment/payment.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ChatController extends GetxController {
  int? chatId;
  String? nameOfOrder;
  String? imageUser;
  int typeIndex = 0;
  bool succsessConfirm = false;
  bool succsessCancel = false;
  TextEditingController messageController = TextEditingController();
  StatuesRequest statuesRequest = StatuesRequest.none;
  OrdersRemoteData ordersRemoteData = OrdersRemoteData(Get.put(Api()));

  ChatModel? chatModel;
  PaymentModel? paymentModel;
  OrderModel? orderModel;
  String redirectUrl = '';
  List<Messages> messages = [];
  ChatsRemoteData chatsRemoteData = ChatsRemoteData(Get.put(Api()));

  sendMessage() async {
    var response = await chatsRemoteData.sendMessage(
        sharedPreferences!.getString("token"),
        chatId.toString(),
        messageController.text);
    print("  chat by id :: $response");
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      print("sendddddddddddddddddddddd");
      messageController.clear();
      getChatByIdStream();
      //  getChatById();
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

  getTypeOfChat() async {
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await ordersRemoteData.getAllOrders(
      sharedPreferences!.getString("token"),
    );
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      List responseBody = response['data']['items'];
      for (var i = 0; i < responseBody.length; i++) {
        if (chatId == responseBody[i]['id']) {
          typeIndex = responseBody[i]['status'] == "pending"
              ? 0
              : responseBody[i]['status'] == "confirmed" ||
                      responseBody[i]['status'] == "paid" ||
                      responseBody[i]['status'] == "delivery"
                  ? 1
                  : 2;
        }
      }
      print(chatId);
      print(typeIndex);
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

  // getChatById() async {
  //   var response = await chatsRemoteData.getChatById(
  //       sharedPreferences!.getString("token"), chatId.toString());
  //   print("  chat by id :: ${response}");
  //   statuesRequest = handlingData(response);
  //   if (statuesRequest == StatuesRequest.success) {
  //     Map<String, dynamic> responseBody = response['data'];
  //     chatModel = ChatModel.fromJson(responseBody);
  //     messages = chatModel!.messages!;

  //     await getTypeOfChat();

  //     print("  chat by id :: ${responseBody}");
  //   } else if (statuesRequest == StatuesRequest.socketException) {
  //     return messageHandleException(
  //         "لا يوجد اتصال بالإنترنت. يرجى التحقق من اتصالك والمحاولة مرة أخرى");
  //   } else if (statuesRequest == StatuesRequest.serverException) {
  //     return messageHandleException("لم يتم العثور على المورد المطلوب.");
  //   } else if (statuesRequest == StatuesRequest.unExpectedException) {
  //     return messageHandleException(
  //         "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.");
  //   } else if (statuesRequest == StatuesRequest.defaultException) {
  //     return messageHandleException(
  //         "فشل إكمال العملية. الرجاء المحاولة مرة أخرى");
  //   } else if (statuesRequest == StatuesRequest.serverError) {
  //     return messageHandleException(
  //         "الخادم غير متاح حاليًا. يرجى المحاولة مرة أخرى لاحقًا");
  //   } else if (statuesRequest == StatuesRequest.timeoutException) {
  //     return messageHandleException(
  //         "انتهت مهلة الطلب. يرجى المحاولة مرة أخرى لاحقًا.");
  //   } else if (statuesRequest == StatuesRequest.unauthorizedException) {
  //     return messageHandleException(
  //         "تم الوصول بشكل غير مصرح به. يرجى التحقق من بيانات الاعتماد الخاصة بك والمحاولة مرة أخرى.");
  //   }
  //   update();
  // }

  Stream<List<dynamic>> getChatByIdStream() async* {
    while (true) {
      var response = await chatsRemoteData.getChatById(
          sharedPreferences!.getString("token"), chatId.toString());
      print("  chat by id :: $response");
      statuesRequest = handlingData(response);
      if (statuesRequest == StatuesRequest.success) {
        Map<String, dynamic> responseBody = response['data'];
        chatModel = ChatModel.fromJson(responseBody);
        messages = chatModel!.messages!;
        //await getTypeOfChat();

        yield messages; // Return the new data
      } else {
        yield []; // Return an empty list or handle error cases
      }
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Polling interval or replace with any real-time mechanism
    }
  }

  getOrderInfo() async {
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await ordersRemoteData.getOrderById(
        sharedPreferences!.getString("token"), paymentModel!.id.toString());
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      Map<String, dynamic> responseBody = response['data'];

      orderModel = OrderModel.fromJson(responseBody);
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

  confirmOrder(type) async {
    print("${sharedPreferences!.getString("token")}");
    print(chatId);
    succsessConfirm = false;
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await ordersRemoteData.confirm(
        sharedPreferences!.getString("token"), chatId, type);
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      succsessConfirm = true;
      Map<String, dynamic> responseBody = response['data'];
      paymentModel = PaymentModel.fromJson(responseBody);
      redirectUrl = response["extra"]["payment_url"].toString();
      print(redirectUrl);
      succsessConfirm = true;

      if (type == "cash") {
        print("${sharedPreferences!.getString("token")}");
        await getOrderInfo();
        print("jjjjjjjjj... $orderModel");
        Get.offAll(() => const MyOrderInfo(),
            arguments: {"data": orderModel!.toJson(), "page": "oeder"});
      } else {
        print("orderModel /// $orderModel");
        Get.offAll(
            () => PaymentWebView(
                  redirecturl: redirectUrl,
                ),
            arguments: {"orderModel": paymentModel});
      }
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

  cancelOrder() async {
    succsessCancel = false;
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await ordersRemoteData.cancel(
        sharedPreferences!.getString("token"), chatId);
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      succsessCancel = true;
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

  firstMessage() {
    Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(bottom: 3.w, right: 2.w, left: 2.w),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              Get.to(() => const MyOrderInfo(),
                  arguments: {"data": orderModel!.toJson(), "page": "chat"});
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
                  "مراجعة الطلب",
                  style: GoogleFonts.tajawal(
                      fontSize: 4.w,
                      color: LightMode.registerText,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.w,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              secondMessage();
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
                  "تأكيد الطلب",
                  style: GoogleFonts.tajawal(
                      fontSize: 4.w,
                      color: LightMode.registerText,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.w,
          ),
          InkWell(
            onTap: () async {
              await cancelOrder();
              succsessCancel == true ? typeIndex = 2 : null;
              Get.back();
              update();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: LightMode.discountCollor, width: 2),
                borderRadius: BorderRadius.circular(3.w),
              ),
              width: 30.w,
              height: 5.h,
              child: Center(
                child: Text(
                  "إلغاء الطلب",
                  style: GoogleFonts.tajawal(
                      fontSize: 4.w,
                      color: LightMode.discountCollor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  secondMessage() {
    Get.defaultDialog(
      title: "اختار عملية الدفع",
      // titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(bottom: 3.w, right: 2.w, left: 2.w),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              await confirmOrder("sadadpay");
              succsessConfirm == true ? typeIndex = 1 : null;
              Get.back();
              update();
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
                  "الدفع أونلاين",
                  style: GoogleFonts.tajawal(
                      fontSize: 4.w,
                      color: LightMode.registerText,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await confirmOrder("cash");
              succsessConfirm == true ? typeIndex = 1 : null;
              Get.back();
              update();
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
                  "الدفع كاش",
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
    );
  }

  @override
  void onInit() async {
    getTypeOfChat();
    nameOfOrder = Get.arguments['nameOfOrder'];
    print(nameOfOrder);

    imageUser = Get.arguments['imageUser'];
    print(imageUser);

    chatId = Get.arguments['chatId'];
    print(chatId);
    // getChatById();
    super.onInit();
  }
}
