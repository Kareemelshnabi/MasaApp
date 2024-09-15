// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/function/handling_data.dart';
import 'package:mas_app/data/data%20source/register.dart';
import 'package:mas_app/data/model/country_model.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/signup/verify_code_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> signUpGlobalKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController userNameEnglish = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController governateController = TextEditingController();

  StatuesRequest statuesRequest = StatuesRequest.none;
  RegisterRemoteData registerRemoteData = RegisterRemoteData(Get.put(Api()));
  bool choose = false;
  bool showPass_1 = true;
  bool showPass_2 = true;
  double? lat;
  double? lng;
  Map user = {};
  String verificationId = '';
  CountryMoodel? countryMoodel;
  String governorateId = '';

  Future<void> verifyPhoneNumber() async {
    print("mmmmmm  mmmm  mmm");
    FirebaseAuth.instance.setLanguageCode('en'); // Set locale for SMS messages

    await FirebaseAuth.instance.verifyPhoneNumber(
      // phoneNumber: phoneController.text, // Example: +1234567890
      phoneNumber: "+201281265373",
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("phoneeeeeeeee");
        // Automatically sign in when the verification is completed (optional)
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle the error
        print('Phone number verification failed: ${e.message}');
      },
      codeSent: (String verifyId, int? resendToken) {
        // Save the verification ID to verify later

        verificationId = verifyId;
        update();
      },
      codeAutoRetrievalTimeout: (String verifyId) {
        print("jjjjjjjjjjj");
        verificationId = verifyId;
        update();
      },
      timeout: const Duration(seconds: 120),
      forceResendingToken: null,
    );
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
                            governateController.text =
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

  bool isValidPhoneNumber(String phoneNumber) {
    String p = r'^(?:\+965)?[5692]\d{7}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(phoneNumber);
  }

  showPassword_1() {
    if (showPass_1 == false) {
      showPass_1 = true;
      update();
    } else {
      showPass_1 = false;
      update();
    }
  }

  showPassword_2() {
    if (showPass_2 == false) {
      showPass_2 = true;
      update();
    } else {
      showPass_2 = false;
      update();
    }
  }

  emailValidate(String val, context) {
    if (val.isEmpty) {
      return S.of(context).errorEmail_1;
    } else if (!val.isEmail) {
      return S.of(context).errorEmail_2;
    } else if (val.contains(RegExp(r'[\u0600-\u06FF]'))) {
      return S.of(context).errorEmail_3;
    } else {
      return null;
    }
  }

  passwordValidate(String val, context) {
    if (val.isEmpty) {
      return S.of(context).errorPass_1;
    } else if (val.length < 8) {
      return S.of(context).errorPass_2;
    } else if (val.length > 20) {
      return S.of(context).errorPass_3;
    } else {
      return null;
    }
  }

  passwordConfirmationValidate(String val, context) {
    if (val.isEmpty) {
      return S.of(context).errorConfirmPass_1;
    } else if (passwordController.text != passwordConfirmationController.text) {
      return S.of(context).errorConfirmPass_2;
    } else {
      return null;
    }
  }

  phoneValidate(String val, context) {
    if (val.isEmpty) {
      return S.of(context).errorPhone_1;
    } else if (!val.isPhoneNumber) {
      return S.of(context).errorPhone_2;
    } else if (!isValidPhoneNumber(val)) {
      return S.of(context).errorPhone_3;
    } else if (isValidPhoneNumber(val)) {
      return null;
    }
  }

  addressValidate(String val, context) {
    if (val.isEmpty) {
      return S.of(context).errorAddress_1;
    } else if (val.length < 10) {
      return S.of(context).errorAddress_2;
    } else {
      return null;
    }
  }

  englishNameValidate(String val, context) {
    if (val.isEmpty) {
      return S.of(context).errorUserName_1;
    } else if (val.length < 3) {
      return S.of(context).errorUserName_2;
    } else if (val.length > 40) {
      return S.of(context).errorUserName_3;
    } else {
      return null;
    }
  }

  checkValue(val) {
    choose = val;
    update();
  }

  messageHandleException(message, context) {
    Get.defaultDialog(
        title: S.of(context).error,
        content: Column(
          children: [
            Text(
              message,
              style: GoogleFonts.tajawal(
                  fontSize: 3.5.w,
                  color: LightMode.registerButtonBorder,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5.w,
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
                    S.of(context).tryAgain,
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

  signUp(context) async {
    if (signUpGlobalKey.currentState!.validate() &&
        choose == true &&
        governateController.text != "") {
      statuesRequest = StatuesRequest.loading;
      update();
      var response = await registerRemoteData.signUp(
          userNameEnglish.value.text,
          emailController.value.text,
          phoneController.value.text,
          addressController.value.text,
          "",
          "",
          passwordController.value.text,
          governorateId);
      print(response);

      print(phoneController.text);

      statuesRequest = handlingData(response);
      if (statuesRequest == StatuesRequest.success) {
        await verifyPhoneNumber();
        Map responseBody = response['data'];
        print("response :: $responseBody");

        sharedPreferences!.setString("phone", responseBody['phone']);
        sharedPreferences!.setString("email", emailController.text);

        sharedPreferences!.setString("token", "${responseBody['token']}");
        sharedPreferences!
            .setString("country", "${responseBody['country']['name']}");
        sharedPreferences!.setString("address", "${responseBody['address']}");
        sharedPreferences!.setString("nameEn", "${responseBody['name']}");
        sharedPreferences!.setString("img", "${responseBody['image']}");
        sharedPreferences!.setString("lat", "${responseBody['lat']}");
        sharedPreferences!.setString("lng", "${responseBody['lng']}");
        sharedPreferences!
            .setString("governorateId", "${responseBody['governorate']['id']}");

        sharedPreferences!
            .setString("governorate", "${responseBody['governorate']['name']}");

        sharedPreferences!.setString("pageStart", "verifyRegister");
        Get.to(() => const VerifyCodeRegister());
      } else if (statuesRequest == StatuesRequest.unprocessableException) {
        messageHandleException("رقم الهاتف مسجل من قبل", context);
      } else if (statuesRequest == StatuesRequest.socketException) {
        messageHandleException(S.of(context).noInternetApi, context);
      } else if (statuesRequest == StatuesRequest.serverException) {
        messageHandleException(S.of(context).serverException, context);
      } else if (statuesRequest == StatuesRequest.unExpectedException) {
        messageHandleException(S.of(context).unExcepectedException, context);
      } else if (statuesRequest == StatuesRequest.defaultException) {
        messageHandleException(S.of(context).errorPhoneUseBeforeApi, context);
      } else if (statuesRequest == StatuesRequest.serverError) {
        messageHandleException(S.of(context).serverError, context);
      } else if (statuesRequest == StatuesRequest.timeoutException) {
        messageHandleException(S.of(context).timeOutException, context);
      } else if (statuesRequest == StatuesRequest.unauthorizedException) {
        messageHandleException(S.of(context).passwordNotCorrect, context);
      }
    } else if (choose == false) {
      messageHandleException(S.of(context).errorConfirmPrivacy, context);
    } else if (governateController.text == "") {
      messageHandleException("يرجي اختيار المحافظة", context);
    }
    update();
  }

  getCountries(context) async {
    var response = await registerRemoteData.getCountry();
    print(response);

    print(phoneController.text);

    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      Map<String, dynamic> responseBody = response['data'][0];
      print("response :: $responseBody");
      countryMoodel = CountryMoodel.fromJson(responseBody);
    } else if (statuesRequest == StatuesRequest.unprocessableException) {
      messageHandleException("خطأ", context);
    } else if (statuesRequest == StatuesRequest.socketException) {
      messageHandleException(S.of(context).noInternetApi, context);
    } else if (statuesRequest == StatuesRequest.serverException) {
      messageHandleException(S.of(context).serverException, context);
    } else if (statuesRequest == StatuesRequest.unExpectedException) {
      messageHandleException(S.of(context).unExcepectedException, context);
    } else if (statuesRequest == StatuesRequest.defaultException) {
      messageHandleException(S.of(context).errorPhoneUseBeforeApi, context);
    } else if (statuesRequest == StatuesRequest.serverError) {
      messageHandleException(S.of(context).serverError, context);
    } else if (statuesRequest == StatuesRequest.timeoutException) {
      messageHandleException(S.of(context).timeOutException, context);
    } else if (statuesRequest == StatuesRequest.unauthorizedException) {
      messageHandleException(S.of(context).passwordNotCorrect, context);
    }

    update();
  }

  messageNotEnable(context) {
    Get.defaultDialog(
        title: S.of(context).alert,
        content: Text(
          S.of(context).NotActivated,
          style: GoogleFonts.tajawal(
              fontSize: 3.5.w,
              fontWeight: FontWeight.w600,
              color: LightMode.registerButtonBorder),
        ));
  }

  @override
  void onInit() {
    getCountries(Get.context);
    // getLocation(context);
    super.onInit();
  }
}
