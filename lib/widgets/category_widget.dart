import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  final void Function() onTap;

  final double bottombadding;

  CategoryWidget({
    this.bottombadding = 0,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color(0XFFEEEEEE)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: SizeConfig.scaleWidth(2),color: AppColors.app_scaffold),
                  borderRadius: BorderRadius.circular(40),
                 ),


              child: CircleAvatar(

                radius: SizeConfig.scaleHeight(40),
                backgroundImage: NetworkImage(category.imageUrl),
              ),
            ),
            SizedBox(width: SizeConfig.scaleWidth(16),),
            AppText(
              SharedPreferencesController().languageCode == 'ar'
                  ? category.nameAr
                  : category.nameEn,
              color: Colors.black,
              //textAlign: TextAlign.center,
              fontSize: SizeConfig.scaleTextFont(16),
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
//*CircleAvatar(
//
//             backgroundImage: NetworkImage(category.imageUrl),
//           ),*/
/* Padding(
        padding:  EdgeInsets.only(top: SizeConfig.scaleHeight(20)),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: SizeConfig.scaleWidth(143) ,
              height: SizeConfig.scaleHeight(100),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 5),
                  color: Color(0xff7B7B7B).withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                )
              ]),

              child: Image.network(
                category.imageUrl,
                //width: SizeConfig.scaleWidth(143),
                //height: SizeConfig.scaleHeight(100),
                fit: BoxFit.contain,
                //width: double.infinity,
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(16),),
            AppText(
              SharedPreferencesController().languageCode == 'ar' ? category.nameAr: category.nameEn,
              color: Colors.black,
              textAlign: TextAlign.center,
              fontSize: SizeConfig.scaleTextFont(16),
              fontWeight: FontWeight.w600,

            )
          ],
        ),
      ),*/
