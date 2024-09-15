import 'dart:io';

import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/constant/api_linkes.dart';
import 'package:mas_app/main.dart';

class RegisterRemoteData {
  Api api;
  RegisterRemoteData(this.api);
  signUp(String nameEn, String email, String phone, String address, String lat,
      String lng, String password, governorateId) async {
    var response = await api.postData(AppLinks.registerLink, {
      // "Accept": "application/json",
    }, {
      "name": nameEn.toString(),
      "email": email.toString(),
      "password": password.toString(),
      "phone": phone.toString(),
      "image": "",
      "address": address.toString(),
      "country": "Kuwait",
      "lat": lat == "null" ? "" : lat,
      "lng": lng == "null" ? "" : lng,
      "country_id": "1",
      "governorate_id": governorateId
    });
    return response.fold((l) => l, (r) => r);
  }

  //login

  login(String phone, String password) async {
    var response = await api.postData(AppLinks.loginLink, {
      // "Accept": "application/json",
      // "Accept-Language":
      //     sharedPreferences!.getString("local") == "ar" ? "ar" : "en"
    }, {
      "phone": phone.toString(),
      "password": password.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  // forget pass
  forgetPassword(String phone, String password) async {
    var response = await api.updateData(AppLinks.forgetPassLink, {
      // "Accept": "application/json",
      // "Accept-Language":
      //     sharedPreferences!.getString("local") == "ar" ? "ar" : "en"
    }, {
      "phone": phone.toString(),
      "password": password.toString(),
      "_method": "put"
    });
    return response.fold((l) => l, (r) => r);
  }
  //logOut

  logOut(String token) async {
    var response = await api.deleteData(AppLinks.logOutLink, {
      "authorization": "Bearer $token",
      "Accept": "application/json",
      "Accept-Language":
          sharedPreferences!.getString("local") == "ar" ? "ar" : "en"
    });
    return response.fold((l) => l, (r) => r);
  }

  // update profile
  update(String token, String nameEn, String email, String address, File? img,
      String currentPass, String newPass, String countryId) async {
    var response = await api.postRequestwithfile(
        AppLinks.updateProfile,
        currentPass != "null" && newPass != "null"
            ? {
                "name": nameEn,
                "email": email,
                "address": address,
                "governorate_id": countryId,
                "_method": "put",
                "current_password": currentPass,
                "new_password": newPass
              }
            : {
                "name": nameEn,
                "email": email,
                "address": address,
                "governorate_id": countryId,
                "_method": "put",
              },
        img,
        token);
    return response.fold((l) => l, (r) => r);
  }

  //getCountries
  getCountry() async {
    var response = await api.getData(AppLinks.getCountries, {
      "Accept": "application/json",
      "Accept-Language":
          sharedPreferences!.getString("local") == "ar" ? "ar" : "en"
    });
    return response.fold((l) => l, (r) => r);
  }
}
