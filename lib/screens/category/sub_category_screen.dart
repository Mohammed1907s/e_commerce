import 'package:e_commerce/getx/categories_getx_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/screens/product/product_screen.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/sub_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatefulWidget {
  final int id;
  final String name;

  SubCategoryScreen({required this.id, required this.name});

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  CategoryGetxController controller = Get.put(CategoryGetxController());

  @override
  void initState() {
    controller.getSubCategories(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppText(
          widget.name,
          fontSize: SizeConfig.scaleTextFont(24),
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: GetX<CategoryGetxController>(
          builder: (CategoryGetxController controller) {
            return controller.subCategories.isEmpty
                ? Center(
                    child: SpinKitFadingCube(
                      color: Colors.yellow.shade700,
                      size: 50.0,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: controller.subCategories.length,
                    itemBuilder: (context, index) {
                      return SubCategoryWidget(
                          subCategory: controller.subCategories[index],
                          onTap: () => Get.to(ProductScreen(
                              id: controller.subCategories[index].id,name: SharedPreferencesController().languageCode == 'ar'
                              ? controller.subCategories[index].nameAr
                              : controller.subCategories[index].nameEn,)));
                    },
                  );
          },
        ),
      ),
    );
  }
}
