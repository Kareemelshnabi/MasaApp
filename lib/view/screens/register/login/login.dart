import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/register/login_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/forget_pass/add_new_password.dart';
import 'package:mas_app/view/screens/register/signup/signup.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

import '../../../../core/constant/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
        backgroundColor: sharedPreferences!.getBool("darkMode") == false
            ? LightMode.registerText
            : DarkMode.darkModeSplash,
        body: OfflineBuilder(
          connectivityBuilder: (context, ConnectivityResult value, child) {
            final bool connected = value != ConnectivityResult.none;

            if (connected) {
              return GetBuilder<LoginController>(
                builder: (controller) =>
                    controller.statuesRequest == StatuesRequest.loading
                        ? SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Form(
                              key: controller.loginGlobalKey,
                              child: Column(
                                children: [
                                  appBarLogin(context),
                                  bodyLogin(context),
                                  textField((val) {
                                    return loginController.phoneValidate(
                                        val!, context);
                                  },
                                      loginController.phoneController,
                                      TextInputType.phone,
                                      S.of(context).phone,
                                      false,
                                      false,
                                      null,
                                      null),
                                  textField(
                                    (val) {
                                      return loginController.passwordValidate(
                                          val!, context);
                                    },
                                    loginController.passwordController,
                                    TextInputType.visiblePassword,
                                    S.of(context).password,
                                    true,
                                    controller.showPass,
                                    controller.showPass == false
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    () {
                                      controller.showPassword();
                                    },
                                  ),
                                  multiTextSignUp(() {
                                    Get.to(() => const AddNewPassword());
                                  }, S.of(context).forgetPass),
                                  SizedBox(
                                    height: 6.w,
                                  ),
                                  onBtnClick(S.of(context).login, () {
                                    print("object");
                                    controller.login(context);
                                  }),
                                  bottomText(() {
                                    Get.off(() => const SignUp());
                                  }, context),
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

  Widget bottomText(onTap, context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textTerms(
            S.of(context).notHaveAccount,
            TextAlign.right,
            2.5.w,
            FontWeight.w500,
          ),
          InkWell(
              onTap: onTap,
              child: Text(
                S.of(context).signup,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: GoogleFonts.tajawal(
                  fontSize: 2.7.w,
                  color: LightMode.registerButton,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
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

  Widget appBarLogin(context) {
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
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 6.w,
                    color: sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor,
                  )),
            ),
          ),
          SizedBox(
            width: 60.w,
            child: Container(
              margin: EdgeInsets.only(top: 7.h, bottom: 2.h, right: 13.w),
              child: Text(
                S.of(context).titleLoginPage,
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

  Widget multiTextSignUp(onPressed, textTap) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.only(right: 5.w),
          width: 100.w,
          child: Text(
            textTap,
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
                fontSize: 3.5.w,
                fontWeight: FontWeight.w500,
                color: LightMode.registerButton),
          ),
        ));
  }

  Widget bodyLogin(context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 1.h, bottom: 2.h, right: 5.w, left: 5.w),
        child: Text(
          S.of(context).bodyLoginPage,
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
        style: GoogleFonts.tajawal(
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.splash
                : DarkMode.whiteDarkColor,
            fontSize: 4.w,
            fontWeight: FontWeight.w500),
        obscureText: obscure == true ? true : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: icon == true
              ? InkWell(
                  onTap: onPress,
                  child: Icon(
                    iconButton,
                    size: 5.w,
                    color: LightMode.splash,
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
