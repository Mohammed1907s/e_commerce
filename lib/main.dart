import 'package:e_commerce/firebase/fb_notifications.dart';
import 'package:e_commerce/local_storge/db/db_provider.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/locale/app_locale.dart';
import 'package:e_commerce/screens/auth/forgot_password_screen.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/auth/register_screen.dart';
import 'package:e_commerce/screens/auth/reset_code_success.dart';
import 'package:e_commerce/screens/auth/verify_mobile_number.dart';
import 'package:e_commerce/screens/bn_screens/home_screen.dart';
import 'package:e_commerce/screens/launch_screen.dart';
import 'package:e_commerce/screens/main_screen.dart';
import 'package:e_commerce/screens/on_boarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider().initDatabase();
  await SharedPreferencesController().initSharedPreference();
  await Firebase.initializeApp();
  await FbNotifications.initNotifications();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      translations: AppLocale(), // your translations
      locale: Locale(SharedPreferencesController().languageCode),
      routes:{
        '/launch_screen': (context) => LaunchScreen(),
        '/onboarding_screen': (context) => OnBoardingScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/register_screen': (context) => RegisterScreen(),
        '/forgot_screen': (context) => ForgotPasswordScreen(),
        '/rest_success_screen': (context) => ResetCodeSuccessfulScreen(),
        '/main_screen': (context) => MainScreen(),
      } ,
    );
  }
}
