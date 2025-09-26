import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/my_color.dart';

class MyDimens {
  Widget getCircularItem({
    required double itemWidth,
    required String title,
    required IconData icon,
  }) {
    return Container(
      width: itemWidth,
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.only(left: itemWidth / 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColor.whiteColor,
      ),
      child: Icon(icon),
    );
  }
}
