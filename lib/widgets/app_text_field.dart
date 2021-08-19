
import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:flutter/material.dart';


class AppTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int maxLength;
  final int maxLines;
  final TextAlign textAlign;
  final bool enablePadding;
  final bool isPassword;
  final IconData? suffixIcon;
  final Widget? prefix;

  final void Function(String value)? onChanged;

  AppTextField({
    required this.controller,
    required this.hintText,
    this.textAlign = TextAlign.start,
    this.maxLength = 20,
    this.maxLines = 1,
    this.enablePadding = false,
    this.onChanged,
    this.suffixIcon,
    this.keyboardType = TextInputType.text, this.prefix, this.isPassword=false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,



      textAlign: textAlign,
      keyboardType: keyboardType,
      controller: controller,
      maxLength: maxLength,
       maxLines: maxLines,
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

        hintText: hintText,
        counterText: '',
        hintStyle: TextStyle(
          color: Color(0xff9D9EA3),
          fontFamily: 'Poppins',
          fontSize: SizeConfig.scaleTextFont(15),
        ),
        suffixIcon:  Icon(suffixIcon,color: Colors.grey,) ,
        prefix: prefix,

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
    );
  }
}
