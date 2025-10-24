import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';

class CartWhiteCard extends StatelessWidget {
  const CartWhiteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: context.screenHeight * .8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
      ),
    );
  }
}
