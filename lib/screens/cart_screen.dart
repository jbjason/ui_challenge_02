import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/widgets/cart_widgets/cart_blue_box.dart';

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
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          CartBlueBox(
            blueBoxAnim: _blueBoxAnim,
            listItemAnimationList: _listItemAnimationList,
            controller: _controller,
          ),
          // white bottom containter
          _getWhiteCard
        ],
      ),
    );
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
          child:  Column(
            children: [
              
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
