import 'dart:convert';
import 'package:e_commerce/api/helper/api_mixin.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/models/sub_category.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;

class CategoryApiController with ApiMixin {

  Future<List<Category>> getCategory() async {
    var response = await http.get(getUrl(ApiSettings.CATEGORY),headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Category> categories = data.map((e) => Category.fromJson(e)).toList();
      return categories;
    }
    return [];
  }

  Future<List<SubCategory>> getSubCategory({required int id}) async {
    var response = await http.get(getUrl(ApiSettings.CATEGORY + '/$id'),headers: header);
    print('*****************************');
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<SubCategory> subCategories = data.map((e) => SubCategory.fromJson(e)).toList();
      print('*****************************');
      //print(subCategories[index].id);
      return subCategories;
    }
    return [];
  }
}