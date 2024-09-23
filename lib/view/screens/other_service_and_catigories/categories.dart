import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/home/home_controller.dart';
import 'package:mas_app/controller/other_services/categories_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/widget/no_data.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    CategoriesController categoriesController = Get.put(CategoriesController());
    return Scaffold(
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBarCategories(context),
            bodyTitleCatigories(),
            categoriesController.categories.isEmpty
                ? noData("لا يوجد منتجات بعد")
                : Container(
                    margin: EdgeInsets.only(right: 4.w, left: (4.w)),
                    height: 80.h,
                    child: AnimationLimiter(
                      child: GridView.builder(
                        padding: EdgeInsets.only(top: 2.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent:
                                MediaQuery.of(context).size.shortestSide < 600
                                    ? MediaQuery.sizeOf(context).width / 3
                                    : MediaQuery.sizeOf(context).width / 3.5,
                            crossAxisSpacing: 5.w,
                            crossAxisCount: 3,
                            mainAxisSpacing:
                                MediaQuery.of(context).size.shortestSide < 600
                                    ? 5.w
                                    : 0.w),
                        itemCount: categoriesController.categoriesList.length,
                        itemBuilder: (context, index) =>
                            AnimationConfiguration.staggeredGrid(
                          columnCount: 1,
                          position: index,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 1500),
                            child: FadeInAnimation(
                                child: cardCatigories(() {
                              controller.goToHomeWithIndex(5, {
                                "categoryId": categoriesController
                                    .categoriesList[index].id
                              });
                            },
                                    categoriesController
                                                .categoriesList[index].image ==
                                            ""
                                        ? Image.asset(
                                            ImagesLink.noImage,
                                            width: 15.w,
                                            height: 15.w,
                                            fit: BoxFit.fill,
                                          )
                                        : CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            imageUrl: categoriesController
                                                .categoriesList[index].image!,
                                            width: 15.w,
                                            height: 15.w,
                                            fit: BoxFit.fill,
                                          ),
                                    categoriesController
                                        .categoriesList[index].name)),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget cardCatigories(onPress, img, text) {
    return InkWell(
      onTap: onPress,
      child: Container(
          padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
          width: 25.w,
          height: 20.h,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(3.w),
              ),
              border: Border.all(color: LightMode.splash, width: 2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              img,
              SizedBox(
                height: 2.w,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500,
                    color: sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor),
              )
            ],
          )),
    );
  }

  Widget appBarCategories(context) {
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
                    HomeController controller = Get.put(HomeController());
                    controller.goToHomeWithIndex(0, {});
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
              margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h, right: 17.w),
              child: Text(
                "التصنيفات",
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

  Widget bodyTitleCatigories() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 1.h, bottom: 2.h, right: 4.w, left: 4.w),
        child: Text(
          "استكشف مجموعتنا المتنوعة من الفئات للعثور على الخدمات والمنتجات التي تناسب احتياجاتك الفردية.",
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
}
