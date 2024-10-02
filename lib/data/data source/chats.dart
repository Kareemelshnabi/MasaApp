import 'dart:io';

import 'package:mas_app/core/constant/api_linkes.dart';
import 'package:mas_app/main.dart';

import '../../core/class/api.dart';

class ChatsRemoteData {
  Api api;
  ChatsRemoteData(this.api);
  getAllChats(token) async {
    var response = await api.getData(AppLinks.getAllChats, {
      "authorization": "Bearer $token",
      "Accept": "application/json",
      "Accept-Language":
          sharedPreferences!.getString("local") == "ar" ? "ar" : "en"
    });
    return response.fold((l) => l, (r) => r);
  }
  getMoreChats(token,link) async {
    var response = await api.getData(link, {
      "authorization": "Bearer $token",
    "Accept": "application/json", 
    "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    });
    return response.fold((l) => l, (r) => r);
  }

  getChatById(token, id) async {
    var response = await api.getData("${AppLinks.getChatById}$id", {
      "authorization": "Bearer $token",
      "Accept": "application/json",
      "Accept-Language":
          sharedPreferences!.getString("local") == "ar" ? "ar" : "en"
    });
    return response.fold((l) => l, (r) => r);
  }

  sendMessageText(
    token,
    id,
    message,
  ) async {
    var response = await api.postData("${AppLinks.getChatById}$id", {
      "authorization": "Bearer $token",
      "Accept": "application/json",
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept-Language":
          sharedPreferences!.getString("local") == "ar" ? "ar" : "en"
    }, {
      "content": message,
      "type": "text",
    });
    return response.fold((l) => l, (r) => r);
  }

  sendMessageFile(token, id, File file) async {
    var response = await api.postfileToChat(
        "${AppLinks.getChatById}$id",
        {
          "type": "file",
        },
        file,
        token);
    return response.fold((l) => l, (r) => r);
  }

  sendMessageVoice(token, id, file) async {
    var response = await api.postVoiceToChat(
        "${AppLinks.getChatById}$id",
        {
          "type": "voice",
        },
        file,
        token);
    return response.fold((l) => l, (r) => r);
  }
}
