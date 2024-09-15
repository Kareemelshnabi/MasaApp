// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mas_app/controller/orders/cart_controller.dart';
// import 'package:mas_app/core/constant/colors.dart';
// import 'package:mas_app/core/constant/images.dart';
// import 'package:screen_go/extensions/responsive_nums.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(CartController());
//     return Column(
//       children: [
//         appBarCart(),
//         GetBuilder<CartController>(
//           builder: (controller) => controller.itemCart.isNotEmpty
//               ? noData()
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 45.h,
//                         child: ListView.builder(
//                           itemBuilder: (context, index) => cardItem(() {
//                             controller.setIndex(index);
//                             controller.add();
//                           }, () {
//                             controller.setIndex(index);

//                             controller.remove();
//                           },
//                               controller.index == index
//                                   ? controller.itemCount
//                                   : "0",
//                               6000,
//                               2000,
//                               "الماسه استور لطباعة الورق وعمل الأختام منتجات درجة أولي والأعلي بالكويت - أسود - خشب - 5*5 ",
//                               "ختم",
//                               ImagesLink.googleImage),
//                           itemCount: 8,
//                           padding: EdgeInsets.only(top: 4.w),
//                           shrinkWrap: true,
//                         ),
//                       ),
//                       discountField(
//                           controller.discountController, "كود الخصم", () {}),
//                       infoOfOrder(),
//                       onBtnClick("اشتر الآن", () {}),
//                     ],
//                   ),
//                 ),
//         ),
//       ],
//     );
//   }

//   Widget infoOfOrder() {
//     return Container(
//       margin: EdgeInsets.only(right: 4.w, left: 4.w),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(
//           "معلومات الطلب",
//           style:
//               GoogleFonts.tajawal(fontSize: 3.5.w, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(
//           height: 2.w,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "شحن",
//               style: GoogleFonts.tajawal(
//                   fontSize: 3.w, fontWeight: FontWeight.w600),
//             ),
//             Text(
//               "50 دينار",
//               style: GoogleFonts.tajawal(
//                   fontSize: 3.w, fontWeight: FontWeight.w600),
//             )
//           ],
//         ),
//         SizedBox(
//           height: 2.w,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "ضريبة",
//               style: GoogleFonts.tajawal(
//                   fontSize: 3.w, fontWeight: FontWeight.w700),
//             ),
//             Text(
//               "0 دينار",
//               style: GoogleFonts.tajawal(
//                   fontSize: 3.w, fontWeight: FontWeight.w700),
//             )
//           ],
//         ),
//         SizedBox(
//           height: 2.w,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "إجمالي المبلغ",
//               style: GoogleFonts.tajawal(
//                   fontSize: 3.w, fontWeight: FontWeight.w700),
//             ),
//             Text(
//               "50 دينار",
//               style: GoogleFonts.tajawal(
//                   fontSize: 3.w, fontWeight: FontWeight.w700),
//             )
//           ],
//         ),
//         SizedBox(
//           height: 2.w,
//         ),
//         Divider(
//           color: LightMode.registerButtonBorder,
//           thickness: 2,
//         ),
//         SizedBox(
//           height: 2.w,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "الإجمالي",
//               style: GoogleFonts.tajawal(
//                   fontSize: 4.w, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "50 دينار",
//               style: GoogleFonts.tajawal(
//                   fontSize: 4.w, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }

//   Widget discountField(controller, text, onClick) {
//     return Container(
//       margin: EdgeInsets.only(right: 4.w, left: 4.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           textField(controller, text),
//           TextButton(
//               onPressed: onClick,
//               child: Text(
//                 "تأكيد",
//                 style: GoogleFonts.tajawal(
//                     color: LightMode.splash,
//                     fontSize: 3.w,
//                     fontWeight: FontWeight.w700),
//               ))
//         ],
//       ),
//     );
//   }

//   Widget textField(controller, text) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 4.w, top: 3.w),
//       width: 72.w,
//       height: 4.h,
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(right: 2.w),
//           hintStyle: GoogleFonts.tajawal(
//               color: LightMode.registerButtonBorder,
//               fontSize: 3.w,
//               fontWeight: FontWeight.w700),
//           hintText: text,
//           filled: true,
//           fillColor: LightMode.searchField,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.all(Radius.circular(2.w)),
//           ),
//           disabledBorder: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.all(Radius.circular(2.w))),
//           border: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.all(Radius.circular(2.w)),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget noData() {
//     return Container(
//       margin: EdgeInsets.only(right: 7.w, left: 7.w),
//       height: 60.h,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             ImagesLink.noDtaCartImage,
//             width: 50.w,
//             height: 25.h,
//             fit: BoxFit.fill,
//           ),
//           SizedBox(
//             height: 3.w,
//           ),
//           Text(
//             "لا يوجد مشتريات",
//             style: GoogleFonts.tajawal(
//               fontSize: 4.w,
//               fontWeight: FontWeight.bold,
//               color: LightMode.splash,
//             ),
//           ),
//           SizedBox(
//             height: 2.w,
//           ),
//           Text(
//             textAlign: TextAlign.center,
//             "يمكنك إضافة عنصر إلى سلة لديك عن طريق النقر على إضافة",
//             style: GoogleFonts.tajawal(
//               fontSize: 3.5.w,
//               fontWeight: FontWeight.w500,
//               color: LightMode.splash,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget appBarCart() {
//     return SizedBox(
//       width: 100.w,
//       child: Center(
//         child: Container(
//           margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h),
//           child: Text(
//             "مشترياتي",
//             style: GoogleFonts.tajawal(
//               fontSize: 5.w,
//               fontWeight: FontWeight.bold,
//               color: LightMode.typeUserTitle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget cardItem(addFun, removeFun, countNum, priceWithoutDiscount,
//       priceWithDiscount, discription, nameOfItem, img) {
//     return Container(
//       height: 17.h,
//       width: 100.w,
//       margin: EdgeInsets.only(right: 4.w, left: 4.w, bottom: 4.w),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(4.w)),
//           border: Border.all(color: LightMode.splash, width: 1.5)),
//       child: Row(
//         children: [
//           Container(
//             margin: EdgeInsets.all(4.w),
//             width: 65.w,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       nameOfItem,
//                       style: GoogleFonts.tajawal(
//                           color: LightMode.registerButtonBorder,
//                           fontSize: 4.w,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.star_half,
//                           size: 4.w,
//                           color: LightMode.starColor,
//                         ),
//                         Icon(
//                           Icons.star,
//                           size: 4.w,
//                           color: LightMode.starColor,
//                         ),
//                         Icon(
//                           Icons.star,
//                           size: 4.w,
//                           color: LightMode.starColor,
//                         ),
//                         Icon(
//                           Icons.star,
//                           size: 4.w,
//                           color: LightMode.starColor,
//                         ),
//                         Icon(
//                           Icons.star,
//                           size: 4.w,
//                           color: LightMode.starColor,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 2.w,
//                 ),
//                 Text(
//                   discription,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.right,
//                   style: GoogleFonts.tajawal(
//                       color: LightMode.registerButtonBorder,
//                       fontSize: 2.5.w,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 2.w,
//                 ),
//                 SizedBox(
//                   width: 65.w,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Text(
//                             "$priceWithoutDiscount دينار",
//                             style: TextStyle(
//                                 decoration: TextDecoration.lineThrough,
//                                 decorationColor: LightMode.registerButtonBorder,
//                                 color: LightMode.registerButtonBorder,
//                                 fontSize: 2.5.w,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           SizedBox(
//                             height: 1.w,
//                           ),
//                           Text(
//                             "$priceWithDiscount دينار",
//                             style: GoogleFonts.tajawal(
//                                 color: LightMode.registerButtonBorder,
//                                 fontSize: 2.5.w,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ],
//                       ),
//                       Container(
//                           width: 22.w,
//                           height: 3.h,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(2.w),
//                               border: Border.all(color: LightMode.splash)),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               InkWell(
//                                 onTap: addFun,
//                                 child: Container(
//                                     height: 3.h,
//                                     width: 7.w,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             left: BorderSide(
//                                                 color: LightMode.splash))),
//                                     child: const Center(child: Text("+"))),
//                               ),
//                               SizedBox(
//                                 height: 3.h,
//                                 width: 7.w,
//                                 child: Center(child: Text("$countNum")),
//                               ),
//                               InkWell(
//                                 onTap: removeFun,
//                                 child: Container(
//                                     height: 3.h,
//                                     width: 7.w,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             right: BorderSide(
//                                                 color: LightMode.splash))),
//                                     child: const Center(child: Text("-"))),
//                               ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 3.w,
//           ),
//           Image.asset(
//             img,
//             width: 10.w,
//             height: 10.w,
//             fit: BoxFit.fill,
//           )
//         ],
//       ),
//     );
//   }

//   Widget onBtnClick(text, onPress) {
//     return SizedBox(
//       width: 90.w,
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
