import 'dart:io';

import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/constant/api_linkes.dart';
import 'package:mas_app/main.dart';

class RegisterRemoteData {
  Api api;
  RegisterRemoteData(this.api);
  signUp(String nameEn, String email, String phone, String address, String lat,
      String lng, String password, governorateId, tokenDevice) async {
    var response = await api.postData(AppLinks.registerLink, {
      //"Accept": "application/json",
    }, {
      "name": nameEn.toString(),
      "email": email.toString(),
      "password": password.toString(),
      "phone": phone.toString(),
      "address": address.toString(),
      "country": "Kuwait",
      "country_id": "1",
      "governorate_id": governorateId.toString(),
      "fcm_token": tokenDevice,
    });
    return response.fold((l) => l, (r) => r);
  }

  //login

  login(String phone, String password, tokenDevice) async {
    var response = await api.postData(AppLinks.loginLink, {
      // "Accept": "application/json",
      // "Accept-Language":
      //     sharedPreferences!.getString("local") == "ar" ? "ar" : "en"
    }, {
      "phone": phone.toString(),
      "password": password.toString(),
      "fcm_token": tokenDevice,
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
    var response = await api.getData(AppLinks.getCountries,
        {"Accept": "application/json", "Accept-Language": "ar"});
    return response.fold((l) => l, (r) => r);
  }

  // verify

  verifySign(phone, otp) async {
    var response = await api.postData(AppLinks.verifySign, {
      "Accept": "application/json",
      "Accept-Language": "ar",
     
    }, {
      "phone": phone,
      "otp": otp
    });
    return response.fold((l) => l, (r) => r);
  }

  //resend
    reSendOtp(phone) async {
    var response = await api.postData(AppLinks.reSendOtp, {
      "Accept": "application/json",
      "Accept-Language": "ar",
     
    }, {
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }

  //send otp to reset pass

   sendOtpToResetPass(phone) async {
    var response = await api.postData(AppLinks.sendOtpToREsetPassLink, {
      "Accept": "application/json",
      "Accept-Language": "ar",
     
    }, {
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }
}
