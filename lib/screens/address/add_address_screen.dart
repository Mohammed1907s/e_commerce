import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/address_getx_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/address.dart';
import 'package:e_commerce/models/address_details.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

// late String name;
// late String info;
// late String contactNumber;
// late int cityId;

class _AddAddressScreenState extends State<AddAddressScreen> {
  late TextEditingController nameEditingController;
  late TextEditingController infoEditingController;
  late TextEditingController contactNumberEditingController;


  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController();
    infoEditingController = TextEditingController();
    contactNumberEditingController = TextEditingController();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    infoEditingController.dispose();
    contactNumberEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: AppText(
           'Add Address',
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          SizedBox(height: 30),

          TextField(



            // textAlign: textAlign,
            keyboardType: TextInputType.phone,
            controller: contactNumberEditingController,
            maxLength: 9,
            // maxLines: maxLines,
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

              hintText: 'Mobile',
              //counterText: '',
              hintStyle: TextStyle(
                color: Color(0xff9D9EA3),
                fontFamily: 'Poppins',
                fontSize: SizeConfig.scaleTextFont(15),
              ),
              suffixIcon:  Icon(Icons.phone_android_outlined,color: Colors.grey,) ,
              //prefix: AppText('+970',color: Colors.black,fontSize: SizeConfig.scaleTextFont(15),),
              prefixText: '+970',

              prefixStyle: TextStyle(color: Colors.black,fontFamily: 'Poppins',
                fontSize: SizeConfig.scaleTextFont(15),),

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
          ),
          SizedBox(height: 20),
          AppTextField(
            controller: nameEditingController,
            hintText: 'Name',
          ),
          SizedBox(height: 15),
          AppTextField(
            controller: infoEditingController,
            hintText: 'info',
          ),
          SizedBox(height: 42),
          AppElevatedButton(
            title: 'Add',

            color: AppColors.app_button_color,
            onPressed: () async {
              await performAdd();
            },
          ),
          SizedBox(
            height: 170,
          ),
        ],
      ),
    );
  }

  Future<void> performAdd() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (
    nameEditingController.text.isNotEmpty &&
        infoEditingController.text.isNotEmpty &&
        contactNumberEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future<void> save() async {
    AddressDetails address = AddressDetails();
    address.name = nameEditingController.text;
    address.contactNumber = contactNumberEditingController.text;
    address.info = infoEditingController.text;
    address.cityId = SharedPreferencesController().user!.cityId;

    bool status = await AddressGetxController.to.createAddress(
        context: context,
        address: address
    );
    if (status) {
      Navigator.pop(context);
    } else {
      Helper.showSnackBar(context, text: 'error', error: true);
    }
  }
}
