import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/screens/auth/register_screen.dart';
import 'package:e_commerce/screens/main_screen.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _mobileTextController;
  late TextEditingController _passwordTextController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mobileTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();

  }
  navigateToCreateAccountScreen() {
    Get.to(RegisterScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(42)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: SizeConfig.scaleHeight(57),
            ),
            AppText(
              'Sign in'.tr,
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.scaleTextFont(30),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(18),
            ),
            AppText(
              'Please sign in to continue app'.tr,
              fontSize: SizeConfig.scaleTextFont(14),
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w300,
              color: Color(0xff9E9E9E),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(50),
            ),
            TextField(



             // textAlign: textAlign,
             keyboardType: TextInputType.phone,
             controller: _mobileTextController,
             maxLength: 9,
             // maxLines: maxLines,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: SizeConfig.scaleTextFont(16),
              ),
              //onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding:
                     EdgeInsetsDirectional.only(
                        start: SizeConfig.scaleWidth(15),
                        end: SizeConfig.scaleWidth(15),
                        top: SizeConfig.scaleHeight(22),
                        bottom: SizeConfig.scaleHeight(22),
                      ),

                hintText: 'Mobile'.tr,
                //counterText: '',
                hintStyle: TextStyle(
                  color: Color(0xff9D9EA3),
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.scaleTextFont(15),
                ),
                suffixIcon:  Icon(Icons.phone_android_outlined,color: Colors.grey,) ,
                //prefix: AppText('+970',color: Colors.black,fontSize: SizeConfig.scaleTextFont(15),),
                prefixText: '+970',

                prefixStyle: TextStyle(color: Colors.black,fontFamily: 'Poppins',
                  fontSize: SizeConfig.scaleTextFont(15),),

                fillColor: Color(0xFFF5F5F5),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: SizeConfig.scaleWidth(1),
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: SizeConfig.scaleWidth(1),
                    color: AppColors.app_primary,
                  ),
                ),
                //focusedBorder: InputDecoration(borderSide: BorderSide()),
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(17),
            ),
            TextField(
              obscureText: true,


             // textAlign: textAlign,
             keyboardType: TextInputType.visiblePassword,
              controller: _passwordTextController,
             // maxLength: maxLength,
             // maxLines: maxLines,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: SizeConfig.scaleTextFont(16),
              ),
              //onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding:
                     EdgeInsetsDirectional.only(
                        start: SizeConfig.scaleWidth(15),
                        end: SizeConfig.scaleWidth(15),
                        top: SizeConfig.scaleHeight(14),
                        bottom: SizeConfig.scaleHeight(14),
                      ),

                hintText: 'Password'.tr,
                counterText: '',
                hintStyle: TextStyle(
                  color: Color(0xff9D9EA3),
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.scaleTextFont(15),
                ),
                suffixIcon:  Icon(Icons.lock_outlined,color: Colors.grey,) ,

                fillColor: Color(0xFFF5F5F5),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: SizeConfig.scaleWidth(1),
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: SizeConfig.scaleWidth(1),
                    color: AppColors.app_primary,
                  ),
                ),
                //focusedBorder: InputDecoration(borderSide: BorderSide()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/forgot_screen');
                }, child: AppText(
                  'Forgot Password?'.tr,
                  fontSize: SizeConfig.scaleTextFont(16),
                  textAlign: TextAlign.end,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffF44336),
                ),),
              ],
            ),
            SizedBox(height: SizeConfig.scaleHeight(63),),
            Container(
              
              margin: EdgeInsetsDirectional.only(start: SizeConfig.scaleWidth(227)),
              child: ElevatedButton(onPressed: ()async {
                await performLogin();},
                child: Icon(Icons.arrow_forward,size: SizeConfig.scaleHeight(33),),style: ElevatedButton.styleFrom(
                primary: Color(0xffFFD54F),

                  minimumSize: Size(
                double.maxFinite,
                SizeConfig.scaleHeight(64),
              ),

                shape: CircleBorder(side: BorderSide.none,)
              ), ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(46),),
            AppText(
              'Don’t have an account?'.tr,
              fontSize: SizeConfig.scaleTextFont(14),
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              color: Color(0xff001833),
            ),
           // SizedBox(height: SizeConfig.scaleHeight(18),),
            TextButton(onPressed: (){
              Navigator.pushNamed(context, '/register_screen');
            }, child: AppText(
              'Register'.tr,
              fontSize: SizeConfig.scaleTextFont(16),
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w500,
              color: Color(0xffF44336),
            ),)




          ],
        ),
      ),
    );
  }
  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_mobileTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields'.tr, error: true);
    return false;
  }

  Future<void> login() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCMToken => ${fcmToken}');
    bool status = await UsersGetxController.to.login(
      context: context,
      mobile: _mobileTextController.text,
      password: _passwordTextController.text,
      newFcmToken: fcmToken.toString(),


    );
    if (status) {
      Get.offAll(MainScreen());
    } else {
      Helper.showSnackBar(context, text: 'Login failed, check your credentials!'.tr, error: true);
    }
  }
}
