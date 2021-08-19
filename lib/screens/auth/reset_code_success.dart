import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetCodeSuccessfulScreen extends StatefulWidget {
  const ResetCodeSuccessfulScreen({Key? key}) : super(key: key);

  @override
  _ResetCodeSuccessfulScreenState createState() =>
      _ResetCodeSuccessfulScreenState();
}

class _ResetCodeSuccessfulScreenState extends State<ResetCodeSuccessfulScreen> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.scaleHeight(200),),
          Center(

            child: Container(
              height: SizeConfig.scaleHeight(150),
              width: SizeConfig.scaleWidth(150),
              child: SvgPicture.asset(
                'images/friendly.svg',),
            ),
          ),
          SizedBox(height: SizeConfig.scaleHeight(16),),
          AppText('Verification successful',fontSize: SizeConfig.scaleTextFont(26),fontWeight: FontWeight.w500,),
          SizedBox(height: SizeConfig.scaleHeight(60),),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(30)),
            child: AppElevatedButton(title: 'Sign in now', onPressed: (){Navigator.pushReplacementNamed(context, '/login_screen');}, color: AppColors.app_button_color),
          )
        ],
      ),
    );
  }
}
