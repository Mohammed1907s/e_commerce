import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/address_getx_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/address_details.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  final AddressDetails address;

  EditAddressScreen({required this.address});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController nameEditingController;
  late TextEditingController infoEditingController;
  late TextEditingController contactNumberEditingController;

  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController(text: widget.address.name);
    infoEditingController = TextEditingController(text: widget.address.info);
    contactNumberEditingController =
        TextEditingController(text: widget.address.contactNumber);
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: AppText(
          'Edit Address',
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Padding(
              child: AppText( 'Phone Number',color: Colors.grey,),
              padding: EdgeInsets.all(10),
            ),
            AppTextField(
              controller: contactNumberEditingController,
              hintText: 'Phone Number',
              prefix: AppText( '+970',color: Colors.black,
                fontSize: SizeConfig.scaleTextFont(16),),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Padding(
              child: AppText('Name',color: Colors.grey,),
              padding: EdgeInsets.all(10),
            ),
            AppTextField(
              controller: nameEditingController,
              hintText: 'Name',
            ),
            SizedBox(height: 15),
            Padding(
              child: AppText( 'Info',color: Colors.grey,),
              padding: EdgeInsets.all(10),
            ),
            AppTextField(
              controller: infoEditingController,
              hintText: 'info : Country, City, Street',
            ),
            SizedBox(height: 42),
            AppElevatedButton(
              title: 'Edit',
              color: AppColors.app_button_color,

              onPressed: () async {
                await performEdit();
              },
            ),
            SizedBox(
              height: 170,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performEdit() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (nameEditingController.text.isNotEmpty &&
        infoEditingController.text.isNotEmpty &&
        contactNumberEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future<void> save() async {
    AddressDetails address = AddressDetails();
    address.id = widget.address.id;
    address.name = nameEditingController.text;
    address.contactNumber = contactNumberEditingController.text;
    address.info = infoEditingController.text;
    address.cityId = SharedPreferencesController().user!.cityId;
    bool status = await AddressGetxController.to.updateAddress(context: context, address: address);
    if (status) {
      Navigator.pop(context);
    } else {
      Helper.showSnackBar(context, text: 'error', error: true);
    }
  }
}