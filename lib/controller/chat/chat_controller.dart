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
import 'package:mas_app/generated/l10n.dart';
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

  Map isPlay = {};
  setFavourite(String id, String val) {
    isPlay[id] = val;
    update();
  }

  startRecord() async {
    print("starttttttttttttttttttttttttttttttt");
    final location = await getApplicationCacheDirectory();
    String name = const Uuid().v1();
    if (await record.hasPermission()) {
      print("starttttttttttttttttttttttttttttttt  22222222222");
      await record.start(const RecordConfig(),
          path: '${location.path}/$name.m4a');
      print(voice);
    }
    isRecord = true;
    update();
    log("start record");
  }

  stopRecord() async {
    print("${File(voice)}stopppppppppppppppppppppppppppppppppppp");
    String? finalPath = await record.stop();

    voice = finalPath!;
    update();
    print(voice);
    print("stopppppppppppppppppppppppppppppppppppp      222222");
    isRecord = false;
    await sendMessageVoice();
    print("stopppppppppppppppppppppppppppppppppppp      3333333");

    log("stop record");
  }

  play(link, index) async {
    isPlayer = true;
    isPlay[messages[index].id.toString()] = "1";

    await audioPlayer.play(UrlSource(link));
    audioPlayer.onPlayerComplete.listen((event) {
      stop(index);
    });
    update();
    log("audio Play");
  }

  stop(index) async {
    isPlayer = false;
    isPlay[messages[index].id.toString()] = "0";
    await audioPlayer.stop();

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
        title: S.of(Get.context!).file,
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
                     S.of(Get.context!).send,
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
                     S.of(Get.context!).cancel,
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

  firstMessage() {
    Get.defaultDialog(
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? null
          : DarkMode.darkModeSplash,
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
                  S.of(Get.context!).reviewOrder,
                  style: GoogleFonts.tajawal(
                      fontSize: 4.w,
                      color: sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerText
                          : DarkMode.darkModeSplash,
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
                  S.of(Get.context!).confirmOrder,
                  style: GoogleFonts.tajawal(
                      fontSize: 4.w,
                      color: sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerText
                          : DarkMode.darkModeSplash,
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
                  S.of(Get.context!).cancelOrder,
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
      title: S.of(Get.context!).choosePayment,
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
                  S.of(Get.context!).payyOnline,
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
                  S.of(Get.context!).payCash,
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
