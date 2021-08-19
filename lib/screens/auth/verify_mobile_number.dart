import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/auth/reset_code_success.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class VerifyMobileScreen extends StatefulWidget {

  final String mobile;

  VerifyMobileScreen({required this.mobile});

  @override
  _VerifyMobileScreenState createState() => _VerifyMobileScreenState();
}

class _VerifyMobileScreenState extends State<VerifyMobileScreen> {

  late TextEditingController _codeTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _codeTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _codeTextController.dispose();

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
                'Verify Mobile Number',
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.scaleTextFont(30),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(18),
              ),
              AppText(
                'Enter the OTP code sent to you',
                fontSize: SizeConfig.scaleTextFont(14),
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w300,
                color: Color(0xff9E9E9E),
              ),
              SizedBox(height: SizeConfig.scaleHeight(66),),
              PinCodeTextField(
                  appContext: context,
                  length: 4,
                  onChanged: (value){print(value);},
              keyboardType: TextInputType.number,
                pastedTextStyle: TextStyle(
                  color: Colors.yellow.shade900,
                  fontWeight: FontWeight.bold,
                ),
                obscureText: true,
                controller: _codeTextController,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.scale,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.circle,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    activeColor : Color(0xffFFD54F),
                    selectedColor : Colors.blue,
                    inactiveColor : Colors.red,
                    disabledColor : Colors.grey,
                  ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
              ),
              SizedBox(height: SizeConfig.scaleHeight(120),),
              Container(

                margin: EdgeInsetsDirectional.only(start: SizeConfig.scaleWidth(227)),
                child: ElevatedButton(onPressed: ()async {
                  bool status = await UsersGetxController.to.activatedAccount(context, code: _codeTextController.text, mobile: widget.mobile);
                  if(status){
                    navigateToLoginScreen();
                  }
                }, child: Icon(Icons.arrow_forward,size: SizeConfig.scaleHeight(33),),style: ElevatedButton.styleFrom(
                    primary: Color(0xffFFD54F),

                    minimumSize: Size(
                      double.maxFinite,
                      SizeConfig.scaleHeight(64),
                    ),

                    shape: CircleBorder(side: BorderSide.none,)
                ), ),
              ),
              
            ]),
      ),
    );
  }
  void navigateToLoginScreen() {
    Get.off(ResetCodeSuccessfulScreen());
  }
}
