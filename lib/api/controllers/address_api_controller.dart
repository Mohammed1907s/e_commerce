
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:e_commerce/api/api_settings.dart';
import 'package:e_commerce/api/helper/api_mixin.dart';
import 'package:e_commerce/models/address.dart';
import 'package:e_commerce/models/address_details.dart';
import 'package:flutter/material.dart';


class AddressApiController with ApiMixin {

  Future<List<AddressDetails>> getAllAddress() async {
    var response = await http.get(getUrl(ApiSettings.ADDRESS), headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<AddressDetails> addresses = data.map((e) => AddressDetails.fromJson(e)).toList();
      return addresses;
    }
    return [];
  }


  Future<AddressDetails?> createAddress({required BuildContext context, required AddressDetails address}) async {
    var response = await http.post(
      getUrl(ApiSettings.ADDRESS),
      headers: requestHeaders,
      body: {
        'name': address.name,
        'info': address.info,
        'contact_number': address.contactNumber,
        'city_id': address.cityId.toString(),
        'lat': address.lat??'',
        'lang': address.lang??'',
      },
    );
    if (isSuccessRequest(response.statusCode)) {
      var jsonObject = jsonDecode(response.body)['object'];
      return AddressDetails.fromJson(jsonObject);
    }
    else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }
    handleServerError(context);
    return null;
  }


  Future<bool> updateAddress({required BuildContext context, required AddressDetails address}) async {
    var response = await http.put(
      getUrl(ApiSettings.ADDRESS + '/${address.id}'),
      headers: requestHeaders,
      body: {
        'name': address.name,
        'info': address.info,
        'contact_number': address.contactNumber,
        'city_id': address.cityId.toString(),
        'lat': address.lat??'',
        'lang': address.lang??'',
      },
    );
    if (isSuccessRequest(response.statusCode)) {
      print('-------------si---------------------');
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response);
      return false;
    }
    handleServerError(context);
    return false;
  }

  Future<bool> deleteAddress({required BuildContext context, required addressId}) async {
    var response = await http.delete(
      getUrl(ApiSettings.ADDRESS + '/$addressId'),
      headers: requestHeaders,
    );

    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response);
      return false;
    }
    handleServerError(context);
    return false;
  }
}