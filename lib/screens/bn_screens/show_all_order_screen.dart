import 'package:e_commerce/getx/order_getx_controller.dart';
import 'package:e_commerce/screens/bn_screens/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';


class AllOrdersScreen extends StatefulWidget {

  @override
  _AllOrdersScreenState createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await OrderGetxController.to.getOrders();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       elevation: 0,
     ),


     body : Container(
      child: GetX<OrderGetxController>(
        builder: (OrderGetxController controller) {
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : controller.orders.isNotEmpty
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.orders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return OrderWidget(
                  order: controller.orders[index],
                );
              },
            ),
          )
              : Center(child: Text('No Data'));
        },
      ),
    ),
    );
  }
}
