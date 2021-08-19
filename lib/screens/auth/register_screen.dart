import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/cities_getx_controller.dart';
import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/city.dart';
import 'package:e_commerce/screens/auth/cities_screen.dart';
import 'package:e_commerce/screens/auth/verify_mobile_number.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:e_commerce/widgets/city_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  CitiesGetxController controller = Get.put(CitiesGetxController());

  late TextEditingController _nameTextController;
  late TextEditingController _mobileTextController;
  late TextEditingController _passwordTextController;
  City? city;
  bool isMale = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileTextController = TextEditingController();
    _nameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _mobileTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.scaleHeight(30),
              ),
              AppText(
                'Register',
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.scaleTextFont(30),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(18),
              ),
              AppText(
                'Create your new account',
                fontSize: SizeConfig.scaleTextFont(14),
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w300,
                color: Color(0xff9E9E9E),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(20),
              ),
              AppTextField(
                controller: _nameTextController,
                hintText: 'Name',
                suffixIcon: Icons.person,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(17),
              ),
              AppTextField(
                controller: _mobileTextController,
                hintText: 'Mobile',
                suffixIcon: Icons.phone_android,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(17),
              ),
              AppTextField(
                controller: _passwordTextController,
                hintText: 'Password',
                suffixIcon: Icons.lock_outlined,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(17),
              ),
              GestureDetector(
                onTap: () async {
                  City selectedCity = await Get.to(CitiesScreen());
                  setState(() {
                    city = selectedCity;
                  });
                },

                child: Container(
                    padding: EdgeInsetsDirectional.only(start: 28, end: 10),
                    alignment: AlignmentDirectional.centerStart,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF999999).withAlpha(25),
                            offset: Offset(0, 5),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey)),
                    child:Row(
                      children: [
                        getCityName(),
                        Spacer(),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.black,
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(17),
              ),
              Row(
                children: [
                  AppText(
                    'Gender',
                    color: Colors.grey.shade500,
                  ),
                  SizedBox(
                    width: SizeConfig.scaleWidth(10),
                  ),

                  Radio(
                    activeColor: Color(0xffFFD54F),
                    value: 1,
                    groupValue: isMale,
                    onChanged: (var selected) {
                      setState(() {
                        isMale = true;
                      });
                    },
                  ),
                  //SizedBox(width: SizeConfig.scaleWidth(5),),
                  AppText('Male'),
                  SizedBox(
                    width: SizeConfig.scaleWidth(10),
                  ),

                  Radio(
                    activeColor: Color(0xffFFD54F),
                    value: 2,
                    groupValue: !isMale,
                    onChanged: (var selected) {
                      setState(() {
                        isMale = false;
                      });
                    },
                  ),
                  //SizedBox(width: SizeConfig.scaleWidth(5),),
                  AppText('Female'),
                ],
              ),
              Container(

                margin: EdgeInsetsDirectional.only(start: SizeConfig.scaleWidth(227)),
                child: ElevatedButton(onPressed: ()async {
                  await performRegister();
                },
                  child: Icon(Icons.arrow_forward,size: SizeConfig.scaleHeight(33),),style: ElevatedButton.styleFrom(
                    primary: Color(0xffFFD54F),

                    minimumSize: Size(
                      double.maxFinite,
                      SizeConfig.scaleHeight(64),
                    ),

                    shape: CircleBorder(side: BorderSide.none,)
                ), ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(18),),
              AppText(
                'Already have an account?',
                fontSize: SizeConfig.scaleTextFont(14),
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                color: Color(0xff001833),
              ),
              // SizedBox(height: SizeConfig.scaleHeight(18),),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, '/login_screen');
              }, child: AppText(
                'Sign in',
                fontSize: SizeConfig.scaleTextFont(16),
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
                color: Color(0xffF44336),
              ),)
            ]),
      ),
    );
  }
  Widget getCityName() {
    if (city == null) {
      return AppText(
         'Select City',
        color: Colors.grey,
      );
    } else {
      if (SharedPreferencesController().languageCode == 'ar') {
        return AppText(
          city!.nameAr,
          color: Colors.black,
          fontSize: 16,
        );
      } else {
        return AppText(
           city!.nameEn,
          color:Colors.black,
          fontSize: 16,
        );
      }
    }
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _mobileTextController.text.isNotEmpty &&
        city != null) {
      return true;
    }
    return false;
  }

  Future<void> register() async {
    int? code = await UsersGetxController.to.register(
        context: context,
        name: _nameTextController.text,
        mobile: _mobileTextController.text,
        password: _passwordTextController.text,
        gender: isMale ? 'M' : 'F',
        city: city!.id);
    if (code != null) {
      Helper.showSnackBar(context, text: code.toString(), error: true);
      Get.off(VerifyMobileScreen(mobile: _mobileTextController.text));
    }
  }
}
