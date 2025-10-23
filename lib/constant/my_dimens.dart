import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'dart:math';

class MyDimens {
  Widget getCircularItem({
    required double itemWidth,
    required String title,
    required IconData icon,
    required int selectedIndex,
    required int currentIndex,
  }) {
    return Container(
      width: itemWidth,
      margin: EdgeInsets.only(left: itemWidth / 4),
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white10),
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
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIndex == currentIndex
                    ? Colors.white
                    : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Calculates the percentage distance of a point from the bottom-right corner
  /// of a box, normalized by the box's diagonal.
  ///
  /// Returns 0.0 when the point is at bottomRight, and 1.0 when at leftTop.
  ///
  /// Parameters:
  /// - [point]: The point to measure
  /// - [leftTop]: Top-left corner of the box
  /// - [bottomRight]: Bottom-right corner of the box
  double getDistancePercentage({
    required Offset point,
    required Offset leftTop,
    required Offset bottomRight,
  }) {
    // Calculate the maximum possible distance (diagonal of the box)
    final boxWidth = bottomRight.dx - leftTop.dx;
    final boxHeight = bottomRight.dy - leftTop.dy;
    final maxDistance = sqrt(boxWidth * boxWidth + boxHeight * boxHeight);

    // Calculate the actual distance from the point to bottomRight
    final dx = bottomRight.dx - point.dx;
    final dy = bottomRight.dy - point.dy;
    final actualDistance = sqrt(dx * dx + dy * dy);

    // Return the percentage (normalized distance)
    return (actualDistance / maxDistance);
  }
}
