import 'dart:convert';
import 'package:e_commerce/api/helper/api_mixin.dart';
import 'package:e_commerce/models/city.dart';
import 'package:flutter/cupertino.dart';

import '../api_settings.dart';
import 'package:http/http.dart' as http;

class CitiesApiController with ApiMixin {

  Future<List<City>> getCities() async {
    var response = await http.get(getUrl(ApiSettings.CITIES),headers: {'Accept': 'application/json'});
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<City> cities = data.map((e) => City.fromJson(e)).toList();
      return cities;
    }
    return [];
  }
}