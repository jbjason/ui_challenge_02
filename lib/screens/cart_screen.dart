import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';
import 'package:ui_challenge_02/constant/my_image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _blueBoxAnim, _lisItemAnim, _whiteCardAnim;
  final List<Animation<double>> _listItemAnimationList = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _blueBoxAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.1, .5));
    _lisItemAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.2, .8));
    _whiteCardAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.5, 1));

    final int length = MyConstant.circularIcons.length;
    final intervalPerItem = 1 / length;
    for (int i = 0; i < length; i++) {
      _listItemAnimationList.add(
        CurvedAnimation(
          parent: _lisItemAnim,
          curve: Interval(
            i * intervalPerItem + .0, // starting interval
            (i + 1) * intervalPerItem + .0, // ending interval
            curve: Curves.bounceIn,
          ),
          // interval for 5 items  0 =(0,.2), 1=(.2,.4)......(.8,1)
        ),
      );
    }
    _controller.addListener(() => setState(() {}));
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 20 * (1 - _blueBoxAnim.value),
            right: 20 * (1 - _blueBoxAnim.value),
            top: (height * .2) * (1 - _blueBoxAnim.value),
            bottom: (height * .35) * (1 - _blueBoxAnim.value),
            child: Hero(
              tag: Key("hero-tag12"),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  color: MyColor.primaryColor,
                  borderRadius:
                      BorderRadius.circular(17 * (1 - _blueBoxAnim.value)),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ..._getCircularItems,
                  ],
                ),
              ),
            ),
          ),
          // white bottom containter
          _getWhiteCard
        ],
      ),
    );
  }

  List<Positioned> get _getCircularItems {
    if (_controller.value < 1) {
      final items = <Positioned>[];
      final bottomInitial = context.screenHeight * .35;
      for (int i = 0; i < MyConstant.circularIcons.length; i++) {
        final leftWidth = (context.listItemWidth +
                (i == 0 ? 0.0 : context.listItemWidth / 4)) *
            i;
        final bottomVal = bottomInitial * (_blueBoxAnim.value) +
            (context.screenHeight * .45) * _listItemAnimationList[i].value;
        items.add(
          Positioned(
            bottom: bottomVal,
            left: leftWidth,
            child: MyDimens().getCircularItem(
              itemWidth: context.listItemWidth,
              title: MyConstant.circularIconTitles[i],
              icon: MyConstant.circularIcons[i],
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
          bottom: context.screenHeight * .8,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
        )
      ];
    }
  }

  Positioned get _getWhiteCard => Positioned(
        left: 0,
        right: 0,
        bottom: (-context.screenHeight * .8) * (1 - _whiteCardAnim.value),
        height: context.screenHeight * .8,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
        ),
      );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
