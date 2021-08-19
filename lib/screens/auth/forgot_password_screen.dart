import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/screens/auth/reset_password_screen.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _mobileTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mobileTextController.dispose();

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
            //mainAxisAlignment: MainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: SizeConfig.scaleHeight(57),
              ),
              AppText(
                'Forgot Password',
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.scaleTextFont(30),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(18),
              ),
              AppText(
                'Enter your mobile number',
                fontSize: SizeConfig.scaleTextFont(14),
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w300,
                color: Color(0xff9E9E9E),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(50),
              ),
              AppTextField(
                controller: _mobileTextController,
                hintText: 'Mobile',
                suffixIcon: Icons.phone_android_outlined,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(73),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(
                    start: SizeConfig.scaleWidth(227)),
                child: ElevatedButton(
                  onPressed: () async {
                    await performForgetPassword();
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    size: SizeConfig.scaleHeight(33),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xffFFD54F),
                      minimumSize: Size(
                        double.maxFinite,
                        SizeConfig.scaleHeight(64),
                      ),
                      shape: CircleBorder(
                        side: BorderSide.none,
                      )),
                ),
              ),
            ]),
      ),
    );
  }
  Future performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_mobileTextController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter required data!', error: true);
    return false;
  }

  Future forgetPassword() async {
    bool status = await UsersGetxController.to.forgetPassword(context, mobile: _mobileTextController.text);
    if (status) {
      navigateToResetPassword();
    } else {
      Helper.showSnackBar(
          context,
          text: 'Login failed, check your credentials!',
          error: true);
    }

  }

  void navigateToResetPassword() {
    Get.to(ResetPasswordScreen(phone: _mobileTextController.text,));
  }
}
