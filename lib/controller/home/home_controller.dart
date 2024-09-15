import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mas_app/view/screens/home/favourite.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:mas_app/view/screens/items/items.dart';
import 'package:mas_app/view/screens/card/my_card.dart';
import 'package:mas_app/view/screens/profile/profile.dart';

import '../../view/screens/home/home_page.dart';
class HomeController extends GetxController{

  int currentIndex = 0;
  List pages = [
    const HomePage(),
    const FavouritePage(),
     Container(),
   // const CartPage(),
    const MyCardPage(),
    const ProfilePage(),
    const ItemsPage()
  ];
  changePage(int pageIndex) {
    currentIndex = pageIndex;
    update();
  }

  goToHomeWithIndex(index,arguments) {
    Get.to(() => const Home(),arguments:arguments);
    currentIndex = index;
    update();
  }
}