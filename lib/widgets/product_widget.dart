import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/product_details.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final ProductDetails product;
  final void Function() onTap;

  ProductWidget({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(5)),
        child: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          width: SizeConfig.scaleWidth(160),
          height: SizeConfig.scaleHeight(160),
          decoration: BoxDecoration(
            color: Color(0xffFFF8CF).withOpacity(0.25),
            borderRadius: BorderRadius.circular(7),


          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.scaleHeight(8)),
            child: Column(
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
                SizedBox(
                  height: SizeConfig.scaleHeight(15),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.scaleHeight(5),),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(right: 13.0),
                              child: Text( SharedPreferencesController().languageCode == 'ar' ? product.nameAr: product.nameEn,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: SizeConfig.scaleTextFont(16),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          product.offerPrice == null
                              ? AppText(
                                  '${product.price}\₪',
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )
                              : Text('${product.price}\₪',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                  )),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      product.offerPrice != null
                          ? AppText(
                              'Offer: ${product.offerPrice}\₪',
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'sf',
                            )
                          : Container(),
                      SizedBox(
                        height: 12,
                      ),
                      AppText(
                        '${product.quantity} product available',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          AppText(
                            '(${product.overalRate})',
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      !product.isFavorite?Icon(Icons.favorite_border_outlined):Icon(Icons.favorite),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*SizedBox(
                  height: SizeConfig.scaleHeight(50),
                  child: Center(
                    child: AppText(
                      SharedPreferencesController().languageCode == 'ar' ? product.nameAr: product.nameEn,
                      fontSize: SizeConfig.scaleTextFont(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    AppText(product.price.toString(),
                        fontSize: SizeConfig.scaleTextFont(16),
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        print('1');
                      },
                      icon: Icon(Icons.favorite_border_outlined),
                      color: Colors.black,
                    ),
                  ],
                ),*/
