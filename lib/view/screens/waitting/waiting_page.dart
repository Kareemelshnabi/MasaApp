// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mas_app/controller/waiting/waiting_controller.dart';
// import 'package:mas_app/core/constant/colors.dart';
// import 'package:screen_go/extensions/responsive_nums.dart';
// import 'package:slide_countdown/slide_countdown.dart';

// class WaitingPage extends StatelessWidget {
//   const WaitingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(WaitingController());

//     return Localizations(
//       locale: const Locale("en"),
//       delegates: const [
//         DefaultMaterialLocalizations.delegate,
//         DefaultWidgetsLocalizations.delegate,
//         DefaultMaterialLocalizations.delegate
//       ],
//       child: Scaffold(
//         body: Container(
//           padding: EdgeInsets.only(right: 4.w, left: 4.w),
//           width: 100.w,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               iconWait(),
//               titlePage("يتم تجهيز خدمتك"),
//               bodyTextPage(
//                   "فى الوقت الحالى يتم تجهيز مسؤول للرد على الخدمة التى طلبتها لتحصل عليها بأفضل شكل.",
//                   FontWeight.w500),
//               GetBuilder<WaitingController>(
//                   builder: (controller) => timeWaiting(0, 0, 20)),
//               bodyTextPage(
//                   "ولكن في هذه الأثناء يمكنك حل اﻷلغاز التى بالاسفل للحصول على نقاط الخصومات.",
//                   FontWeight.w700),
//               quizPart(() {}, () {}, () {}, () {}, 100),
//               onBtnClick("العودة للصفحة الرئيسية", () {}),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget timeWaiting(int hour, int minute, int second) {
//     return Padding(
//       padding: EdgeInsets.only(top: 5.w, bottom: 3.w),
//       child: Center(
//         child: SlideCountdownSeparated(
//           duration: Duration(hours: hour, minutes: minute, seconds: second),
//           separator: ":",
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(2.w),
//               border: Border.all(color: LightMode.splash),
//               color: LightMode.registerText),
//           showZeroValue: true,
//           shouldShowDays: (p0) => false,
//           style: GoogleFonts.tajawal(
//               color: LightMode.splash,
//               fontSize: 6.w,
//               fontWeight: FontWeight.bold),
//           onChanged: (t) {
//             t == const Duration(hours: 0, minutes: 0, seconds: 0)
//                 ? print("done")
//                 : print(t.toString());
//           },
//           separatorStyle: GoogleFonts.tajawal(
//               color: LightMode.splash,
//               fontSize: 5.w,
//               fontWeight: FontWeight.bold),
//           padding: EdgeInsets.only(top: 2.w, left: 2.w, right: 2.w, bottom: 1),
//           separatorPadding: EdgeInsets.only(right: 2.w, left: 2.w),
//         ),
//       ),
//     );
//   }

//   Widget iconWait() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 3.w),
//       padding: EdgeInsets.all(3.w),
//       decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: LightMode.splash, width: 1.5)),
//       child: Icon(
//         Icons.av_timer_outlined,
//         color: LightMode.splash,
//         size: 15.w,
//       ),
//     );
//   }

//   Widget bodyTextPage(text, weight) {
//     return Container(
//       margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 2.w),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: GoogleFonts.tajawal(
//             color: LightMode.registerButtonBorder,
//             fontSize: 3.w,
//             fontWeight: weight),
//       ),
//     );
//   }

//   Widget titlePage(text) {
//     return Text(
//       text,
//       style: GoogleFonts.tajawal(
//           color: LightMode.registerButtonBorder,
//           fontSize: 5.w,
//           fontWeight: FontWeight.bold),
//     );
//   }

//   Widget quizPart(
//       onChooseOne, onChooseTwo, onChooseThree, onChooseFour, points) {
//     return Container(
//       margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 5.w, bottom: 4.w),
//       width: 100.w,
//       height: 35.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(3.w),
//         border: Border.all(color: LightMode.splash, width: 2),
//       ),
//       child: Column(
//         children: [
//           rowTitleQuiz(points),
//           answerQuiz("المحيط الأطلسي", onChooseOne),
//           answerQuiz("المحيط الأطلسي", onChooseTwo),
//           answerQuiz("المحيط الأطلسي", onChooseThree),
//           answerQuiz("المحيط الأطلسي", onChooseFour),
//         ],
//       ),
//     );
//   }

//   Widget answerQuiz(text, onClick) {
//     return InkWell(
//       onTap: onClick,
//       child: Container(
//         padding: EdgeInsets.only(right: 3.w, top: 2.w),
//         margin: EdgeInsets.only(right: 3.w, left: 3.w, top: 2.w, bottom: 2.w),
//         width: 90.w,
//         height: 4.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(2.w),
//           border: Border.all(color: LightMode.splash, width: 1),
//         ),
//         child: Text(
//           text,
//           textAlign: TextAlign.right,
//           style: GoogleFonts.tajawal(
//             fontWeight: FontWeight.w500,
//             fontSize: 3.5.w,
//             color: LightMode.splash,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget rowTitleQuiz(points) {
//     return Container(
//       margin: EdgeInsets.only(right: 4.w, left: 3.w, top: 2.w, bottom: 2.w),
//       width: 100.w,
//       height: 5.h,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             width: 20.w,
//             height: 7.w,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(2.w),
//                 border: Border.all(color: LightMode.splash, width: 2)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 1.w, left: 1.w),
//                   child: Text(
//                     "$points نقطة",
//                     style: GoogleFonts.tajawal(
//                         color: LightMode.splash,
//                         fontSize: 3.w,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 1.w),
//                   child: Icon(
//                     Icons.cake,
//                     color: LightMode.splash,
//                     size: 4.w,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             "ما هو أكبر محيط في العالم؟",
//             style: GoogleFonts.tajawal(
//               fontWeight: FontWeight.w700,
//               fontSize: 4.w,
//               color: LightMode.registerButtonBorder,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget onBtnClick(text, onPress) {
//     return Container(
//       margin: EdgeInsets.only(top: 1.h),
//       width: 85.w,
//       height: 5.h,
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
// }
