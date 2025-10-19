import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';
import 'package:ui_challenge_02/screens/drag_test_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: MyColor.primaryColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SafeArea(
                child: Row(
                  children: List.generate(
                    MyConstant.circularIconTitles.length,
                    (i) => MyDimens().getCircularItem(
                      itemWidth: context.listItemWidth,
                      title: MyConstant.circularIconTitles[i],
                      icon: MyConstant.circularIcons[i],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // white bottom containter
          _getWhiteCard(context),
        ],
      ),
    );
  }

  Positioned _getWhiteCard(BuildContext context) => Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        height: context.screenHeight * .8,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: DragTestScreen(),
        ),
      );
}
