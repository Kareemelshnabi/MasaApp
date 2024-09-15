import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List itemCart = [];
  int itemCount = 0;
  int? index;
  TextEditingController discountController = TextEditingController();
  add() {
    itemCount++;
    update();
  }

  remove() {
    itemCount--;
    update();
  }

  setIndex(x) {
    index = x;
    update();
  }
}
