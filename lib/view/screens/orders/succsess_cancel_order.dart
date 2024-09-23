// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mas_app/core/constant/colors.dart';
// import 'package:mas_app/core/constant/images.dart';
// import 'package:mas_app/view/screens/home/home.dart';
// import 'package:mas_app/view/screens/orders/my_orders.dart';
// import 'package:screen_go/extensions/responsive_nums.dart';

// class SuccsessCancelOrder extends StatelessWidget {
//   const SuccsessCancelOrder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: LightMode.splash,
//       body: SizedBox(
//         height: 100.h,
//         width: 100.w,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               ImagesLink.succsessCancelOrder,
//               width: 30.w,
//               height: 15.h,
//               fit: BoxFit.fill,
//             ),
//             SizedBox(
//               height: 3.w,
//             ),
//             Text(
//               "تم إلغاء طلبك ",
//               style: GoogleFonts.tajawal(
//                   color: LightMode.registerText,
//                   fontSize: 3.5.w,
//                   fontWeight: FontWeight.w700),
//             ),
//             SizedBox(
//               height: 3.w,
//             ),
//             SizedBox(
//               width: 50.w,
//               height: 10.h,
//               child: Text(
//                 "شكرا لإستخدامك تطبيقنا. نأمل رؤيتك قريبا لتوفير كل ما ترغب به معنا.",
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.tajawal(
//                     color: LightMode.registerText,
//                     fontSize: 3.w,
//                     fontWeight: FontWeight.w500),
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Get.off(() => const MyOrders());
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: LightMode.registerText,
//                       borderRadius: BorderRadius.circular(3.w),
//                     ),
//                     width: 60.w,
//                     height: 5.h,
//                     child: Center(
//                       child: Text(
//                         "تصفح طلباتك",
//                         style: GoogleFonts.tajawal(
//                             fontSize: 3.w,
//                             color: LightMode.splash,
//                             fontWeight: FontWeight.w800),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.w,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Get.off(() => const Home());
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border:
//                           Border.all(color: LightMode.registerText, width: 2),
//                       borderRadius: BorderRadius.circular(3.w),
//                     ),
//                     width: 60.w,
//                     height: 5.h,
//                     child: Center(
//                       child: Text(
//                         "عودة للصفحة الرئيسية",
//                         style: GoogleFonts.tajawal(
//                             fontSize: 3.w,
//                             color: LightMode.registerText,
//                             fontWeight: FontWeight.w800),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
