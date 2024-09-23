import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/register/register_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/profile/policy_page.dart';
import 'package:mas_app/view/screens/profile/services_page.dart';
import 'package:mas_app/view/screens/register/login/login.dart';
import 'package:mas_app/view/screens/register/main_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

import '../../../../core/constant/colors.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterController registerController = Get.put(RegisterController());
    return Scaffold(
        backgroundColor: sharedPreferences!.getBool("darkMode") == false
            ? LightMode.registerText
            : DarkMode.darkModeSplash,
        body: SingleChildScrollView(
            child: OfflineBuilder(
          connectivityBuilder: (context, ConnectivityResult value, child) {
            final bool connected = value != ConnectivityResult.none;

            if (connected) {
              return GetBuilder<RegisterController>(
                builder: (controller) => controller.statuesRequest ==
                        StatuesRequest.loading
                    ? SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Form(
                        key: controller.signUpGlobalKey,
                        child: Column(
                          children: [
                            appBarRegister(context),
                            bodyRegister(context),
                            textField((val) {
                              return registerController.englishNameValidate(
                                  val!, context);
                            },
                                registerController.userNameEnglish,
                                TextInputType.name,
                                S.of(context).userName,
                                false,
                                false,
                                null,
                                null),
                            textField((val) {
                              return registerController.emailValidate(
                                  val!, context);
                            },
                                registerController.emailController,
                                TextInputType.emailAddress,
                                S.of(context).email,
                                false,
                                false,
                                null,
                                null),
                            textField((val) {
                              return registerController.phoneValidate(
                                  val!, context);
                            },
                                registerController.phoneController,
                                TextInputType.phone,
                                S.of(context).phone,
                                false,
                                false,
                                null,
                                null),
                            textField((val) {
                              return registerController.addressValidate(
                                  val!, context);
                            },
                                registerController.addressController,
                                TextInputType.text,
                                S.of(context).address,
                                false,
                                false,
                                null,
                                null),
                            textFieldChooseGovernate(() {
                              controller.showDialogGovernate();
                            }, controller.governateController),
                            textField(
                              (val) {
                                return registerController.passwordValidate(
                                    val!, context);
                              },
                              registerController.passwordController,
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
                                return registerController
                                    .passwordConfirmationValidate(
                                        val!, context);
                              },
                              registerController.passwordConfirmationController,
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
                            Container(
                              margin: EdgeInsets.only(
                                  top: 3.h, right: 5.w, left: 5.w),
                              height: 3.88.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GetBuilder<RegisterController>(
                                    builder: (controller) => termsText((val) {
                                      controller.checkValue(val);
                                    },
                                        controller.choose,
                                        controller.choose == true
                                            ? LightMode.splash
                                            : sharedPreferences!
                                                        .getBool("darkMode") ==
                                                    false
                                                ? Colors.white
                                                : DarkMode.darkModeSplash),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 80.w,
                                    height: 3.88.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 1.94.h,
                                          child: multiTextSignUp(
                                            S.of(context).multiText_1,
                                            () {
                                              Get.to(
                                                  () => const ServicesPage());
                                            },
                                            S.of(context).multiText_2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.94.h,
                                          child: multiTextSignUp(
                                            S.of(context).multiText_3,
                                            () {
                                              Get.to(() => const PolicyPage());
                                            },
                                            S.of(context).multiText_4,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onBtnClick(S.of(context).signup, () {
                              controller.signUp(context);
                            }),
                            bottomText(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            }, context),
                          ],
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
        )));
  }
}

Widget termsText(onTap, value, colorCheck) {
  return Container(
      decoration: BoxDecoration(
          color: sharedPreferences!.getBool("darkMode") == false
              ? Colors.white
              : DarkMode.darkModeSplash,
          border: Border.all(color: LightMode.registerButton),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      width: 4.5.w,
      height: 4.5.w,
      child: Checkbox(
          activeColor: colorCheck,
          checkColor: Colors.white,
          side: BorderSide(color: LightMode.registerButton),
          value: value,
          onChanged: onTap));
}

Widget bottomText(onTap, context) {
  return Container(
    margin: const EdgeInsets.only(top: 20, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textTerms(
          S.of(context).haveAccount,
          TextAlign.right,
          3.w,
          FontWeight.w500,
        ),
        InkWell(
            onTap: onTap,
            child: Text(
              S.of(context).login,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: GoogleFonts.tajawal(
                fontSize: 3.5.w,
                color: LightMode.registerButton,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    ),
  );
}

Widget onBtnClick(text, onPress) {
  return Container(
    margin: EdgeInsets.only(top: 1.h),
    width: 90.w,
    height: 6.h,
    child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: LightMode.typeUserButton),
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

Widget multiTextSignUp(text, onPressed, textTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      textTerms(
        text,
        TextAlign.right,
        3.w,
        FontWeight.w500,
      ),
      InkWell(
          onTap: onPressed,
          child: Text(
            textTap,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
                fontSize: 3.w,
                fontWeight: FontWeight.w500,
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.registerButton
                    : DarkMode.buttonDarkColor),
          )),
    ],
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

Widget appBarRegister(context) {
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
                  Navigator.canPop(context)
                      ? Get.back()
                      : Get.off(() => const MainRegister());
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
              S.of(context).titleSign,
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

Widget bodyRegister(context) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 1.h, bottom: 2.h, right: 5.w, left: 5.w),
      child: Text(
        S.of(context).bodySign,
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

Widget textField(String? Function(String?)? validator, controller, keyboardType,
    text, bool icon, obscure, iconButton, onPress) {
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
                  size: 4.w,
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

Widget textFieldChooseGovernate(onPress, governateController) {
  return InkWell(
    onTap: onPress,
    child: Container(
      margin: EdgeInsets.only(bottom: 5.w),
      width: 90.w,
      height: 9.h,
      child: TextFormField(
        style: GoogleFonts.tajawal(
            color: LightMode.splash,
            fontSize: 4.w,
            fontWeight: FontWeight.w500),
        controller: governateController,
        decoration: InputDecoration(
          enabled: false,
          hintStyle: GoogleFonts.tajawal(
              color: LightMode.splash,
              fontSize: 4.w,
              fontWeight: FontWeight.w500),
          hintText: "اضغط لاختيار المحافظة",
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LightMode.splash,
            ),
          ),
        ),
      ),
    ),
  );
}
