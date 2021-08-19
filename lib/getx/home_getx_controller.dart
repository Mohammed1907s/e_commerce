import 'dart:developer';

import 'package:e_commerce/api/controllers/category_api_controller.dart';
import 'package:e_commerce/api/controllers/home_api_controller.dart';
import 'package:e_commerce/api/controllers/product_api_controller.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/models/home_model.dart';
import 'package:e_commerce/models/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeGetxController extends GetxController {
  final HomeApiController homeApiController = HomeApiController();
  //RxList<Category> categories = <Category>[].obs;
   HomeModel? homeModel;


  static HomeApiController get to => Get.find();

  void onInit() {
    getHome();
    super.onInit();
  }

  Future<void> getHome() async {
    HomeModel? model = await homeApiController.getHome();
      this.homeModel = model;
      log('homeApiController');
      log(model!.message);
      update();

  }



}
