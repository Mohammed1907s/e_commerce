
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/sub_category.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SubCategoryWidget extends StatelessWidget {
  final SubCategory subCategory;
  final void Function() onTap;

  SubCategoryWidget({required this.subCategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16),vertical: SizeConfig.scaleHeight(8)),
        child: Container(
            height: SizeConfig.scaleHeight(100),
            decoration: BoxDecoration(
              color:Color(0xFFF5F5F5) ,
              borderRadius: BorderRadius.circular(18),
            ),

            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  SizedBox(width: SizeConfig.scaleWidth(10),),
                  AppText(
                    SharedPreferencesController().languageCode == 'ar' ? subCategory.nameAr: subCategory.nameEn,
                    fontSize: SizeConfig.scaleTextFont(24),
                    fontWeight: FontWeight.w600,),
                  Spacer(),
                  Image.network(subCategory.imageUrl,fit: BoxFit.cover,width: SizeConfig.scaleWidth(150),),

                ],
              ),
            )
        ),
      ),
    );
  }
}

/*
* Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(20),vertical: SizeConfig.scaleHeight(5)),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: SizeConfig.scaleWidth(235),
          height: SizeConfig.scaleHeight(100),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ClipRRect(
                child: Image.network(
                  subCategory.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              Center(
                child: AppText(
                  SharedPreferencesController().languageCode == 'ar' ? subCategory.nameAr: subCategory.nameEn,
                  color: Colors.black,
                  fontSize: SizeConfig.scaleTextFont(26),
                  fontWeight: FontWeight.bold,

                ),
              )
            ],
          ),
        ),
      ),
    );*/
