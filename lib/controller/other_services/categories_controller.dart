// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:mas_app/data/model/categories_model.dart';
import 'package:mas_app/data/model/service_model.dart';

class CategoriesController extends GetxController {
  List<CategoriesModel> categoriesList = [];
  List<Categories> categories = [];
  @override
  void onInit() {
    categories = Get.arguments["categories"];
    categoriesList =
        categories.map((e) => CategoriesModel.fromJson(e.toJson())).toList();

    print("  list   ::  $categoriesList");
    super.onInit();
  }
}
