import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldPasswordEditingController;
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _newPasswordConfirmationEditingController;

  @override
  void initState() {
    super.initState();
    _oldPasswordEditingController = TextEditingController();
    _newPasswordEditingController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();
    _newPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: AppText(
           'Change Password'.tr,
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(25),vertical: SizeConfig.scaleHeight(25)),
        children: [
          SizedBox(height: 70),
          AppText(
            'Please enter your phone number and we will send you a code to your phone to reset the password'.tr,
            color: Colors.grey,

            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 60),
          AppTextField(

            controller: _oldPasswordEditingController,
            hintText: 'Old Password'.tr,
            isPassword: true,
          ),
          SizedBox(height: 15),
          AppTextField(
            controller: _newPasswordEditingController,
            hintText: 'New Password'.tr,
            isPassword: true,
          ),
          SizedBox(height: 15),
          AppTextField(
            controller: _newPasswordConfirmationEditingController,
            hintText: 'New password Confirmation'.tr,
            isPassword: true,
          ),
          SizedBox(
            height: 43,
          ),
          AppElevatedButton(
            title: 'Continue'.tr,
            color: AppColors.app_button_color,

            onPressed: () async => await performChangePassword(),
          ),
        ],
      ),
    );
  }

  Future performChangePassword() async {
    if (checkData()) {
      await changePassword();
    }
  }

  bool checkData() {
    if (isPasswordSet) {
      if (isPasswordConfirmed) {
        return true;
      }
      Helper.showSnackBar(context,
          text: 'Password is not confirmed correctly!'.tr, error: true);
    } else {
      Helper.showSnackBar(context, text: 'Enter required data!'.tr, error: true);
    }
    return false;
  }

  bool get isPasswordSet {
    return _newPasswordEditingController.text.isNotEmpty &&
        _newPasswordConfirmationEditingController.text.isNotEmpty &&
        _oldPasswordEditingController.text.isNotEmpty;
  }

  bool get isPasswordConfirmed {
    return _newPasswordConfirmationEditingController.text ==
        _newPasswordEditingController.text;
  }

  Future changePassword() async {
    bool status = await UsersGetxController.to.changePassword(context,
        currentPassword: _oldPasswordEditingController.text,
        newPassword: _newPasswordConfirmationEditingController.text);
    if (status) {
      navigateToLoginScreen();
    }
  }

  void navigateToLoginScreen() {
    Get.back();
  }
}