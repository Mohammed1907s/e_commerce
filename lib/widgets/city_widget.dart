
import 'package:e_commerce/local_storge/shared_preferences/preferences.dart';
import 'package:e_commerce/models/city.dart';
import 'package:e_commerce/widgets/app_text.dart';
import 'package:flutter/material.dart';


class CityWidget extends StatelessWidget {
  final City city;
  final void Function() onTap;

  CityWidget({required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: AppText(
                 SharedPreferencesController().languageCode == 'ar' ? city.nameAr[0]: city.nameEn[0],
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 15),
            Text(SharedPreferencesController().languageCode == 'ar' ? city.nameAr: city.nameEn),
          ],
        ),
      ),
    );
  }
}
