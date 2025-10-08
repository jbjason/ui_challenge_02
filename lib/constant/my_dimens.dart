import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'dart:math';

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

  double getDistancePercentage({
    required Offset currentpoint,
    required Offset center,
    required Offset rightCorner,
  }) {
    // Calculate actual distance from center to point
    double dxPoint = currentpoint.dx - center.dx;
    double dyPoint = currentpoint.dy - center.dy;
    double actualDistance = sqrt(dxPoint * dxPoint + dyPoint * dyPoint);

    // Calculate maximum possible distance (center to corner)
    double dxMax = rightCorner.dx - center.dx;
    double dyMax = rightCorner.dy - center.dy;
    double maxDistance = sqrt(dxMax * dxMax + dyMax * dyMax);

    // Return percentage
    return (actualDistance / maxDistance); // * 100;
    // adding clamp bcz, um using percentage for scalling & its to between (1- (0 to .85)).
    // setting .2 is the lower limit
  }
}
