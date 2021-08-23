import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/address_getx_controller.dart';
import 'package:e_commerce/getx/cart_getx_controller.dart';
import 'package:e_commerce/getx/product_getx_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/models/product_details.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetails productDetails;

  ProductDetailsScreen({required this.productDetails});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int cardIncrement = 1;
  CartGetxController cartGetxController = Get.put(CartGetxController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductGetxController.to
          .getProductDetails(id: widget.productDetails.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),

        ),
        body: GetX<ProductGetxController>(
            builder: (ProductGetxController controller) {
          return controller.products.isEmpty
              ? Center(
            child: SpinKitFadingCube(
              color: Colors.yellow.shade700,
              size: 50.0,
            ),
          )
              : Stack(
                  children: [
                    SizedBox(
                      height: SizeConfig.scaleHeight(400),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 445,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          // enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: images(),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        height: 413,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                SharedPreferencesController().languageCode == 'ar' ? ProductGetxController
                                    .to.productDetails.value!.nameAr: ProductGetxController
                                    .to.productDetails.value!.nameEn,
                                color: Colors.black,
                                fontSize: SizeConfig.scaleTextFont(20),
                                fontWeight: FontWeight.w400,
                              ),

                              Row(
                                children: [

                                  ProductGetxController.to.productDetails.value!
                                              .offerPrice != null
                                      ? Row(
                                        children: [

                                          Text(
                                            '  Price : ${ProductGetxController.to.productDetails.value!.price} ₪',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: Colors.red,
                                            ),),
                                          AppText(
                                            'Offer : ${ProductGetxController.to.productDetails.value!.offerPrice}₪  ',
                                            color: Colors.black,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      )
                                      : AppText(
                                          'Price : ${ProductGetxController.to.productDetails.value!.price} ₪'.tr,
                                          color: Colors.black,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.start,
                                        ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      await ProductGetxController.to
                                          .addFavoriteProducts(
                                              context: context,
                                              product: ProductGetxController
                                                  .to.productDetails.value!);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ProductGetxController
                                                  .to
                                                  .productDetails
                                                  .value!
                                                  .isFavorite
                                              ? Colors.red
                                              : Colors.grey),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              AppText(
                                SharedPreferencesController().languageCode == 'ar' ? ProductGetxController
                                    .to.productDetails.value!.infoAr: ProductGetxController
                                    .to.productDetails.value!.infoEn,
                                color: Colors.grey,
                                fontSize: 16,
                                textAlign: TextAlign.start,
                              ),
                               RatingBar.builder(
                                 initialRating: double.parse(
                                     ProductGetxController
                                         .to.productDetails.value!.productRate
                                         .toString()),
                                 minRating: 1,
                                 direction: Axis.horizontal,
                                 allowHalfRating: true,
                                 itemCount: 5,
                                 itemPadding:
                                     EdgeInsets.symmetric(horizontal: 4.0),
                                 itemSize: 30,
                                 itemBuilder: (context, _) => Icon(
                                   Icons.star,
                                   color: Colors.amber,
                                 ),
                                 onRatingUpdate: (rating) {
                                   ProductGetxController.to.rattingProduct(
                                       product: widget.productDetails,
                                       context: context,
                                       rate: rating);
                                 },
                               ),
                              Spacer(),
                              AppElevatedButton(
                                onPressed: () async {
                                  bool status = await CartGetxController.to
                                      .createCartItem(cartItem);
                                  if (status) {
                                    Helper.showSnackBar(context,
                                        text: 'add success');
                                  } else {
                                    Helper.showSnackBar(context,
                                        text: 'add failed');
                                  }
                                  Get.back();
                                },
                                title: 'Add to cart'.tr,
                                color: AppColors.app_button_color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }));
  }

  List<Widget> images() {
    return ProductGetxController.to.productDetails.value!.images
        .map((ProductImages image) => Container(
              margin: EdgeInsets.all(SizeConfig.scaleHeight(5)),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        image.imageUrl,
                        fit: BoxFit.contain,
                        //width: SizeConfig.scaleWidth(1000),
                        height: SizeConfig.scaleHeight(300),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.scaleHeight(10),
                              horizontal: SizeConfig.scaleWidth(20)),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();
  }



  CartItem get cartItem {
    CartItem cartItem = CartItem();
    cartItem.imageUrl = widget.productDetails.imageUrl;
    cartItem.productId = widget.productDetails.id;
    cartItem.price = widget.productDetails.price;
    cartItem.nameEn = widget.productDetails.nameEn;
    cartItem.nameAr = widget.productDetails.nameAr;
    cartItem.quantity = cardIncrement;
    return cartItem;
  }
}

/*GetBuilder<ProductGetxController>(
          builder: (ProductGetxController controller) {
        return controller.products.isEmpty
            ? Center(
                child: SpinKitFadingCube(
                  color: Colors.yellow.shade700,
                  size: 50.0,
                ),
              )
            : Padding(
                padding: EdgeInsets.only(bottom: SizeConfig.scaleHeight(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.scaleHeight(10),
                      ),
                      Container(
                          width: double.infinity,
                          height: SizeConfig.scaleHeight(348),
                          child: Stack(
                            children: [
                              PageView(children: [
                                Image.network(controller.products[0].imageUrl),
                                Image.network(controller.products[1].imageUrl),
                              ]),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.scaleWidth(26)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppText(
                                  '₪${controller.products[0].price}',
                                  color: Color(0xff212121),
                                  fontSize: SizeConfig.scaleTextFont(24),
                                  fontWeight: FontWeight.w600,
                                ),
                                Spacer(),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(11),
                            ),
                            AppText(
                              '${controller.products[0].nameEn}',
                              color: Color(0xff9E9E9E),
                              fontSize: SizeConfig.scaleTextFont(16),
                              fontWeight: FontWeight.w400,
                            ),
                            ExpansionTile(
                              childrenPadding:
                                  EdgeInsets.all(SizeConfig.scaleHeight(10)),
                              expandedAlignment: Alignment.bottomLeft,
                              title: AppText('Info & Detail',
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.scaleTextFont(20)),
                              children: [
                                Text(
                                  '${controller.products[0].infoEn}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeConfig.scaleTextFont(16)),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),*/
