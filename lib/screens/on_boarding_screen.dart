import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/ulmo-logos_black.png'),
            SizedBox(height: SizeConfig.scaleHeight(10),),
            Text('Get quality and classy products at very affordable prices',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.scaleTextFont(20)),),
            SizedBox(height: SizeConfig.scaleHeight(100),),
            AppElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/login_screen');
              },
              title: 'Sign in',
              color: AppColors.app_button_color_disabled,),
            SizedBox(height: SizeConfig.scaleHeight(21),),
            AppElevatedButton(
              onPressed: (){ Navigator.pushNamed(context, '/register_screen');},
              title: 'Register',
              color: AppColors.app_button_color,),


          ],
        ),
      ),
    );
  }
}
