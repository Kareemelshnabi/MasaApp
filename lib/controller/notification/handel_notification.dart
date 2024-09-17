import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/chat/chat.dart';

class FirebaseNotification {
  // create instanse
  final firebaseMessagin = FirebaseMessaging.instance;

  //intilize notification
  Future<void> intilizeNotification() async {
    await firebaseMessagin.requestPermission();
    String? token = await firebaseMessagin.getToken();
    log("$token");
  }

  // handel notification
  void handelMassage(RemoteMessage? remotemess) {
    if (remotemess == null) return;
    log("${remotemess.data}");
    // Get.to(() => ChatPage(), arguments: {});
  }

  // hande notification back greound
  Future<void> handelBackGround() async {
    firebaseMessagin.getInitialMessage().then(handelMassage);
    FirebaseMessaging.onMessageOpenedApp.listen(handelMassage);
  }
}
