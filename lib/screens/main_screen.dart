import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/firebase/fb_notifications.dart';
import 'package:e_commerce/getx/home_getx_controller.dart';
import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/models/bn_screen.dart';
import 'package:e_commerce/screens/bn_screens/cart_screen.dart';
import 'package:e_commerce/screens/bn_screens/favorite_screen.dart';
import 'package:e_commerce/screens/bn_screens/home_screen.dart';
import 'package:e_commerce/screens/bn_screens/profile_screen.dart';
import 'package:e_commerce/screens/bn_screens/show_all_order_screen.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {

  HomeGetxController homeGetxController = Get.put(HomeGetxController());
  UsersGetxController usersController = Get.put(UsersGetxController());



  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with FbNotifications {
  int _currentIndex = 0;
 // String _title = 'Home';

  List<BottomNavigationScreen> _screens = <BottomNavigationScreen>[
    BottomNavigationScreen(title: ('ulmo'), widget: HomeScreen()),
    BottomNavigationScreen(title: ('Cart'), widget: CartScreen()),
    BottomNavigationScreen(title: ('FAVORITE'), widget: FavoriteScreen()),
    BottomNavigationScreen(title: ('profile'), widget: ProfileScreen()),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,

        title: AppText(
             _screens[_currentIndex].title,
            color: Color(0xff212121),
            fontSize: SizeConfig.scaleTextFont(32),
            fontWeight: FontWeight.w600),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff212121)),


        actions: [
          Visibility(
            visible: _currentIndex == 0,
            child: IconButton(
              onPressed: () => Get.to(AllOrdersScreen()),
              icon: Icon(Icons.bookmark_border,color: AppColors.app_scaffold,),
            ),
          ),],

      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff212121),
        unselectedItemColor: Color(0xffBDBDBD),
        currentIndex: _currentIndex,
        onTap: (int selectedItemIndex) {
          setState(() {
            _currentIndex = selectedItemIndex;
          });
        },


        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,),label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),label: ''
          ),
        ],
      ),
      body: _screens.elementAt(_currentIndex).widget,
    );
  }
}
