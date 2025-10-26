import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'package:ui_challenge_02/constant/my_image.dart';

class CartFloatingBagButton extends StatelessWidget {
  const CartFloatingBagButton(
      {super.key,
      required this.percent,
      required this.controllerValue,
      this.countAnim = 0,
      required this.count});
  final double percent;
  final double controllerValue;
  final double countAnim;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          tileMode: TileMode.clamp,
          transform: GradientRotation(20 * (1 - percent.clamp(0, 1))),
          colors: [
            Colors.deepOrange,
            Colors.yellow,
            Colors.yellow,
            Colors.deepPurple,
            Colors.deepPurple,
            Colors.deepOrange,
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Colors.grey,
            spreadRadius: 2,
            offset: Offset(5, 10),
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: lerpDouble(5, -15, countAnim),
            right: lerpDouble(15, -15, countAnim),
            child: Opacity(
              opacity: countAnim.clamp(0, 1),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColor.primaryColor),
                child: Text(
                  "1",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          if (count > 0)
            Positioned(
              top: -15,
              right: -15,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColor.primaryColor),
                child: Text(
                  count.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          percent < .5
              ? Image.asset(MyImage.bagOpenImg, color: Colors.white, width: 45)
              : Icon(CupertinoIcons.bag_fill, color: Colors.white, size: 45),
        ],
      ),
    );
  }
}
