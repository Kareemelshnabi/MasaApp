// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mas_app/controller/home/home_controller.dart';
import 'package:mas_app/core/class/api.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/core/function/handling_data.dart';
import 'package:mas_app/data/data%20source/register.dart';
import 'package:mas_app/data/model/country_model.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/main_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ProfileController extends GetxController {
  GlobalKey<FormState> profileGlobalKey = GlobalKey();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController governorateController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();

  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController addressController = TextEditingController();
  StatuesRequest statuesRequest = StatuesRequest.none;
  RegisterRemoteData registerRemoteData = RegisterRemoteData(Get.put(Api()));
  bool edit = false;
  bool showPass1 = true;
  bool showPass2 = true;
  bool showPass3 = true;

  File? image;
  String imagerequest = "";
  bool succsess = false;
  CountryMoodel? countryMoodel;
  String governorateId = '';
  showDialogGovernate() {
    return showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        // ignore: sized_box_for_whitespace
        content: Container(
          width: 80.w,
          height: 50.h,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 5.w),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.w),
                      topRight: Radius.circular(4.w)),
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
                height: 40.h,
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            governorateId = countryMoodel!
                                .governorates![index].id
                                .toString();
                            governorateController.text =
                                countryMoodel!.governorates![index].name!;

                            Get.back();
                            update();
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 4.w, right: 5.w),
                            height: 5.h,
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
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: countryMoodel!.governorates!.length),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
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
      messageHandleException("خطأ");
    } else if (statuesRequest == StatuesRequest.socketException) {
      messageHandleException(S.of(context).noInternetApi);
    } else if (statuesRequest == StatuesRequest.serverException) {
      messageHandleException(S.of(context).serverException);
    } else if (statuesRequest == StatuesRequest.unExpectedException) {
      messageHandleException(S.of(context).unExcepectedException);
    } else if (statuesRequest == StatuesRequest.defaultException) {
      messageHandleException(
        S.of(context).errorPhoneUseBeforeApi,
      );
    } else if (statuesRequest == StatuesRequest.serverError) {
      messageHandleException(
        S.of(context).serverError,
      );
    } else if (statuesRequest == StatuesRequest.timeoutException) {
      messageHandleException(
        S.of(context).timeOutException,
      );
    } else if (statuesRequest == StatuesRequest.unauthorizedException) {
      messageHandleException(
        S.of(context).passwordNotCorrect,
      );
    }

    update();
  }

  passwordConfirmationValidate(String val) {
    if (newPasswordController.text != passwordConfirmationController.text) {
      return "كلمة السر غير متطابقة";
    } else {
      return null;
    }
  }

  emailValidate(String val) {
    if (val.isEmpty) {
      return "الرجاء ادخال البريد";
    } else if (!val.isEmail) {
      return "البريد غير صالح";
    } else if (val.contains(RegExp(r'[\u0600-\u06FF]'))) {
      return "البريد غير صالح";
    } else {
      return null;
    }
  }

  addressValidate(String val) {
    if (val.isEmpty) {
      return 'الرجاء ادخال العنوان';
    } else if (val.length < 10) {
      return 'العنوان قصير جدا';
    } else {
      return null;
    }
  }

  nameValidate(String val) {
    if (val.isEmpty) {
      return "الرجاء إدخال الإسم";
    } else if (val.length < 3) {
      return " الإسم قصير للغاية";
    } else if (val.length > 40) {
      return "الإسم طويل للغاية";
    } else {
      return null;
    }
  }

  Future getImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) {
      return null;
    } else {
      image = File(returnImage.path);
      imagerequest = image!.path;

      update();
      Get.back();
    }
    update();
  }

  Future getImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return null;
    } else {
      image = File(returnImage.path);
      imagerequest = image!.path;
      print(imagerequest);

      update();
      Get.back();
    }
    update();
  }

  showMessageUpdateImage(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.only(right: 5.6.w, left: 5.6.w, top: 2.w),
        // margin: EdgeInsets.only(right: 2.w, left: 2.w),
        height: 18.h,
        width: 80.w,
        decoration: BoxDecoration(
            color: LightMode.registerText,
            border: Border.all(color: LightMode.splash),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getImageFromCamera();
              },
              child: SizedBox(
                height: 5.h,
                width: 100.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: LightMode.splash,
                      size: 7.w,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      "مــن الكــامــيـــرا",
                      style: GoogleFonts.tajawal(
                          color: LightMode.splash,
                          fontSize: 4.w,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Divider(color: LightMode.splash),
            InkWell(
              onTap: () {
                getImageFromGallery();
              },
              child: SizedBox(
                height: 6.h,
                width: 100.w,
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      color: LightMode.splash,
                      size: 7.w,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      "مــن المعـــرض",
                      style: GoogleFonts.tajawal(
                          color: LightMode.splash,
                          fontSize: 4.w,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateProfile() async {
    if (profileGlobalKey.currentState!.validate()) {
      succsess = false;
      statuesRequest = StatuesRequest.loading;
      update();

      var response = await registerRemoteData.update(
          sharedPreferences!.getString("token")!,
          englishNameController.text,
          emailController.text,
          addressController.text,
          image,
          currentPasswordController.text == ""
              ? "null"
              : currentPasswordController.text.toString(),
          newPasswordController.text == ""
              ? "null"
              : newPasswordController.text.toString(),
          governorateId == ''
              ? sharedPreferences!.getString("governorateId")!
              : governorateId);
      print(response);
      print(
          "${governorateController.text} ${newPasswordController.text} ${currentPasswordController.text == "" ? "null" : currentPasswordController.text.toString()} ${englishNameController.text}  ${emailController.text}  ${phoneController.text}  ${addressController.text}  ${countryController.text}");
      statuesRequest = handlingData(response);
      if (statuesRequest == StatuesRequest.success) {
        Map responseBody = response['data'];
        print("response :: $responseBody");
        sharedPreferences!.setString("nameEn", "${responseBody['name']}");

        sharedPreferences!.setString("email", "${responseBody['email']}");
        sharedPreferences!.setString("address", "${responseBody['address']}");
        sharedPreferences!.setString("phone", "${responseBody['phone']}");
        sharedPreferences!.setString("img", "${responseBody['avatar']}");

        sharedPreferences!
            .setString("governorate", "${responseBody['governorate_name']}");
        print(sharedPreferences!.getString("governorate"));
        sharedPreferences!.setString("pageStart", "Home");
        succsess = true;
      } else if (statuesRequest == StatuesRequest.badRequestException) {
        messageHandleException("كلمة السر الحالية المدخلة خاطئة");
      } else if (statuesRequest == StatuesRequest.socketException) {
        messageHandleException(
            "لا يوجد اتصال بالإنترنت. يرجى التحقق من اتصالك والمحاولة مرة أخرى");
      } else if (statuesRequest == StatuesRequest.serverException) {
        messageHandleException("لم يتم العثور على المورد المطلوب.");
      } else if (statuesRequest == StatuesRequest.unExpectedException) {
        messageHandleException("حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.");
      } else if (statuesRequest == StatuesRequest.defaultException) {
        messageHandleException("كلمة السر المدخلة قصيره");
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
    }
    update();
  }

  showPassword1() {
    if (showPass1 == false) {
      showPass1 = true;
      update();
    } else {
      showPass1 = false;
      update();
    }
  }

  showPassword2() {
    if (showPass2 == false) {
      showPass2 = true;
      update();
    } else {
      showPass2 = false;
      update();
    }
  }

  showPassword3() {
    if (showPass3 == false) {
      showPass3 = true;
      update();
    } else {
      showPass3 = false;
      update();
    }
  }

  canEdit() {
    if (edit == false) {
      edit = true;
      update();
    } else {
      edit = false;
      update();
    }
  }

  bool darkMode = false;
  changeToDark(val) {
    darkMode = val;
    update();
  }

  showSuccsessUpdate() {
    Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Image.asset(
            ImagesLink.succsessUpdate,
            width: 30.w,
            height: 10.h,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 7.h,
            width: 60.w,
            child: Text(
              "تم تغيير معلومات حسابك بنجاح. لحظات و سيتم تحويلك للصفحتك الرئيسية.",
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: 3.5.w,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  logOut() async {
    statuesRequest = StatuesRequest.loading;
    update();
    var response = await registerRemoteData
        .logOut(sharedPreferences!.getString("token").toString());
    print(response);
    statuesRequest = handlingData(response);
    if (statuesRequest == StatuesRequest.success) {
      String responseBody = response['data'];
      print("response :: $responseBody");

      sharedPreferences!.setString("pageStart", "typeofUser");

      Get.to(() => const MainRegister());
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
              margin: EdgeInsets.only(top: 4.w),
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
      ),
    );
  }

  showBottomSheet(context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height / 3,
          maxWidth: MediaQuery.sizeOf(context).width - 40,
          minWidth: MediaQuery.sizeOf(context).width - 40),
      shape: OutlineInputBorder(
          borderSide: BorderSide(color: LightMode.splash),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            "تسجيل الخروج",
            style: GoogleFonts.tajawal(
                letterSpacing: 2,
                color: LightMode.registerButtonBorder,
                fontSize:
                    MediaQuery.of(context).size.shortestSide < 600 ? 5.w : 4.w,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "هل أنت متأكد أنك تريد تسجيل الخروج؟",
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
                color: LightMode.registerButtonBorder,
                fontSize: MediaQuery.of(context).size.shortestSide < 600
                    ? 4.5.w
                    : 3.5.w,
                fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: LightMode.splash,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: MediaQuery.sizeOf(context).width / 3,
                  height: 5.h,
                  child: MaterialButton(
                    onPressed: () async {
                      await logOut();
                      HomeController homeController = Get.put(HomeController());
                      homeController.currentIndex = 0;
                    },
                    child: Text(
                      "تأكيد",
                      style: GoogleFonts.tajawal(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 600
                                  ? 3.5.w
                                  : 3.w,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: LightMode.splash),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  width: MediaQuery.sizeOf(context).width / 3,
                  height: 5.h,
                  child: MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "إلغاء",
                      style: GoogleFonts.tajawal(
                          color: const Color.fromARGB(255, 41, 108, 186),
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 600
                                  ? 3.5.w
                                  : 3.w,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  void onInit() {
    getCountries(Get.context);
    // sharedPreferences!.clear();
    super.onInit();
  }
}
