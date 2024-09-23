import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/register/forget_password.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/login/login.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

import '../../../../core/class/status_request.dart';
import '../../../../core/constant/colors.dart';

class AddNewPassword extends StatelessWidget {
  const AddNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordController forgetPasswordController =
        Get.put(ForgetPasswordController());
    return Scaffold(
        backgroundColor: sharedPreferences!.getBool("darkMode") == false
            ? LightMode.registerText
            : DarkMode.darkModeSplash,
        body: OfflineBuilder(
          connectivityBuilder: (context, ConnectivityResult value, child) {
            final bool connected = value != ConnectivityResult.none;

            if (connected) {
              return GetBuilder<ForgetPasswordController>(
                builder: (controller) =>
                    controller.statuesRequest == StatuesRequest.loading
                        ? SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Form(
                            key: controller.addNewPassGlobalKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  appBarForgetPass(context),
                                  bodyForgetPass(context),
                                  textFieldPhone(
                                    (val) {
                                      return forgetPasswordController
                                          .phoneValidate(val!, context);
                                    },
                                    forgetPasswordController.phoneController,
                                    TextInputType.phone,
                                    S.of(context).phone,
                                    false,
                                  ),
                                  textField(
                                    (val) {
                                      return forgetPasswordController
                                          .passwordValidate(val!, context);
                                    },
                                    forgetPasswordController.passwordController,
                                    TextInputType.visiblePassword,
                                    S.of(context).password,
                                    true,
                                    controller.showPass_1,
                                    controller.showPass_1 == false
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    () {
                                      controller.showPassword_1();
                                    },
                                  ),
                                  textField(
                                    (val) {
                                      return forgetPasswordController
                                          .passwordConfirmationValidate(
                                              val!, context);
                                    },
                                    forgetPasswordController
                                        .passwordConfirmationController,
                                    TextInputType.visiblePassword,
                                    S.of(context).confirmPass,
                                    true,
                                    controller.showPass_2,
                                    controller.showPass_2 == false
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    () {
                                      controller.showPassword_2();
                                    },
                                  ),
                                  SizedBox(
                                    height: 6.w,
                                  ),
                                  onBtnClick("تأكيد", () {
                                    controller.addNewPass(context);
                                  }),
                                ],
                              ),
                            ),
                          ),
              );
            } else {
              return SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child:
                      const Center(child: Text("no internet ............ !")));
            }
          },
          child: const CircularProgressIndicator(),
        ));
  }

  Widget textTerms(text, textAlign, fontSize, fontWeight) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      textAlign: textAlign,
      style: GoogleFonts.tajawal(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: sharedPreferences!.getBool("darkMode") == false
              ? LightMode.registerButtonBorder
              : DarkMode.whiteDarkColor),
    );
  }

  Widget textFieldPhone(String? Function(String?)? validator, controller,
      keyboardType, text, bool icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.w),
      width: 90.w,
      height: 9.h,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.tajawal(
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.splash
                : DarkMode.whiteDarkColor,
            fontSize: 4.w,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          suffixIcon: icon == true
              ? Icon(
                  Icons.remove_red_eye_outlined,
                  color: LightMode.splash,
                )
              : null,
          hintStyle: GoogleFonts.tajawal(
              color: LightMode.splash,
              fontSize: 4.w,
              fontWeight: FontWeight.w500),
          hintText: text,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LightMode.splash,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LightMode.splash,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LightMode.splash,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LightMode.splash,
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarForgetPass(context) {
    return SizedBox(
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 20.w,
            child: Padding(
              padding: EdgeInsets.only(top: 7.w),
              child: IconButton(
                  onPressed: () {
                    Get.offAll(() => const LoginPage());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor,
                    size: 6.w,
                  )),
            ),
          ),
          SizedBox(
            width: 60.w,
            child: Container(
              margin: EdgeInsets.only(top: 7.h, bottom: 2.h, right: 13.w),
              child: Text(
                S.of(context).titleAddNewPass,
                style: GoogleFonts.tajawal(
                  fontSize: 5.5.w,
                  fontWeight: FontWeight.bold,
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? LightMode.typeUserTitle
                      : DarkMode.whiteDarkColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
        ],
      ),
    );
  }

  Widget bodyForgetPass(context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 1.h, bottom: 2.h, right: 5.w, left: 5.w),
        child: Text(
          S.of(context).bodyAddNewPass,
          textAlign: TextAlign.center,
          style: GoogleFonts.tajawal(
            fontSize: 3.5.w,
            fontWeight: FontWeight.w500,
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.typeUserBody
                : DarkMode.whiteDarkColor,
          ),
        ),
      ),
    );
  }

  Widget textField(String? Function(String?)? validator, controller,
      keyboardType, text, bool icon, obscure, iconButton, onPress) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.w),
      width: 90.w,
      height: 9.h,
      child: TextFormField(
        obscureText: obscure == true ? true : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.tajawal(
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.splash
                : DarkMode.whiteDarkColor,
            fontSize: 4.w,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          suffixIcon: icon == true
              ? InkWell(
                  onTap: onPress,
                  child: Icon(
                    iconButton,
                    color: LightMode.splash,
                    size: 4.w,
                  ))
              : null,
          hintStyle: GoogleFonts.tajawal(
              color: LightMode.splash,
              fontSize: 4.w,
              fontWeight: FontWeight.w500),
          hintText: text,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LightMode.splash,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LightMode.splash,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LightMode.splash,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LightMode.splash,
            ),
          ),
        ),
      ),
    );
  }

  Widget onBtnClick(text, onPress) {
    return Container(
      margin: EdgeInsets.only(top: 1.h),
      width: 90.w,
      height: 6.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: LightMode.typeUserButton),
          onPressed: onPress,
          child: Text(
            text,
            style: GoogleFonts.tajawal(
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.onBoardOneText
                    : DarkMode.darkModeSplash,
                fontSize: 4.w,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
