import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/home/favourite_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/items/item_info.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    FavouriteController controller = Get.put(FavouriteController());
    return Container(
      color: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      child: Column(
        children: [
          appBarFavourite(),
          controller.favItem.isEmpty
              ? noData()
              : SizedBox(
                  height: 76.h,
                  child: ListView.builder(
                    itemBuilder: (context, index) => cardItem(() {
                      Get.to(() => const ItemInfo());
                    },
                        6000,
                        2000,
                        "الماسه استور لطباعة الورق وعمل الأختام منتجات درجة أولي والأعلي بالكويت - أسود - خشب - 5*5 ",
                        "ختم",
                        ImagesLink.googleImage),
                    itemCount: 8,
                    padding: EdgeInsets.only(top: 4.w),
                    shrinkWrap: true,
                  ),
                ),
        ],
      ),
    );
  }

  Widget noData() {
    return Container(
      margin: EdgeInsets.only(right: 7.w, left: 7.w),
      height: 70.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImagesLink.noDtaImage,
            width: 50.w,
            height: 25.h,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 3.w,
          ),
          Text(
            S.of(Get.context!).noFav,
            style: GoogleFonts.tajawal(
              fontSize: 4.w,
              fontWeight: FontWeight.bold,
              color: LightMode.splash,
            ),
          ),
          SizedBox(
            height: 2.w,
          ),
          Text(
            textAlign: TextAlign.center,
            S.of(Get.context!).descripFav,
            style: GoogleFonts.tajawal(
              fontSize: 3.5.w,
              fontWeight: FontWeight.w500,
              color: LightMode.splash,
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarFavourite() {
    return SizedBox(
      width: 100.w,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h),
          child: Text(
            S.of(Get.context!).favItems,
            style: GoogleFonts.tajawal(
              fontSize: 5.w,
              fontWeight: FontWeight.bold,
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.typeUserTitle
                  : DarkMode.whiteDarkColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget cardItem(onTapBuy, priceWithoutDiscount, priceWithDiscount,
      discription, nameOfItem, img) {
    return Container(
      height: 17.h,
      width: 100.w,
      margin: EdgeInsets.only(right: 4.w, left: 4.w, bottom: 4.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
          border: Border.all(color: LightMode.splash, width: 1.5)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(4.w),
            width: 65.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nameOfItem,
                      style: GoogleFonts.tajawal(
                          color: LightMode.registerButtonBorder,
                          fontSize: 4.w,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half,
                          size: 4.w,
                          color: LightMode.starColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 4.w,
                          color: LightMode.starColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 4.w,
                          color: LightMode.starColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 4.w,
                          color: LightMode.starColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 4.w,
                          color: LightMode.starColor,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.w,
                ),
                Text(
                  discription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(
                      color: LightMode.registerButtonBorder,
                      fontSize: 2.5.w,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 2.w,
                ),
                SizedBox(
                  width: 65.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "$priceWithoutDiscount دينار",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: LightMode.registerButtonBorder,
                                color: LightMode.registerButtonBorder,
                                fontSize: 2.5.w,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 1.w,
                          ),
                          Text(
                            "$priceWithDiscount دينار",
                            style: GoogleFonts.tajawal(
                                color: LightMode.registerButtonBorder,
                                fontSize: 2.5.w,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: onTapBuy,
                        child: Container(
                          width: 20.w,
                          height: 4.h,
                          padding: EdgeInsets.only(
                              top: 1.w, bottom: 1.w, left: 3.w, right: 3.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.w),
                              border: Border.all(color: LightMode.splash)),
                          child: Center(
                            child: Text(
                              "شراء الأن",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.tajawal(
                                fontSize: 3.w,
                                fontWeight: FontWeight.w700,
                                color: LightMode.splash,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Image.asset(
            img,
            width: 10.w,
            height: 10.w,
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}
