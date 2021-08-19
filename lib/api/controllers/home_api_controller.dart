import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce/api/helper/api_mixin.dart';
import 'package:e_commerce/models/city.dart';
import 'package:e_commerce/models/home_model.dart';
import 'package:flutter/cupertino.dart';

import '../api_settings.dart';
import 'package:http/http.dart' as http;

class HomeApiController with ApiMixin {

  Future<HomeModel?>  getHome() async {
    var response = await http.get(getUrl(ApiSettings.HOME),headers:header);
    log('get home api=> ${response.body}');
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body);
      HomeModel model =HomeModel.fromJson(data);
      log('return');
      return model;
    }else{
      return null;
    }
  }
}