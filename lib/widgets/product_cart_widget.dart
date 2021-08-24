import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/cart_getx_controller.dart';
import 'package:e_commerce/getx/product_getx_controller.dart';
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/models/product_details.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';

import 'package:flutter/material.dart';

class ProductCartWidget extends StatefulWidget {
  final CartItem cartItem;
  final void Function() onTap;



  ProductCartWidget({required this.cartItem, required this.onTap,});

  @override
  _ProductCartWidgetState createState() => _ProductCartWidgetState();
}

class _ProductCartWidgetState extends State<ProductCartWidget> {
  int cardIncrement = 1;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(SizeConfig.scaleHeight(5)),
      child: Card(
        color: Colors.white,
        child: ListTile(


            leading: Container(
              width: SizeConfig.scaleWidth(100),
              child: Image.network(widget.cartItem.imageUrl,
                fit: BoxFit.contain,

                //height: double.infinity,),
            ),),
            title: Container(

              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,


                    children: [
                      AppText('${widget.cartItem.price *widget.cartItem.quantity}\₪',fontSize: SizeConfig.scaleTextFont(16),fontWeight: FontWeight.w500,color: Colors.black,),
                      Spacer(),
                      IconButton(onPressed: widget.onTap, icon: Icon(Icons.highlight_off_outlined,color: Color(0xff9E9E9E),))
                    ],
                  ),
                  AppText( SharedPreferencesController().languageCode == 'ar' ? widget.cartItem.nameAr: widget.cartItem.nameEn,fontSize: SizeConfig.scaleTextFont(15),fontWeight: FontWeight.w400,color: Color(0xff9E9E9E),),


                ],
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Container(
                  height: SizeConfig.scaleHeight(36),
                  decoration: BoxDecoration(
                      color: Color(0xffF5F5F5),
                      //border: Border.all(color: Colors.orange, width: 1.0),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){ setState(() {
                        cardIncrement == 1 ? 1 : --cardIncrement;
                        widget.cartItem.quantity=cardIncrement;

                      });}, icon: Icon(Icons.remove_outlined,size: SizeConfig.scaleHeight(15),color:cardIncrement==0?Color(0xff9E9E9E): Color(0xff212121),)),


                      AppText(
                        widget.cartItem.quantity.toString(),
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.scaleTextFont(16),
                      ),
                      IconButton(onPressed: (){

                        setState(()  {
                        ++cardIncrement;
                        widget.cartItem.quantity=cardIncrement;


                      });}, icon: Icon(Icons.add,size: SizeConfig.scaleHeight(15),color:  Color(0xff212121),))


                    ],
                  ),
                ),

              ],
            ),



          ),
      ),
    );
  }


}
/*FloatingActionButton(
                        backgroundColor:AppColors.app_button_color ,
                        mini: true,
                        onPressed: () {
                          setState(() {
                            cardIncrement == 1 ? 1 : --cardIncrement;
                          });
                        },
                        child: Icon(
                          Icons.remove,
                        ),
                      ),*/
/*FloatingActionButton(
                        backgroundColor: AppColors.app_button_color ,
                        mini: true,
                        onPressed: () {
                          setState(() {
                            ++cardIncrement;
                          });
                        },
                        child: Icon(
                          Icons.add,
                        ),
                      ),*/
/*Row(
            children: [
              Image.network(cartItem.imageUrl,
                  height: 150, width: 120, fit: BoxFit.fill),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Price For 1 Pic : ${cartItem.price}',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8),
                  AppText(
                    'Quantity: ${cartItem.quantity} pic',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8),
                  AppText(
                    'Total Price: : ${cartItem.price * cartItem.quantity}',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              )
            ],
          ),
        ),
        PositionedDirectional(
          top: 5,
          end: 10,
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade900,
              size: 30,
            ),
          ),
        ),*/
