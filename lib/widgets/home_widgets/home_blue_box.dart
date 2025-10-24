// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';
import 'package:ui_challenge_02/screens/cart_screen.dart';

class HomeBlueBox extends StatelessWidget {
  const HomeBlueBox({
    super.key,
    required this.blueBoxAnim,
    required this.listItemAnimationList,
    required this.controller,
  });
  final AnimationController controller;
  final Animation<double> blueBoxAnim;
  final List<Animation<double>> listItemAnimationList;

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    return Positioned(
      left: 20 * (1 - blueBoxAnim.value),
      right: 20 * (1 - blueBoxAnim.value),
      top: (height * .2) * (1 - blueBoxAnim.value),
      bottom: (height * .35) * (1 - blueBoxAnim.value),
      child: InkWell(
        onTap: () async {
          controller.forward(from: 0.0).whenComplete(() async {
            await Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: ((context, animation, secondaryAnimation) =>
                    FadeTransition(opacity: animation, child: CartScreen())),
              ),
            );
            controller.reverse(from: 1);
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: MyColor.primaryColor,
            borderRadius: BorderRadius.circular(17 * (1 - blueBoxAnim.value)),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (controller.value == 0) ...[
                Positioned(
                  right: -context.screenHeight * .1,
                  top: -context.screenHeight * .15,
                  child: Lottie.asset('assets/hello.json',
                      fit: BoxFit.cover, height: context.screenHeight * .4),
                ),
                Positioned(
                  top: context.screenHeight * .05,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⛅ 32° C",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                      Text(
                        "24",
                        style: GoogleFonts.archivoBlack(
                            color: Colors.white, fontSize: 40),
                      ),
                      Text(
                        "JANUARY",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
              ..._getCircularItems(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Positioned> _getCircularItems(BuildContext context) {
    if (controller.value > 0) {
      final items = <Positioned>[];
      final bottomInitial = context.screenHeight * .35;
      for (int i = 0; i < MyConstant.circularIcons.length; i++) {
        final leftWidth = (context.listItemWidth +
                (i == 0 ? 0.0 : context.listItemWidth / 4)) *
            i;
        final bottomVal = bottomInitial * (blueBoxAnim.value) +
            (context.screenHeight * .45) * listItemAnimationList[i].value;
        items.add(
          Positioned(
            bottom: bottomVal,
            left: leftWidth,
            child: MyDimens().getCircularItem(
              itemWidth: context.listItemWidth,
              title: MyConstant.circularIconTitles[i],
              icon: MyConstant.circularIcons[i],
              currentIndex: i,
              selectedIndex: 0,
            ),
          ),
        );
      }
      return items;
    } else {
      return [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
        )
      ];
    }
  }
}
