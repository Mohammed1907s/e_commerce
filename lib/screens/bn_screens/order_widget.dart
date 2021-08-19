import 'package:e_commerce/models/orders.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OrderWidget extends StatelessWidget {
  final Order order;

  OrderWidget({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsetsDirectional.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: Offset(0, 0),
              blurRadius: 6,
              spreadRadius: 3,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        height: SizeConfig.scaleHeight(80),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Order ID ${order.id}',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                AppText(
                  'Total Price: ${order.total}',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color:Colors.black,
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: order.status == 'Waiting' ? Colors.red : Colors.green),
              child: AppText(
                ' ${order.status}',
              ),
            )
          ],
        ),
      ),
    );
  }
}
