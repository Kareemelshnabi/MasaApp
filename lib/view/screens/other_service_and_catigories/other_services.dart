import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/other_services/other_services_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/view/screens/chat/chat.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:mas_app/view/screens/other_service_and_catigories/categories.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class OtherServices extends StatelessWidget {
  const OtherServices({super.key});

  @override
  Widget build(BuildContext context) {
    OtherServicesController controller = Get.put(OtherServicesController());
    return Scaffold(
      backgroundColor: LightMode.registerText,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBarOtherServices(),
            SizedBox(
                child: FutureBuilder(
              future: controller.getServices(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 88.h,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 4.w),
                      itemBuilder: (context, index) => cardItemHome(() {
                        if (controller.services[index].categories!.isEmpty) {
                          Get.to(() => const ChatPage());
                        } else {
                          Get.to(() => const CategoriesPage(), arguments: {
                            "categories": controller.services[index].categories
                          });
                        }
                      },
                          controller.services[index].name,
                          controller.services[index].description,
                          controller.services[index].image == ""
                              ? AssetImage(
                                  ImagesLink.noImage,
                                  // color: LightMode.registerText,
                                )
                              : CachedNetworkImageProvider(
                                  controller.services[index].image!,
                                )),
                      itemCount: controller.services.length,
                      shrinkWrap: true,
                    ),
                  );
                } else {
                  return SizedBox(
                      height: 88.h,
                      width: 100.w,
                      child: const Center(child: CircularProgressIndicator()));
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget appBarOtherServices() {
    return SizedBox(
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 7.w),
              child: IconButton(
                  onPressed: () {
                    Get.off(() => const Home());
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h, right: 16.w),
              child: Text(
                "خدمات اخرى",
                style: GoogleFonts.tajawal(
                  fontSize: 5.w,
                  fontWeight: FontWeight.bold,
                  color: LightMode.registerButtonBorder,
                ),
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }

  Widget cardItemHome(onPress, title, body, img) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 100.w,
        height: 10.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: LightMode.splash),
        ),
        margin: EdgeInsets.only(left: 5.w, right: 10.w, bottom: 5.w),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -7.w,
              top: 2.w,
              bottom: 2.w,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: LightMode.splash),
                    image: DecorationImage(image: img, fit: BoxFit.fill),
                    color: LightMode.splash,
                    shape: BoxShape.circle),
                width: 15.w,
                height: 15.w,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.w, left: 2.w, top: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.tajawal(
                        color: LightMode.splash,
                        fontSize: 4.w,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    body,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: GoogleFonts.tajawal(
                        color: LightMode.registerButtonBorder,
                        fontSize: 3.w,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
