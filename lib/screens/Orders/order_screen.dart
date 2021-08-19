
import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/cart_getx_controller.dart';
import 'package:e_commerce/getx/order_getx_controller.dart';
import 'package:e_commerce/models/address_details.dart';
import 'package:e_commerce/models/card.dart';
import 'package:e_commerce/screens/address/address_screen.dart';
import 'package:e_commerce/screens/credit_card/display_cards_screen.dart';
import 'package:e_commerce/utils/helper.dart';
import 'package:e_commerce/widgets/app_elevated_button.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  final String cart;

  OrderScreen({required this.cart});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isOnline = true;
  AddressDetails? address;
  MyCard? card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: AppText(
          'Make Order',
          color:Colors.black,
          fontSize: 20,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          GestureDetector(
            onTap: () async {
              AddressDetails selectedAddress = await Get.to(AddressScreen(
                fromOrder: true,
              ));
              setState(() {
                address = selectedAddress;
              });
            },
            child: Container(
              padding: EdgeInsetsDirectional.only(start: 28, end: 10),
              alignment: AlignmentDirectional.centerStart,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF999999).withAlpha(25),
                      offset: Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  getAddress(),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.yellow,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              MyCard selectedCard = await Get.to(DisplayCardScreen(fromOrder: true,));
              setState(() {
                card = selectedCard;
              });
            },
            child: Container(
                padding: EdgeInsetsDirectional.only(start: 28, end: 10),
                alignment: AlignmentDirectional.centerStart,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF999999).withAlpha(25),
                        offset: Offset(0, 5),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    getCard(),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.yellow,
                    )
                  ],
                )),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: Colors.yellow,
                  value: isOnline,
                  onChanged: (var selected) {
                    setState(() {
                      isOnline = true;
                    });
                  },
                  title: AppText(
                     'Online',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),

              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor:Colors.yellow,
                  value: !isOnline,
                  onChanged: (var selected) {
                    setState(() {
                      isOnline = false;
                    });
                  },
                  title: AppText(
                   'Offline',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 42),
          AppElevatedButton(
            title: 'Confirm Order',
            color: AppColors.app_button_color,
            onPressed: () async => await performOrder(),
          ),
        ],
      ),
    );
  }

  Widget getCard() {
    if (card == null) {
      return AppText(
        'Select Card',
        color: Colors.grey,
      );
    } else {
      return AppText(
         card!.cardNumber,
        color: Colors.black,
        fontSize: 16,
      );
    }
  }

  Widget getAddress() {
    if (address == null) {
      return AppText(
        'Select Address',
        color: Colors.grey,
      );
    } else {
      return AppText(
         address!.info,
        color: Colors.black,
        fontSize: 16,
      );
    }
  }

  Future<void> performOrder() async {
    if (checkData())
      await makeOrder();
    else
      Helper.showSnackBar(context, text: 'Enter Required Data');
  }

  bool checkData() {
    if (card != null && address != null) return true;
    return false;
  }

  Future<void> makeOrder() async {
    bool status = await OrderGetxController.to.createOrder(
        context: context,
        cart: widget.cart,
        paymentType: isOnline ? 'Online' : 'Offline',
        addressId: address!.id,
        cardId: card!.id);
    if (status) {
      await CartGetxController.to.deleteAllItem();
      Get.back();
    }
  }
}