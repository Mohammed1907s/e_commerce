import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  late TextEditingController _subjectEditingController;
  late TextEditingController _msgEditingController;

  @override
  void initState() {
    super.initState();
    _subjectEditingController = TextEditingController();
    _msgEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _subjectEditingController.dispose();
    _msgEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: AppText(
          'Contact US',
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: SizeConfig.scaleHeight(200),
              child: Image.asset('images/ulmo-logos_black.png')),
          SizedBox(height: SizeConfig.scaleHeight(10),),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(25)),

            children: [
              SizedBox(
                height: 70,
              ),
              AppText(
                 'contact us ',
                color: Colors.grey,
                fontSize: SizeConfig.scaleTextFont(18),
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 60),
              AppTextField(
                controller: _subjectEditingController,
                hintText: 'subject',
              ),
              SizedBox(height: 15),
              AppTextField(
                controller: _msgEditingController,
                hintText: 'message',

              ),

              SizedBox(
                height: 43,
              ),
              AppElevatedButton(
                title: 'Send',
                color: AppColors.app_button_color,
                onPressed: () async => await performContactUs(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future performContactUs() async {
    if (checkData()) {
      await contactUs();
    }
  }

  bool checkData() {
    if (_subjectEditingController.text.isNotEmpty &&
        _msgEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future contactUs() async {
    bool status = await UsersGetxController.to.contactUs(context, subject: _subjectEditingController.text, msg: _msgEditingController.text);
    if (status) {
      Get.back();
    }
  }
}
