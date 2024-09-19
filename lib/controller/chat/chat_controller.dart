// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:screen_go/extensions/responsive_nums.dart';
import 'package:uuid/uuid.dart';

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

  File? image;
  String imagerequest = '';
  final record = AudioRecorder();
  late AudioPlayer audioPlayer;
  bool isPlayer = false;

  String voice = '';
  String url = '';
  bool isRecord = false;

  startRecord() async {
    update();
    print("starttttttttttttttttttttttttttttttt");
    final location = await getApplicationCacheDirectory();
    String name = Uuid().v1();
    if (await record.hasPermission()) {
      print("starttttttttttttttttttttttttttttttt  22222222222");
      await record.start(RecordConfig(), path: '${location.path}/$name.m4a');
      print(voice);
    }
    isRecord = true;
    update();
    log("start record");
  }

  stopRecord() async {
    print("${File(voice)}stopppppppppppppppppppppppppppppppppppp");
    String? final_path = await record.stop();

    voice = final_path!;
    update();
    print(voice);
    print("stopppppppppppppppppppppppppppppppppppp      222222");
    isRecord = false;
    await sendMessageVoice();
    print("stopppppppppppppppppppppppppppppppppppp      3333333");

    log("stop record");
  }

  play(link) async {
    isPlayer = true;

    await audioPlayer.play(UrlSource(link));
    audioPlayer.onPlayerComplete.listen((event) {
      isPlayer = false; // Reset the player state when audio finishes

      log("Audio finished playing");
    });
    update();
    log("audio Play");
  }

  stop() async {
    await audioPlayer.stop();

    isPlayer = false;
    update();

    log("audio stop");
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future getImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return null;
    } else {
      image = File(returnImage.path);
      imagerequest = image!.path;
      showImageChooseToSend();
      print(imagerequest);

      update();
    }
    update();
  }

  deleteImage() {
    image = null;
    imagerequest = '';
    update();
  }

  showImageChooseToSend() {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "ملف",
        content: Column(
          children: [
            SizedBox(
              height: 50.h,
              width: 80.w,
              child: Image.file(
                image!,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    sendMessageFile();
                    Get.back();
                  },
                  child: Container(
                    width: 35.w,
                    height: 5.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.w,
                        ),
                        color: LightMode.splash),
                    child: Text(
                      "ارسال",
                      style: GoogleFonts.tajawal(
                          fontSize: 4.w,
                          fontWeight: FontWeight.w700,
                          color: LightMode.registerText),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    deleteImage();
                    Get.back();
                  },
                  child: Container(
                    width: 35.w,
                    height: 5.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.w,
                        ),
                        border: Border.all(color: LightMode.splash)),
                    child: Text(
                      "الغاء",
                      style: GoogleFonts.tajawal(
                          fontSize: 4.w,
                          fontWeight: FontWeight.w700,
                          color: LightMode.splash),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  showImage(image) {
    Get.defaultDialog(
        title: "",
        content: Column(
          children: [
            SizedBox(
              height: 5.w,
            ),
            SizedBox(
                height: 50.h,
                width: 80.w,
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 5.w,
            ),
          ],
        ));
  }

  sendMessageText() async {
    var response = await chatsRemoteData.sendMessageText(
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

  sendMessageFile() async {
    var response = await chatsRemoteData.sendMessageFile(
        sharedPreferences!.getString("token"), chatId.toString(), image!);
    print("  chat by id :: $response");
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      print("sendddddddddddddddddddddd");
      messageController.clear();
      image = null;

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

  sendMessageVoice() async {
    var response = await chatsRemoteData.sendMessageVoice(
        sharedPreferences!.getString("token"), chatId.toString(), voice);
    print("  chat by id :: $response");
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      print("sendddddddddddddddddddddd");
      messageController.clear();
      image = null;

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
        orderModel = chatModel!.order!;
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
    audioPlayer = AudioPlayer();
    getTypeOfChat();
    nameOfOrder = Get.arguments['nameOfOrder'];
    print(nameOfOrder);

    imageUser = Get.arguments['imageUser'];
    print(imageUser);

    chatId = Get.arguments['chatId'];
    print(chatId);
    super.onInit();
  }
}
