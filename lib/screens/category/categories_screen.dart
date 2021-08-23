import 'package:e_commerce/getx/categories_getx_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/screens/category/sub_category_screen.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppText(
          'categories'.tr,
          fontSize: SizeConfig.scaleTextFont(24),
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.scaleWidth(16),
            vertical: SizeConfig.scaleHeight(10)),
        child: Container(
          child: GetX<CategoryGetxController>(
            builder: (CategoryGetxController controller) {
              return controller.categories.isEmpty
                  ? Center(
                      child: SpinKitFadingCube(
                        color: Colors.yellow.shade700,
                        size: 50.0,
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        return CategoryWidget(
                            category: controller.categories[index],
                            onTap: () => Get.to(SubCategoryScreen(
                                id: controller.categories[index].id,
                                name: SharedPreferencesController().languageCode == 'ar'
                                    ? controller.categories[index].nameAr
                                    : controller.categories[index].nameEn)));
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: SizeConfig.scaleHeight(10),
                          color: Colors.white,
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
