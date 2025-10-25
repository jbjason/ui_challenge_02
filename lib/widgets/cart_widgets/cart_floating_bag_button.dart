import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/my_image.dart';

class CartFloatingBagButton extends StatelessWidget {
  const CartFloatingBagButton(
      {super.key, required this.percent, required this.controllerValue});
  final double percent;
  final double controllerValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          tileMode: TileMode.clamp,
          transform: GradientRotation(
              20 * (1 - percent.clamp(0, 1)) * controllerValue),
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
      child: percent < .5
          ? Image.asset(MyImage.bagOpenImg, width: 45)
          : Icon(CupertinoIcons.bag_fill, color: Colors.white, size: 45),
    );
  }
}
