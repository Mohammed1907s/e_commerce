import 'package:e_commerce/utils/size_config.dart';
import 'package:flutter/material.dart';


class AppElevatedButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Color color;

  AppElevatedButton({
    required this.title,
    required this.onPressed,
    required this.color ,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title,style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: SizeConfig.scaleTextFont(16),
        fontWeight: FontWeight.w500,
        color: Colors.black
      ),),
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: Size(
          double.infinity,
          SizeConfig.scaleHeight(64),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
