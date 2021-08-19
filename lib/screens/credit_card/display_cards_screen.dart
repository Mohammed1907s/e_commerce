import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/card_getx_controller.dart';
import 'package:e_commerce/models/card.dart';
import 'package:e_commerce/screens/credit_card/create_credit_card.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/my_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DisplayCardScreen extends StatelessWidget {
  final bool fromOrder;

  DisplayCardScreen({this.fromOrder = false});

  CardGetxController controller = Get.put(CardGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GetX<CardGetxController>(
        builder: (CardGetxController controller) {
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : controller.cards.isNotEmpty
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 29, vertical: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.cards.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // return AddressWidget(
                          //   address: controller.addresses[index],
                          // );
                          return GestureDetector(
                            onTap: (){ popScreen(card: controller.cards[index]);},
                            child: MyCardWidget(
                              expiryDate: controller.cards[index].expDate,
                              // cvvCode: controller.cards[index].cvv,
                              flag: false,
                              cardHolderName: controller.cards[index].holderName,
                              cardNumber: controller.cards[index].cardNumber,
                              cardType: controller.cards[index].type == 'Visa'
                                  ? CardType.visa
                                  : CardType.mastercard,
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
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
                                'images/dissatisfied.svg',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(16),
                          ),
                          AppText(
                            'No payment cards...',
                            fontSize: SizeConfig.scaleTextFont(26),
                            fontWeight: FontWeight.w500,
                          ),
                          AppText(
                            '... Please add a payment card',
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
                                title: 'Add a payment card',
                                onPressed: () {
                                  Get.to(CreateCreditCard());
                                },
                                color: AppColors.app_button_color),
                          )
                        ]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:AppColors.app_button_color ,
        onPressed: () {
          Get.to(CreateCreditCard());
        },
        child: Icon(Icons.add,),
      ),
    );
  }
  popScreen({required MyCard card}) {
    print(fromOrder);
    if (fromOrder) Get.back(result: card);
  }
}
