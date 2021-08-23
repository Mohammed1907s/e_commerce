import 'package:e_commerce/extenssions/app_colors_extenssion.dart';
import 'package:e_commerce/getx/address_getx_controller.dart';
import 'package:e_commerce/models/address_details.dart';
import 'package:e_commerce/screens/address/address_edite_screen.dart';
import 'package:e_commerce/utils/size_config.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class AddressWidget extends StatelessWidget {
  final AddressDetails address;
  final void Function() onTap;

  AddressWidget({required this.address,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: Icon(
              Icons.location_on,
              color: Color(0xff212121),
              size: 30,
            ),
            title: AppText('${address.info}',fontWeight: FontWeight.w400,fontSize: SizeConfig.scaleTextFont(16),),
            subtitle: AppText('${address.name},+970${address.contactNumber}',fontWeight: FontWeight.w400,fontSize: SizeConfig.scaleTextFont(14),),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.indigo,
            icon: Icons.edit,
            onTap: ()  => Get.to(EditAddressScreen(address: address)),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: ()async => await performDialog(context),
          ),
        ],
      ),
    );
  }

  Future<bool> deleteAddressDialog({required BuildContext context}) async {
    bool status = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: AppText(
               'Delete Address',
              textAlign: TextAlign.start,
            ),
            content: AppText(
               'Are you sure you want to delete this Address?',
              textAlign: TextAlign.start,
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: AppText( 'No'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: AppText( 'Yes'),
              ),
            ],
          );
        });
    return status;
  }

  Future<void> performDialog(BuildContext context) async {
    bool status = await deleteAddressDialog(context: context);
    if (status) {
      await AddressGetxController.to
          .deleteAddress(context: context, addressId: address.id);
    }
  }

}
/*Slidable(
  actionPane: SlidableDrawerActionPane(),
  actionExtentRatio: 0.25,
  child: Container(
    color: Colors.white,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.indigoAccent,
        child: Text('$3'),
        foregroundColor: Colors.white,
      ),
      title: Text('Tile n°$3'),
      subtitle: Text('SlidableDrawerDelegate'),
    ),
  ),
  actions: <Widget>[
    IconSlideAction(
      caption: 'Archive',
      color: Colors.blue,
      icon: Icons.archive,
      onTap: () => _showSnackBar('Archive'),
    ),
    IconSlideAction(
      caption: 'Share',
      color: Colors.indigo,
      icon: Icons.share,
      onTap: () => _showSnackBar('Share'),
    ),
  ],
  secondaryActions: <Widget>[
    IconSlideAction(
      caption: 'More',
      color: Colors.black45,
      icon: Icons.more_horiz,
      onTap: () => _showSnackBar('More'),
    ),
    IconSlideAction(
      caption: 'Delete',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () => _showSnackBar('Delete'),
    ),
  ],
);*/


/*Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 8,
                end: 8,
                top: 8,
                bottom: 8,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                radius: 30,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red.shade900,
                  size: 30,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                   address.info,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                SizedBox(height: 5),
                AppText(
                  address.contactNumber,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async => await performDialog(context),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              color: Colors.yellow.shade200,
              child: IconButton(
                onPressed: () => Get.to(EditAddressScreen(address: address)),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),*/
