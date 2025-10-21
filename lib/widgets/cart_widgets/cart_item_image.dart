import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/my_image.dart';

class CartItemImage extends StatelessWidget {
  const CartItemImage({
    super.key,
    required this.controller,
    required this.sizeAnimation,
    required this.colorAnimation,
  });
  final AnimationController controller;
  final Animation<double?> sizeAnimation;
  final Animation<Color?> colorAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return SizedBox(
          width: sizeAnimation.value,
          height: sizeAnimation.value,
          child: Image.asset(
            MyImage.boxImg,
            color: colorAnimation.value,
          ),
        );
      },
    );
  }
}
