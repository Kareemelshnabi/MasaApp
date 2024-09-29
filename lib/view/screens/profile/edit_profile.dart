import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/profile/profile_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      body: SingleChildScrollView(
        child: GetBuilder<ProfileController>(
          builder: (controller) => controller.statuesRequest ==
                  StatuesRequest.loading
              ? SizedBox(
                  height: 88.h,
                  width: 100.w,
                  child: const Center(child: CircularProgressIndicator()))
              : Column(
                  children: [
                    appBarProfile(),
                    GetBuilder<ProfileController>(
                      builder: (controller) => topOfProfile(
                          controller.image == null
                              ? (sharedPreferences!.getString("img") == ""
                                  ? Container(
                                      padding: EdgeInsets.all(1.w),
                                      margin: EdgeInsets.only(
                                          top: 5.w, bottom: 5.w),
                                      width: 20.w,
                                      height: 20.w,
                                      decoration: BoxDecoration(
                                          color: LightMode.registerButtonBorder,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              ImagesLink.noProfileImage,
                                            ),
                                            fit: BoxFit.fill,
                                          )),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(1.w),
                                      margin: EdgeInsets.only(
                                          top: 5.w, bottom: 5.w),
                                      width: 20.w,
                                      height: 20.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                sharedPreferences!
                                                    .getString("img")!),
                                            fit: BoxFit.fill,
                                          )),
                                    ))
                              : Container(
                                  padding: EdgeInsets.all(1.w),
                                  margin:
                                      EdgeInsets.only(top: 5.w, bottom: 5.w),
                                  width: 20.w,
                                  height: 20.w,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: LightMode.splash),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: FileImage(
                                            controller.image!,
                                          ),
                                          fit: BoxFit.fill)),
                                ), () {
                        print("jjjjjjjjjjjjjj");
                        controller.canEdit();

                        controller.showMessageUpdateImage(context);
                      }),
                    ),
                    GetBuilder<ProfileController>(
                      builder: (controller) => Container(
                        margin: EdgeInsets.only(
                            top: 2.w, bottom: 2.w, right: 4.w, left: 4.w),
                        child: Form(
                          key: controller.profileGlobalKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              rowTitle(() {
                                controller.canEdit();
                              }, S.of(context).personalInfo, controller.edit),
                              field(
                                  S.of(context).name,
                                  controller.englishNameController,
                                  S.of(context).name,
                                  controller.edit, (val) {
                                return controller.nameValidate(val!);
                              }, false, null, null, false),
                              SizedBox(
                                height: 3.w,
                              ),
                              field(
                                  S.of(context).email,
                                  controller.emailController,
                                  S.of(context).email,
                                  controller.edit, (val) {
                                return controller.emailValidate(val!);
                              }, false, null, null, false),
                              SizedBox(
                                height: 3.w,
                              ),
                              field(
                                  S.of(context).phone,
                                  controller.phoneController,
                                  S.of(context).phone,
                                  false, (val) {
                                return null;
                              }, false, null, null, false),
                              SizedBox(
                                height: 3.w,
                              ),
                              field(
                                  S.of(context).address,
                                  controller.addressController,
                                  S.of(context).address,
                                  controller.edit, (val) {
                                return controller.addressValidate(val!);
                              }, false, null, null, false),
                              SizedBox(
                                height: 3.w,
                              ),
                              field(
                                  S.of(context).country,
                                  controller.countryController,
                                  S.of(context).country,
                                  false, (val) {
                                return null;
                              }, false, null, null, false),
                              SizedBox(
                                height: 3.w,
                              ),
                              Text(
                                S.of(context).governorate,
                                style: GoogleFonts.tajawal(
                                    fontSize: 3.w, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 2.w,
                              ),
                              textFieldChooseGovernate(
                                  controller.edit == true
                                      ? () {
                                          controller.showDialogGovernate();
                                        }
                                      : () {},
                                  controller.governorateController),
                              rowTitle(() {
                                controller.canEdit();
                              }, S.of(context).profileInfoTitle,
                                  controller.edit),
                              field(
                                  S.of(context).currentPass,
                                  controller.currentPasswordController,
                                  S.of(context).currentPass,
                                  controller.edit,
                                  (val) {
                                    return null;
                                  },
                                  controller.showPass1,
                                  controller.showPass1 == false
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  () {
                                    controller.showPassword1();
                                  },
                                  true),
                              SizedBox(
                                height: 3.w,
                              ),
                              field(
                                  S.of(context).newPass,
                                  controller.newPasswordController,
                                  S.of(context).newPass,
                                  controller.edit,
                                  (val) {
                                    return null;
                                  },
                                  controller.showPass3,
                                  controller.showPass3 == false
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  () {
                                    controller.showPassword3();
                                  },
                                  true),
                              SizedBox(
                                height: 3.w,
                              ),
                              field(
                                  S.of(context).confirmPass,
                                  controller.passwordConfirmationController,
                                  S.of(context).confirmPass,
                                  controller.edit,
                                  (val) {
                                    return controller
                                        .passwordConfirmationValidate(val!);
                                  },
                                  controller.showPass2,
                                  controller.showPass2 == false
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  () {
                                    controller.showPassword2();
                                  },
                                  true),
                              SizedBox(
                                height: 5.w,
                              ),
                              controller.edit == true
                                  ? onBtnClickSave(S.of(context).saveChange,
                                      () async {
                                      controller.canEdit();
                                      await controller.updateProfile();
                                      if (controller.succsess == true) {
                                        controller.showSuccsessUpdate();
                                        Timer(
                                          const Duration(milliseconds: 2000),
                                          () {
                                            Get.offAll(() => const Home());
                                          },
                                        );
                                      } else {}
                                    })
                                  : const SizedBox(),
                              SizedBox(
                                height: 5.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

Widget textFieldChooseGovernate(onPress, governateController) {
  return InkWell(
    onTap: onPress,
    child: Container(
      margin: EdgeInsets.only(bottom: 5.w),
      width: 100.w,
      height: 9.h,
      child: TextFormField(
        style: GoogleFonts.tajawal(
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.splash
                : DarkMode.whiteDarkColor,
            fontSize: 4.w,
            fontWeight: FontWeight.w500),
        controller: governateController,
        decoration: InputDecoration(
          enabled: false,
          hintStyle: GoogleFonts.tajawal(
              color: LightMode.splash,
              fontSize: 4.w,
              fontWeight: FontWeight.w500),
          hintText: S.of(Get.context!).chhoseGovernorate,
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

Widget appBarProfile() {
  return SizedBox(
    width: 100.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h),
            child: Text(
              S.of(Get.context!).editProfile,
              style: GoogleFonts.tajawal(
                fontSize: 5.w,
                fontWeight: FontWeight.bold,
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.registerButtonBorder
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

Widget topOfProfile(img, onPress) {
  return Container(
    padding: EdgeInsets.all(5.w),
    width: 65.w,
    height: 28.5.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(3.w),
      border: Border.all(color: LightMode.splash, width: 2),
    ),
    child: Column(
      children: [
        Text(
          S.of(Get.context!).image,
          style: GoogleFonts.tajawal(
              fontSize: 3.w,
              fontWeight: FontWeight.w700,
              color: LightMode.splash),
        ),
        img,
        onBtnClick(S.of(Get.context!).changeImage, onPress)
      ],
    ),
  );
}

Widget onBtnClick(text, onPress) {
  return SizedBox(
    width: 35.w,
    height: 3.h,
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
              fontSize: 3.w,
              fontWeight: FontWeight.w500),
        )),
  );
}

Widget onBtnClickSave(text, onPress) {
  return SizedBox(
    width: 100.w,
    height: 6.h,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: LightMode.splash),
        onPressed: onPress,
        child: Text(
          text,
          style: GoogleFonts.tajawal(
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.registerText
                  : DarkMode.darkModeSplash,
              fontSize: 4.w,
              fontWeight: FontWeight.w500),
        )),
  );
}

Widget field(title, controller, hintText, edit,
    String? Function(String?)? onValidate, obscure, icon, onPressShow, pass) {
  return SizedBox(
    width: 100.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.tajawal(
              fontSize: 3.w,
              fontWeight: FontWeight.w500,
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.registerButtonBorder
                  : DarkMode.whiteDarkColor),
        ),
        SizedBox(
          height: 3.w,
        ),
        textField(controller, hintText, edit, onValidate, obscure, icon,
            onPressShow, pass)
      ],
    ),
  );
}

Widget textField(controller, text, edit, String? Function(String?)? onValidate,
    obscure, icon, onPressShow, pass) {
  return SizedBox(
    height: 9.h,
    child: TextFormField(
      obscureText: obscure == true ? true : false,
      style: GoogleFonts.tajawal(
          color: sharedPreferences!.getBool("darkMode") == false
              ? LightMode.splash
              : DarkMode.whiteDarkColor,
          fontSize: 3.w,
          fontWeight: FontWeight.w500),
      validator: onValidate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: pass == true
            ? InkWell(
                onTap: onPressShow,
                child: Icon(
                  icon,
                  color: LightMode.splash,
                ))
            : null,
        contentPadding: EdgeInsets.only(top: 1.w, right: 2.w, left: 2.w),
        hintStyle: GoogleFonts.tajawal(
            color: LightMode.splash,
            fontSize: 3.w,
            fontWeight: FontWeight.w500),
        hintText: text,
        enabled: edit,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: BorderSide(
            color: LightMode.splash,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: BorderSide(
            color: LightMode.splash,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: BorderSide(
            color: LightMode.splash,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: BorderSide(
            color: LightMode.splash,
          ),
        ),
      ),
    ),
  );
}

Widget rowTitle(onPress, text, edit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: GoogleFonts.tajawal(
            fontSize: 4.w,
            fontWeight: FontWeight.bold,
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.registerButtonBorder
                : DarkMode.whiteDarkColor),
      ),
      TextButton(
          onPressed: onPress,
          child: Text(
            edit == true ? "" : S.of(Get.context!).edit,
            style: GoogleFonts.tajawal(
              color: LightMode.splash,
              fontSize: 3.w,
              fontWeight: FontWeight.w700,
            ),
          ))
    ],
  );
}
