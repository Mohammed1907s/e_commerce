
import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/user_getx_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';

import 'package:e_commerce/locale/app_locale.dart';

import 'package:e_commerce/screens/address/address_screen.dart';
import 'package:e_commerce/screens/auth/change_password_screen.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/contact/contact_us_screen.dart';
import 'package:e_commerce/screens/credit_card/display_cards_screen.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UsersGetxController usersController = Get.put(UsersGetxController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(20)),

          scrollDirection: Axis.vertical,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              Row(children: [
                SizedBox(
                  width: SizeConfig.scaleWidth(10),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: SizeConfig.scaleHeight(40),
                  child: Image.asset('images/ulmo-logos_transparent.png',fit: BoxFit.contain,)
                ),
                SizedBox(width: SizeConfig.scaleWidth(15)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      usersController.user!.name,
                      fontSize: SizeConfig.scaleTextFont(13),
                      color: Color(0xFF111111),
                    ),
                    AppText(
                      usersController.user!.mobile,
                      fontSize: SizeConfig.scaleTextFont(12),
                      color: Color(0xFFA5A5A5),
                    ),
                  ],
                ),
              ]),


              ProfileWidget(
                label: 'contact us',
                leading: Icon(Icons.info),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: ()=> Get.to(ContactUsScreen()),
              ),
              ProfileWidget(
                label: 'My Cards',
                leading: Icon(Icons.credit_card_outlined),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => Get.to(DisplayCardScreen()),
              ),

              ProfileWidget(
                label: 'My Address',
                leading: Icon(Icons.location_on),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => Get.to(AddressScreen()),
              ),

              ProfileWidget(
                label: 'language',
                leading: Icon(Icons.language_outlined),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => AppLocale.changeLang(),
              ),
              ProfileWidget(
                label: 'change password',
                leading: Icon(Icons.refresh),
                onTap: ()=> Get.to(ChangePasswordScreen()),
              ),

              ProfileWidget(
                  label: 'logout',
                  leading: Icon(Icons.logout),
                  onTap: (){showCartDialog();}
              ),
            ],
          ),
        ),
      ),
    );
  }
  showCartDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: SizeConfig.scaleWidth(312),
                height: SizeConfig.scaleHeight(312),
                // clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: SizeConfig.scaleHeight(16),),
                      AppText('are you sure you want \n to sign out?',fontSize: SizeConfig.scaleTextFont(24),fontWeight: FontWeight.w600,textAlign: TextAlign.center,),
                      SizedBox(height: SizeConfig.scaleHeight(8),),
                      AppText('We definitely don\'t want that',fontSize: SizeConfig.scaleTextFont(16),fontWeight: FontWeight.w400,textAlign: TextAlign.center,color: Color(0xff9E9E9E),),
                      SizedBox(height: SizeConfig.scaleHeight(24),),
                      AppElevatedButton(title: 'No, I want to stay', onPressed: (){Get.back();}, color: AppColors.app_button_color),
                      SizedBox(height: SizeConfig.scaleHeight(8),),
                      AppElevatedButton(title: 'Yep, sign out', onPressed: () async {
                        bool logout = await UsersGetxController.to.logout(context);
                        if (logout) {
                          Get.offAll(LoginScreen());
                        }
                      }, color: Color(0xffF5F5F5)),




                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }


  }
  /* async {
                    bool logout = await UsersGetxController.to.logout(context);
                    if (logout) {
                      Get.offAll(LoginScreen());
                    }
                  }*/

  /*Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade800,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                      ),
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: AppText(
                        'Add To Card',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: widget.productDetails.imageUrl,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            clipBehavior: Clip.antiAlias,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: AppColors.app_button_color,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        ++cardIncrement;
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppText(
                                      cardIncrement.toString(),
                                    ),
                                  ),
                                  FloatingActionButton(
                                    backgroundColor: AppColors.app_button_color,
                                    mini: true,
                                    onPressed: () {
                                      setState(() {
                                        cardIncrement == 1 ? 1 : --cardIncrement;
                                      });
                                    },
                                    child: Icon(
                                      Icons.remove,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                  'Total Price: ${widget.productDetails.price * cardIncrement}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: AppElevatedButton(
                              onPressed: () async {
                                bool status = await CartGetxController.to
                                    .createCartItem(cartItem);
                                if (status) {
                                  Helper.showSnackBar(context, text: 'add suc');
                                  cardIncrement = 1;
                                } else {
                                  Helper.showSnackBar(context, text: 'add fal');
                                  cardIncrement = 1;
                                }
                                Get.back();
                              },
                              title: 'Add',
                              color: AppColors.app_button_color,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: AppElevatedButton(
                              onPressed: () {
                                cardIncrement = 1;
                                Get.back();
                              },
                              title: 'Cancel',
                              color: AppColors.app_button_color,
                            ),
                          ),
                        ),
                      ],
                    )*/

/*Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(20)),

          scrollDirection: Axis.vertical,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              Row(children: [
                SizedBox(
                  width: SizeConfig.scaleWidth(10),
                ),
                CircleAvatar(
                  backgroundColor: AppColors.app_button_color,
                  radius: SizeConfig.scaleHeight(40),
                  child: Text(
                    'M',
                    style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(24),

                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.scaleWidth(15)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                     '',
                      fontSize: SizeConfig.scaleTextFont(13),
                      color: Color(0xFF111111),
                    ),
                    AppText(
                      '+970595236275',
                      fontSize: SizeConfig.scaleTextFont(12),
                      color: Color(0xFFA5A5A5),
                    ),
                  ],
                ),
              ]),

              Padding(
                padding: EdgeInsets.only(top: SizeConfig.scaleHeight(25), bottom: SizeConfig.scaleHeight(5)),
                child: AppText(
                  'general',
                  color: Colors.black,
                  fontSize: SizeConfig.scaleTextFont(16),
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
              ),
              ProfileWidget(
                label: 'contact us',
                leading: Icon(Icons.info),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: ()=> Get.to(ContactUsScreen()),
              ),
              ProfileWidget(
                label: 'My Cards',
                leading: Icon(Icons.credit_card_outlined),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => Get.to(DisplayCardScreen()),
              ),

              ProfileWidget(
                label: 'My Address',
                leading: Icon(Icons.location_on),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => Get.to(AddressScreen()),
              ),

              ProfileWidget(
                label: 'language',
                leading: Icon(Icons.language_outlined),
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => AppLocale.changeLang(),
              ),
              ProfileWidget(
                label: 'change password',
                leading: Icon(Icons.refresh),
                onTap: ()=> Get.to(ChangePasswordScreen()),
              ),
              ProfileWidget(
                label: 'edit- profile',
                leading: Icon(Icons.manage_accounts_outlined),
                onTap: () {},
              ),
              ProfileWidget(
                  label: 'logout',
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    bool logout = await UsersGetxController.to.logout(context);
                    if (logout) {
                      Get.offAll(LoginScreen());
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );*/
