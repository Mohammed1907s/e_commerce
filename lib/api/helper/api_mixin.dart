import 'dart:convert';
import 'dart:io';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

mixin ApiMixin {
  Uri getUrl(String url) {
    return Uri.parse(url);
  }

  bool isSuccessRequest(int statusCode) {
    return statusCode < 400;
  }

  void handleServerError(BuildContext context) {
    Helper.showSnackBar(context,
        text: 'Unable to perform your request now!', error: true);
  }

  void showMessage(BuildContext context, Response response,
      {bool error = false}) {
    Helper.showSnackBar(context,
        text: jsonDecode(response.body)['message'], error: error);
  }

  Map<String, String> get requestHeaders {
    return {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'lang': SharedPreferencesController().languageCode
    };
  }

  Map<String, String> get baseHeader {
    return {
      'X-Requested-With': 'XMLHttpRequest',
      'lang': SharedPreferencesController().languageCode
    };
  }

  Map<String, String> get header {
    return {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    };
  }
  Map<String, String> get headerNotification {
    return {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,

      'Accept': 'application/json'
    };
  }

}
