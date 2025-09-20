import 'package:flutter/material.dart';
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
        CurvedAnimation(parent: _controller, curve: const Interval(.0, .4));
    _lisItemAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.3, .9,curve: Curves.bounceIn));
    _whiteCardAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.7, 1));

    final int length = MyConstant.circularIcons.length;
    final intervalPerItem = (1 / length).toInt();
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 40 * (1 - _blueBoxAnim.value),
            right: 40 * (1 - _blueBoxAnim.value),
            top: (size.height * .15) * (1 - _blueBoxAnim.value),
            bottom: (size.height * .35) * (1 - _blueBoxAnim.value),
            child: Hero(
              tag: Key("hero-tag12"),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    color: MyColor.primaryColor,
                    borderRadius:
                        BorderRadius.circular(17 * (1 - _blueBoxAnim.value)),
                    image: DecorationImage(
                      image: AssetImage(MyImage.galaxyImg),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0 + (size.height * .8) * _lisItemAnim.value,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              MyConstant.circularIconTitles.length,
                              (i) => MyDimens().getCircularItem(
                                MyConstant.circularIconTitles[i],
                                MyConstant.circularIcons[i],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
