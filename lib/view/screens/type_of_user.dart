// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mas_app/controller/on_boarding_controller.dart';
// import 'package:mas_app/core/constant/colors.dart';
// import 'package:mas_app/generated/l10n.dart';
// import 'package:mas_app/main.dart';
// import 'package:mas_app/view/screens/home/home.dart';
// import 'package:mas_app/view/screens/register/main_register.dart';
// import 'package:screen_go/extensions/responsive_nums.dart';

// import '../../core/constant/images.dart';

// class TypeOfUser extends StatelessWidget {
//   const TypeOfUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(OnBoardingController());
//     return Scaffold(
//       body: GetBuilder<OnBoardingController>(
//         builder: (controller) => Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             appBarTypeOfUser(context),
//             bodyTypeOfUser(context),
//             SizedBox(
//               height: 4.w,
//             ),
//             InkWell(
//               onTap: () {
                
//                 controller.chooseType("visit");
//               },
//               child: cardTypeOfUser(
//                   //  "زائر",
//                   S.of(context).visit,
//                   ImagesLink.visitImage,
//                   controller.chooseVisit == true
//                       ? Border.all(color: LightMode.splash, width: 3)
//                       : null),
//             ),
//             SizedBox(
//               height: 7.w,
//             ),
//             InkWell(
//               onTap: () {
//                 controller.chooseType("seller");
//               },
//               child: cardTypeOfUser(
//                   //"مشتري",
//                   S.of(context).seller,
//                   ImagesLink.sellerImage,
//                   controller.chooseSeller == true
//                       ? Border.all(color: LightMode.splash, width: 3)
//                       : null),
//             ),
//             onBtnClick(() {
//               controller.chooseVisit == true
//                   ? sharedPreferences!.setString("img", "")
//                   : null;
//               controller.chooseVisit == true
//                   ? Get.offAll(() => const Home(),
//                       transition: Transition.upToDown,
//                       duration: const Duration(milliseconds: 1200))
//                   : Get.to(() => const MainRegister());
//             }, context)
//           ],
//         ),
//       ),
//     );
//   }

//   Widget appBarTypeOfUser(context) {
//     return Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 7.h, bottom: 2.h),
//         child: Text(
//           // "حدد نوع المستخدم",
//           S.of(context).titleOftypePage,
//           style: GoogleFonts.tajawal(
//             fontSize: 5.5.w,
//             fontWeight: FontWeight.bold,
//             color: LightMode.typeUserTitle,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget bodyTypeOfUser(context) {
//     return Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 1.h, bottom: 2.h, right: 5.w, left: 5.w),
//         child: Text(
//           // "من فضلك حدد نوع المستخدم الذي يصف دورك بشكل أفضل لمساعدتك بأفضل شكل.",
//           S.of(context).bodyOftypePage,
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

//   Widget cardTypeOfUser(text, image, border) {
//     return Container(
//       height: 14.h,
//       width: 80.w,
//       padding: EdgeInsets.all(3.w),
//       decoration: BoxDecoration(
//         border: border,
//         borderRadius: BorderRadius.circular(20),
//         image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: GoogleFonts.tajawal(
//               color: LightMode.onBoardOneText,
//               fontSize: 7.w,
//               fontWeight: FontWeight.w400),
//         ),
//       ),
//     );
//   }

//   Widget onBtnClick(onPress, context) {
//     return Container(
//       margin: EdgeInsets.only(top: 5.h),
//       width: 80.w,
//       height: 5.h,
//       child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//               backgroundColor: LightMode.typeUserButton),
//           onPressed: onPress,
//           child: Text(
//             //"تأكيد",
//             S.of(context).bottomOfTypePage,
//             style: GoogleFonts.tajawal(
//                 color: LightMode.onBoardOneText,
//                 fontSize: 4.w,
//                 fontWeight: FontWeight.w500),
//           )),
//     );
//   }
// }
