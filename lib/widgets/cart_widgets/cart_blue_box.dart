import 'package:flutter/cupertino.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';

class CartBlueBox extends StatelessWidget {
  const CartBlueBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 13),
      color: MyColor.primaryColor,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SafeArea(
          child: UnconstrainedBox(
            child: Row(
              children: List.generate(
                MyConstant.circularIconTitles.length,
                (i) => MyDimens().getCircularItem(
                  itemWidth: context.listItemWidth,
                  title: MyConstant.circularIconTitles[i],
                  icon: MyConstant.circularIcons[i],
                  currentIndex: i,
                  selectedIndex: 0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
