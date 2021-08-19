import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/cart_getx_controller.dart';
import 'package:e_commerce/getx/order_getx_controller.dart';
import 'package:e_commerce/getx/product_getx_controller.dart';
import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/screens/main_screen.dart';
import 'package:e_commerce/screens/on_boarding_screen.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  UsersGetxController usersController = Get.put(UsersGetxController());
  ProductGetxController controller = Get.put(ProductGetxController());
  CartGetxController cartGetxController = Get.put(CartGetxController());
  OrderGetxController orderGetxController = Get.put(OrderGetxController());


  @override
  void initState() {
    Widget route = SharedPreferencesController().loggedIn
        ? MainScreen()
        : OnBoardingScreen();
    Future.delayed(Duration(seconds: 3), () => Get.off(route));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.app_scaffold,

      body: Center(child: Image.asset('images/ulmo-logos_white.png')
      ),


    );
  }
}
