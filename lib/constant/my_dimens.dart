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
      margin: EdgeInsets.only(left: itemWidth / 4),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MyColor.whiteColor,
            ),
            child: Icon(icon),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: MyColor.whiteColor),
          ),
        ],
      ),
    );
  }
}
