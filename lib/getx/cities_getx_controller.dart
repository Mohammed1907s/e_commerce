import 'package:e_commerce/api/controllers/cities_api_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/city.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CitiesGetxController extends GetxController {
  final CitiesApiController citiesApiController = CitiesApiController();
  RxList<City> cities = <City>[].obs;
  RxBool loading = false.obs;

  static CitiesGetxController get to => Get.find();

  void onInit() {
    getCities();
    super.onInit();
  }

  Future<void> getCities() async {
    loading.value = true;
    cities.value = await citiesApiController.getCities();
    loading.value = false;
    update();
  }

  String getCityNameById({required int id}){
    int index = cities.indexWhere((element) => element.id == id);
    String cityName = SharedPreferencesController().languageCode == 'ar' ? cities[index].nameAr:cities[index].nameEn;
    return cityName;
  }

}
