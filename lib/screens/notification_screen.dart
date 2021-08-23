import 'package:e_commerce/getx/notification_getx_controller.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:e_commerce/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: AppText(
          'Notification'.tr,
          fontSize: SizeConfig.scaleTextFont(24),
          fontWeight: FontWeight.w600,

        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: GetX<NotificationGetxController>(
        builder: (NotificationGetxController controller) {
          return controller.loading.value
              ? Center(
            child: SpinKitFadingCube(
              color: Colors.yellow.shade700,
              size: 50.0,
            ),
          )
              : controller.notification.isNotEmpty
              ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller.notification.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return NotificationWidget(
                      notificationDetails: controller.notification[index],
                      onTap: ()  {

                      },
                    );
                  },
                ),
              ),

            ],
          )
              : Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: SizeConfig.scaleHeight(150),
                      width: SizeConfig.scaleWidth(150),
                      child: SvgPicture.asset(
                        'images/surprised.svg',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(16),
                  ),
                  AppText(
                    'your cart is empty....'.tr,
                    fontSize: SizeConfig.scaleTextFont(26),
                    fontWeight: FontWeight.w500,
                  ),
                ]),
          );
        },
      ),
    );
  }
}
