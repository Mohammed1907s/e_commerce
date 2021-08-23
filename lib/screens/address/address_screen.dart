import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/address_getx_controller.dart';
import 'package:e_commerce/models/address_details.dart';
import 'package:e_commerce/screens/address/add_address_screen.dart';
import 'package:e_commerce/screens/address/address_widget.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class AddressScreen extends StatelessWidget {
  AddressGetxController controller = Get.put(AddressGetxController());
  final bool fromOrder;

  AddressScreen({this.fromOrder = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GetX<AddressGetxController>(
        builder: (AddressGetxController controller) {
          return  controller.addresses.isEmpty
              ? Center(
            child: SpinKitFadingCube(
              color: Colors.yellow.shade700,
              size: 50.0,
            ),
          )
              : controller.addresses.isNotEmpty
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.addresses.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AddressWidget(address: controller.addresses[index], onTap: () => popScreen(address: controller.addresses[index]),);
              },
            ),
          )
              :Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.scaleHeight(200),
                    ),
                    Center(
                      child: Container(
                        height: SizeConfig.scaleHeight(150),
                        width: SizeConfig.scaleWidth(150),
                        child: SvgPicture.asset(
                          'images/map.svg',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(16),
                    ),
                    AppText(
                      'No Address...',
                      fontSize: SizeConfig.scaleTextFont(26),
                      fontWeight: FontWeight.w500,
                    ),
                    AppText(
                      '... Please add your Address',
                      fontSize: SizeConfig.scaleTextFont(16),
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(125),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.scaleWidth(30)),
                      child: AppElevatedButton(
                          title: 'Add Address',
                          onPressed: () {
                            Get.to(AddAddressScreen());
                          },
                          color: AppColors.app_button_color),
                    )
                  ]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:AppColors.app_button_color ,
        onPressed: () {
          Get.to(AddAddressScreen());
        },
        child: Icon(Icons.add,),
      ),
    );
  }
  popScreen({required AddressDetails address}) {
    if (fromOrder) Get.back(result: address);
  }
}
