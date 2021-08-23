import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/product_details.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class ProductCard extends StatelessWidget {
  final ProductDetails product;
  final void Function() onTap;


  ProductCard({
   required this.product,
   required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(5),vertical: SizeConfig.scaleHeight(10)),
        child: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          width: SizeConfig.scaleWidth(160),
          height: SizeConfig.scaleHeight(260),
          decoration: BoxDecoration(
            color: Color(0xffFFF8CF).withOpacity(0.5),
            borderRadius: BorderRadius.circular(7),


          ),
          child: Padding(
            padding:  EdgeInsets.all(SizeConfig.scaleHeight(8)),
            child: Column(

              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.scaleWidth(152),
                  height: SizeConfig.scaleHeight(180),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.network(
                      product.imageUrl,

                      fit: BoxFit.contain,
                      // height: double.infinity,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.scaleHeight(8),),


                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    product.offerPrice == null
                        ? AppText(
                      '${product.price}\₪',
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                        : Text(
                       '${product.price}\₪',
                      style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                    ),),
                    SizedBox(width: SizeConfig.scaleWidth(60),),




                    !product.isFavorite?Icon(Icons.favorite_border_outlined):Icon(Icons.favorite),
                  ],
                ),
                SizedBox(height: SizeConfig.scaleHeight(5),),
                AppText(
                    SharedPreferencesController().languageCode == 'ar' ? product.nameAr: product.nameEn,

                    fontSize: SizeConfig.scaleTextFont(12),
                    fontWeight: FontWeight.w400,
                    color: Color(0xff9E9E9E),


                ),
            product.offerPrice != null
                ? AppText(
               'Offer: ${product.offerPrice}\₪',
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            )
                : Container(),
            SizedBox(
              height: 10,
            ),
            AppText(
              '${product.quantity} product available',
              fontSize: 12,
              color: Colors.grey,
            ),
                Row(
                  children: [
                    Icon(Icons.star,color: Colors.amber,size: 15,),
                    SizedBox(width: 5,),
                    AppText(
                      '(${product.overalRate})',
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
