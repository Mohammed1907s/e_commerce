import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/getx/categories_getx_controller.dart';
import 'package:e_commerce/getx/home_getx_controller.dart';
import 'package:e_commerce/getx/address_getx_controller.dart';
import 'package:e_commerce/getx/product_getx_controller.dart';
import 'package:e_commerce/screens/category/categories_screen.dart';
import 'package:e_commerce/screens/category/sub_category_screen.dart';
import 'package:e_commerce/screens/product/product_details_screen.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/category_card.dart';
import 'package:e_commerce/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  CategoryGetxController controller = Get.put(CategoryGetxController());

  HomeGetxController home = Get.put(HomeGetxController());

  // ProductDetailsGetxController Details = Get.put(ProductDetailsGetxController());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Scaffold(
        // /backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
         
          child: GetBuilder<HomeGetxController>(
            builder: (HomeGetxController home) {
              if (home.homeModel == null) {
                return Center(
                  child: SpinKitFadingCube(
                    color: Colors.yellow.shade700,
                    size: 50.0,
                  ),
                );
              }
              return Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  SizedBox(
              height: SizeConfig.scaleHeight(100),
                  ),
                  Container(
                child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 2,
                autoPlay: true,
              ),
              items: images(),
                  )),
                  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.scaleWidth(10),
                ),
                AppText(
                  'categories',
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.scaleTextFont(17),
                ),
                Spacer(),
                TextButton(
                    onPressed: () => Get.to(CategoriesScreen()),
                    child: AppText(
                      'See more',
                      fontSize: SizeConfig.scaleTextFont(15),
                      fontWeight: FontWeight.w300,
                      color: Colors.blue,
                    ))
              ],
                  ),
                  home.homeModel == null
                ? Container()
                :  Container(

                    height: SizeConfig.scaleHeight(130),
                  child: ListView.builder(
                  shrinkWrap: true,
              
              scrollDirection: Axis.horizontal,
              itemCount: home.homeModel!.data.categories.length,
              itemBuilder: (context, index) {
              return CategoryCard(
                    category: home.homeModel!.data.categories[index],
                    onTap: () => Get.to(SubCategoryScreen(
                        id: home.homeModel!.data.categories[index].id,
                        name: myLocale.languageCode == 'ar'
                            ? home
                            .homeModel!.data.categories[index].nameAr
                            : home.homeModel!.data.categories[index]
                            .nameEn)));
              },
              ),
                ),

                  SizedBox(
              height: SizeConfig.scaleHeight(20),
                  ),
                  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.scaleWidth(10),
                ),
                AppText(
                  'Latest Products',
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.scaleTextFont(17),
                ),

              ],
                  ),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics:  NeverScrollableScrollPhysics(),

              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 152 / 266,
                  crossAxisSpacing: SizeConfig.scaleWidth(4),
                  mainAxisSpacing: SizeConfig.scaleHeight(0.2)),
              itemCount: home.homeModel!.data.latestProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  onTap: () {},
                  product: home.homeModel!.data.latestProducts[index],
                );
                // onTap: () => Get.to(ProductScreen(id: controller.products[index].id)));
              },
                  ),
                  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.scaleWidth(10),
                ),
                AppText(
                  'Famous Products',
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.scaleTextFont(17),
                ),

              ],
                  ),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      physics:  NeverScrollableScrollPhysics(),

                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 152 / 266,
                          crossAxisSpacing: SizeConfig.scaleWidth(4),
                          mainAxisSpacing: SizeConfig.scaleHeight(0.2)),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          onTap: ()  {},
                          product: home.homeModel!.data.famousProducts[index],
                        );
                        // onTap: () => Get.to(ProductScreen(id: controller.products[index].id)));
                      },
                    ),
                ]);
            },
          ),
        ));
  }

  List<Widget> images() {
    return widget.home.homeModel!.data.slider
        .map((e) => Container(
              margin: EdgeInsets.all(SizeConfig.scaleHeight(5)),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        e.imageUrl,
                        fit: BoxFit.cover,
                        width: SizeConfig.scaleWidth(1000),
                        height: double.infinity,
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

/* final List<Widget> imageSliders = home.homeModel!.data.slider.map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(SizeConfig.scaleHeight(5)),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: SizeConfig.scaleWidth(1000),
                        height: double.infinity,
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
            ),
          ))
      .toList();*/
}
/*ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,

            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: controller.categories[index], onTap: () {});
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 0,
                color: Colors.grey,
              );
            },
          );*/

/*GetX<ProductGetxController>(
              builder: (ProductGetxController product) {
                return product.products.isEmpty
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Row(
                  children: [
                    Text('ddddddd'),
                   ProductCard(product: product.products[0], onTap: (){})

                  ],
                );
              },
            )*/
