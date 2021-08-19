import 'package:e_commerce/getx/address_getx_controller.dart';
import 'package:e_commerce/getx/product_getx_controller.dart';
import 'package:e_commerce/screens/product/product_details_screen.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  final int id;
  final String name;


  ProductScreen({required this.id,required this.name});

  ProductGetxController controller = Get.put(ProductGetxController());

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await ProductGetxController.to.getProduct(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: GetX<ProductGetxController>(
        builder: (ProductGetxController controller) {
          return controller.products.isEmpty
              ? Center(
                  child: SpinKitFadingCube(
                    color: Colors.yellow.shade700,
                    size: 50.0,
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 152 / 266,
                      crossAxisSpacing: SizeConfig.scaleWidth(14),
                      mainAxisSpacing: SizeConfig.scaleHeight(16)),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                        product: controller.products[index],
                        onTap: () => Get.to(ProductDetailsScreen(
                            productDetails: controller.products[index]),));
                    // onTap: () => Get.to(ProductScreen(id: controller.products[index].id)));
                  },
                );
        },
      ),
    );
  }
}
