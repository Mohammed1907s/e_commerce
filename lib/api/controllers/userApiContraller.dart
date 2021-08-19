import 'dart:convert';
import 'dart:io';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../api_settings.dart';
import '../helper/api_mixin.dart';

class UserApiController with ApiMixin {
  Future<User?> login(BuildContext context,
      {required String mobile, required String password, String? fcm_token='' }) async {
    var response = await http.post(getUrl(ApiSettings.LOGIN),
        body: {'mobile': mobile, 'password': password,'fcm_token':fcm_token }, headers: baseHeader);
    if (isSuccessRequest(response.statusCode)) {
      return User.fromJson(jsonDecode(response.body)['data']);
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
      return null;
    }
    handleServerError(context);
    return null;
  }

  Future<bool> logout(BuildContext context) async {
    var response = await http.get(
      getUrl(ApiSettings.LOGOUT),
      headers: requestHeaders,
    );
    print(response.statusCode);
    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403) {
      await SharedPreferencesController().logout();
      return true;
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<int?> register({
    required BuildContext context,
    required String name,
    required String mobile,
    required String password,
    required String gender,
    required int city,
  }) async {
    var response = await http.post(getUrl(ApiSettings.REGISTER), body: {
      'name': name,
      'mobile': mobile,
      'password': password,
      'gender': gender,
      'STORE_API_KEY': 'df51e98c-ff13-423b-b014-4905036c5030',
      'city_id': city.toString(),
    });
    if (isSuccessRequest(response.statusCode)) {
      showMessage(context, response);
      // return true;
      return jsonDecode(response.body)['code'];
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
      return null;
    }
    handleServerError(context);
    return null;
  }

  Future<bool> forgetPassword(BuildContext context,
      {required String mobile}) async {
    var response = await http.post(getUrl(ApiSettings.FORGET_PASSWORD),
        body: {'mobile': mobile}, headers: baseHeader);
    if (isSuccessRequest(response.statusCode)) {
      Helper.showSnackBar(context,
          text: 'CODE: ${jsonDecode(response.body)['code']}');
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<bool> resetPassword(BuildContext context,
      {required String mobile,
      required String code,
      required String password}) async {
    var response = await http.post(getUrl(ApiSettings.RESET_PASSWORD),
        body: {
          'mobile': mobile,
          'code': code,
          'password': password,
          'password_confirmation': password,
        },
        headers: baseHeader);
    if (isSuccessRequest(response.statusCode)) {
      showMessage(context, response);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<bool> activateAccount(BuildContext context, {required String mobile, required String code}) async {
    var response = await http.post(
        getUrl(ApiSettings.ACTIVATE_ACCOUNT),
        body: {
          'mobile': mobile,
          'code': code,
        },
        headers: baseHeader
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(context, response);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }else{
      handleServerError(context);
    }
    return false;
  }

  Future<bool> changePassword(BuildContext context,
      {required String currentPassword, required String newPassword}) async {
    var response = await http.post(getUrl(ApiSettings.CHANGE_PASSWORD),
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPassword,
        },
        headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      showMessage(context, response);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }
  Future<bool> contactUS(BuildContext context, {required String subject, required String msg}) async {
    var response = await http.post(
        getUrl(ApiSettings.CONTACT_US),
        body: {
          'subject': subject,
          'message': msg,
        },
        headers: requestHeaders
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(context, response);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }else{
      handleServerError(context);
    }
    return false;
  }
  Future<String> refreshFcmToken( {required String newFcmToken}) async {
    var response = await http.post(
        getUrl(ApiSettings.REFRESHFCMTOKEN),
        body: {
          'fcm_token': newFcmToken,
        },
        headers: header
    );
    if (isSuccessRequest(response.statusCode)) {
      return newFcmToken;
    }


    return 'false';
  }
  Future<bool> updateProfile(
      {required BuildContext context,
        required String name,
        required String gender,
        required int city,
      }) async {
    var response = await http.post(getUrl(ApiSettings.UPDATE_PROFILE), body: {
      'name': name,
      'gender': gender,
      'city_id': city.toString(),
    },headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      showMessage(context, response);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
      return false;
    }else{
      handleServerError(context);
      return false;
    }
  }

}
