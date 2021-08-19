import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/screens/auth/reset_code_success.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String phone;

  ResetPasswordScreen({required this.phone});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _codeTextController;
  late TextEditingController _newPasswordConfirmationEditingController;
  String _code = '';

  @override
  void initState() {
    super.initState();
    _newPasswordEditingController = TextEditingController();
    _codeTextController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordEditingController.dispose();
    _codeTextController.dispose();
    _newPasswordConfirmationEditingController.dispose();
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
                'Reset Password',
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.scaleTextFont(30),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(18),
              ),
              AppText(
                'Enter 4 digit code verification, the code sent to your phone',
                fontSize: SizeConfig.scaleTextFont(14),
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w300,
                color: Color(0xff9E9E9E),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(50),
              ),
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
              AppTextField(
                controller: _newPasswordEditingController,
                hintText: 'New Password',
                suffixIcon: Icons.lock_outlined,
              ),

              SizedBox(
                height: SizeConfig.scaleHeight(17),
              ),
              AppTextField(
                controller: _newPasswordConfirmationEditingController,
                hintText: 'New Password Confirmation',
                suffixIcon: Icons.lock_outlined,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(73),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(
                    start: SizeConfig.scaleWidth(227)),
                child: ElevatedButton(
                  onPressed: () async => await performResetPassword(),
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
  Future performResetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (isValidCode() && isPasswordSet) {
      if (isPasswordConfirmed) {
        return true;
      }
      Helper.showSnackBar(context,
          text: 'Password is not confirmed correctly!', error: true);
    } else {
      Helper.showSnackBar(context, text: 'Enter required data!', error: true);
    }
    return false;
  }

  bool get isPasswordSet {
    return _newPasswordEditingController.text.isNotEmpty &&
        _newPasswordConfirmationEditingController.text.isNotEmpty;
  }

  bool isValidCode() => _codeTextController.text.isNotEmpty;

  bool get isPasswordConfirmed {
    return _newPasswordConfirmationEditingController.text ==
        _newPasswordEditingController.text;
  }

  String get code {
    return _code = _codeTextController.text;
  }

  Future resetPassword() async {
    bool status = await UsersGetxController.to.resetPassword(
      context: context,
      mobile: widget.phone,
      password: _newPasswordEditingController.text,
      code: code,
    );
    if (status) {
      navigateToLoginScreen();
    }
  }

  void navigateToLoginScreen() {
    Get.to(ResetCodeSuccessfulScreen());
  }
}
