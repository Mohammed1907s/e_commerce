

import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/api/api_settings.dart';
import 'package:e_commerce/api/helper/api_mixin.dart';
import 'package:e_commerce/models/notification.dart';
import 'package:http/http.dart' as http;

class NotificationApiController with ApiMixin{
  Future<List<NotificationDetails>> getAllNotification() async {
    var response = await http.get(getUrl(ApiSettings.NOTIFICATION), headers: headerNotification);

    log('get notification api=> ${response.statusCode}');
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<NotificationDetails> notifications = data.map((e) => NotificationDetails.fromJson(e)).toList();
      return notifications;
    }
    return [];
  }
}