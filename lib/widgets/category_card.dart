 import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final void Function() onTap;


 // final double height;
 // final double width;

  CategoryCard({
   required this.category,
   required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(10),vertical: SizeConfig.scaleHeight(5)),
      child: InkWell(
        onTap: onTap,
        child: Column(

          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: SizeConfig.scaleWidth(2),color: AppColors.app_scaffold),

                  borderRadius: BorderRadius.all(Radius.circular(SizeConfig.scaleHeight(40)))),
              child: CircleAvatar(backgroundImage: NetworkImage(category.imageUrl,),

                radius: SizeConfig.scaleHeight(40),

                //child: Image.network(
                //  image,
                //  fit: BoxFit.contain,
                //  //width: double.infinity,
                //),

              ),
            ),
            AppText(
              SharedPreferencesController().languageCode == 'ar' ? category.nameAr: category.nameEn,
              color: Colors.black,
              fontSize: SizeConfig.scaleTextFont(18),
              fontWeight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}
