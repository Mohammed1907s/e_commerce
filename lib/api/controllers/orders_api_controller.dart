

import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/api/api_settings.dart';
import 'package:e_commerce/api/helper/api_mixin.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/orders.dart';
import 'package:e_commerce/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderApiController with ApiMixin {
  Future<bool> createOrder({
    required BuildContext context,
    required String cart,
    required String paymentType,
    required int addressId,
    required int cardId,
  }) async {
    var response = await http.post(
      getUrl(ApiSettings.ORDER),
      headers: requestHeaders,
      body: {
        'cart': cart,
        'payment_type': paymentType,
        'address_id': addressId.toString(),
        'card_id': cardId.toString(),
      },
    );
    if (isSuccessRequest(response.statusCode)){
      showMessage(context, response, error: false);
      return true;
    }

    else if (response.statusCode != 500)
      showMessage(context, response, error: true);
    else
      handleServerError(context);

    return false;
  }


  Future<List<Order>> getAllOrders() async {
    var response = await http.get(getUrl(ApiSettings.ORDER), headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Order> orders = data.map((e) => Order.fromJson(e)).toList();
      return orders;
    }
    return [];
  }

}