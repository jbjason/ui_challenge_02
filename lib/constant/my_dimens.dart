import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/my_color.dart';

class MyDimens {
  Widget getCircularItem(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColor.whiteColor,
      ),
      child: Icon(icon),
    );
  }
}
