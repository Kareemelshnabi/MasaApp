// // ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

// import 'package:flutter/material.dart';
// import 'package:flutter_offline/flutter_offline.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mas_app/controller/register/verify_code_controller.dart';
// import 'package:mas_app/core/class/status_request.dart';
// import 'package:mas_app/main.dart';
// import 'package:mas_app/view/screens/register/login/succcess_login.dart';
// import 'package:screen_go/extensions/responsive_nums.dart';

// import '../../../../core/constant/colors.dart';
// import '../../../../core/constant/images.dart';

// class VerifyCodeLogin extends StatelessWidget {
//   const VerifyCodeLogin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(VerifyCodeController());
//     return Localizations(
//       locale: const Locale("en"),
//       delegates: const [
//         DefaultMaterialLocalizations.delegate,
//         DefaultWidgetsLocalizations.delegate,
//         DefaultMaterialLocalizations.delegate
//       ],
//       child: Scaffold(
//         backgroundColor: LightMode.registerText,
//           body: OfflineBuilder(
//         connectivityBuilder: (context, ConnectivityResult value, child) {
//           final bool connected = value != ConnectivityResult.none;

//           if (connected) {
//             return GetBuilder<VerifyCodeController>(
//               builder: (controller) =>
//                   controller.statuesRequest == StatuesRequest.loading
//                       ? SizedBox(
//                           width: 100.w,
//                           height: 100.h,
//                           child: const Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         )
//                       : Column(
//                           children: [
//                             appBarForgetPass(context),
//                             Image.asset(
//                               ImagesLink.verifyImage,
//                               width: 60.w,
//                               height: 30.h,
//                               fit: BoxFit.fill,
//                             ),
//                             bodyVerifyCode(context),
//                             otpRegister(controller.verifyCodeLogin),
//                             onBtnClick(
//                                 sharedPreferences!.getString("local") == "ar"
//                                     ? "إرسال"
//                                     : "Send", () {
//                               Get.off(() => const SuccessLogin());

//                               //controller.verifyCodeLoginController();
//                             })
//                           ],
//                         ),
//             );
//           } else {
//             return SizedBox(
//                 height: 100.h,
//                 width: 100.w,
//                 child: const Center(child: Text("no internet ............ !")));
//           }
//         },
//         child: const CircularProgressIndicator(),
//       )),
//     );
//   }

//   Widget onBtnClick(text, onPress) {
//     return Container(
//       margin: EdgeInsets.only(top: 1.h),
//       width: 90.w,
//       height: 6.h,
//       child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//               backgroundColor: LightMode.typeUserButton),
//           onPressed: onPress,
//           child: Text(
//             text,
//             style: GoogleFonts.tajawal(
//                 color: LightMode.onBoardOneText,
//                 fontSize: 4.w,
//                 fontWeight: FontWeight.w500),
//           )),
//     );
//   }

//   Widget bodyVerifyCode(context) {
//     return Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 3.h, bottom: 3.h, right: 5.w, left: 5.w),
//         child: Text(
//           sharedPreferences!.getString("local") == "ar"
//               ? "من فضلك قم بإدخال الرمز المرسل الى رقم الهاتف الخاص بك حتى تستطيع المتابعة."
//               : "Please enter the code sent to your phone number so you can continue.",
//           textAlign: TextAlign.center,
//           style: GoogleFonts.tajawal(
//             fontSize: 3.5.w,
//             fontWeight: FontWeight.w500,
//             color: LightMode.typeUserBody,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget otpRegister(verifyCode) {
//     return Center(
//       child: SizedBox(
//         height: 12.h,
//         width: 90.w,
//         child: OtpTextField(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,

//           textStyle: GoogleFonts.tajawal(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w500,
//               color: LightMode.splash),
//           fieldWidth: 11.w,
//           fieldHeight: 7.h,
//           borderColor: LightMode.registerButton,
//           borderWidth: 2,
//           numberOfFields: 6,
//           margin: EdgeInsets.only(right: 2.w, left: 2.w),
//           fillColor: Colors.white,
//           filled: false,

//           borderRadius: BorderRadius.circular(20),
//           showFieldAsBox: true,
//           disabledBorderColor: LightMode.registerButton,
//           enabledBorderColor: LightMode.registerButton,

//           onSubmit: (String verificationCode) {
//             verifyCode = verificationCode;
//             print("  cooooode   ===??? ${verifyCode}");
//           }, // end onSubmit
//         ),
//       ),
//     );
//   }

//   Widget appBarForgetPass(context) {
//     return SizedBox(
//       width: 100.w,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           sharedPreferences!.getString("local") == "ar"
//               ? Expanded(flex: 1, child: Container())
//               : Expanded(
//                   flex: 1,
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 7.w),
//                     child: IconButton(
//                         onPressed: () {
//                           sharedPreferences!
//                               .setString("pageStart", "typeOfUser");
//                           Get.back();
//                         },
//                         icon: const Icon(Icons.arrow_back_ios)),
//                   ),
//                 ),
//           Expanded(
//             flex: 3,
//             child: Container(
//               margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h, left: 13.w),
//               child: Text(
//                 sharedPreferences!.getString("local") == "ar"
//                     ? "التحقق من الرمز"
//                     : "verify code",
//                 style: GoogleFonts.tajawal(
//                   fontSize: 5.w,
//                   fontWeight: FontWeight.bold,
//                   color: LightMode.typeUserTitle,
//                 ),
//               ),
//             ),
//           ),
//           sharedPreferences!.getString("local") == "ar"
//               ? Expanded(
//                   flex: 1,
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 7.w),
//                     child: IconButton(
//                         onPressed: () {
//                           sharedPreferences!
//                               .setString("pageStart", "typeOfUser");
//                           Get.back();
//                         },
//                         icon: const Icon(Icons.arrow_forward_ios)),
//                   ),
//                 )
//               : Expanded(flex: 1, child: Container()),
//         ],
//       ),
//     );
//   }
// }
