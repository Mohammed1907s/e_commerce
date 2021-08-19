import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/product_getx_controller.dart';
import 'package:e_commerce/getx/product_getx_controller.dart';
import 'package:e_commerce/getx/product_getx_controller.dart';
import 'package:e_commerce/screens/bn_screens/home_screen.dart';
import 'package:e_commerce/screens/main_screen.dart';
import 'package:e_commerce/screens/product/product_details_screen.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);



  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  ProductGetxController productGetxController = Get.put(ProductGetxController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductGetxController.to.getFavoriteProducts();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  GetX<ProductGetxController>(
    builder: (ProductGetxController controller) {
      return controller.favoriteProducts.isEmpty
      ? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.scaleHeight(200),),
          Center(

            child: Container(
              height: SizeConfig.scaleHeight(150),
              width: SizeConfig.scaleWidth(150),
              child: SvgPicture.asset(
                'images/surprised.svg',),
            ),
          ),
          SizedBox(height: SizeConfig.scaleHeight(16),),
          AppText('nothing saved...',fontSize: SizeConfig.scaleTextFont(26),fontWeight: FontWeight.w500,),
          AppText('... no worries. Start saving as you shop\n by clicking the little heart',fontSize: SizeConfig.scaleTextFont(16),fontWeight: FontWeight.w400,textAlign: TextAlign.center,),
          SizedBox(height: SizeConfig.scaleHeight(125),),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(30)),
            child: AppElevatedButton(title: 'Start shopping', onPressed: () {
              Navigator.pushReplacementNamed(context, '/main_screen');
            }, color: AppColors.app_button_color),
          )
        ],
      ),)
      : controller.favoriteProducts.isNotEmpty
      ? GridView.builder(
    scrollDirection: Axis.vertical,
    itemCount: controller.favoriteProducts.length,
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      childAspectRatio: 146 / 250,
      mainAxisSpacing: 20,
    ),
    itemBuilder: (context, index) {
      return ProductCard(
          product: controller.favoriteProducts[index],
          onTap: () => Get.to(ProductDetailsScreen(
              productDetails: controller.products[index]),));
    },
      )
      : Center(child: Text('no data'));
    });
  }
}
