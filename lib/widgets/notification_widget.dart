import 'package:e_commerce/models/notification.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationDetails notificationDetails;
  final void Function() onTap;



  NotificationWidget({required this.notificationDetails, required this.onTap,});

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(SizeConfig.scaleHeight(5)),
      child: Card(
        color: Colors.white,
        child: ListTile(



          title: Container(

            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,


                  children: [
                    AppText('${widget.notificationDetails.title}',fontSize: SizeConfig.scaleTextFont(16),fontWeight: FontWeight.w500,color: Colors.black,),
                    Spacer(),
                    AppText('${widget.notificationDetails.sentAt}',fontSize: SizeConfig.scaleTextFont(16),fontWeight: FontWeight.w500,color: Colors.black,),
                  ],
                ),
                AppText( '${widget.notificationDetails.subtitle}',fontSize: SizeConfig.scaleTextFont(15),fontWeight: FontWeight.w400,color: Color(0xff9E9E9E),),


              ],
            ),
          ),
          subtitle:
          AppText( '${widget.notificationDetails.body}',fontSize: SizeConfig.scaleTextFont(15),fontWeight: FontWeight.w400,color: Color(0xff9E9E9E),),




        ),
      ),
    );
  }


}