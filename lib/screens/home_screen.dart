import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/widgets/cart_widgets/cart_floating_bag_button.dart';
import 'package:ui_challenge_02/widgets/home_widgets/home_blue_box.dart';
import 'package:ui_challenge_02/widgets/home_widgets/home_bottom_navigate_bar.dart';
import 'package:ui_challenge_02/widgets/home_widgets/home_top_text_bottom_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _blueBoxAnim,
      _lisItemAnim,
      _whiteCardAnim,
      _cartButtonAnim;
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
        CurvedAnimation(parent: _controller, curve: const Interval(.2, .9));
    _whiteCardAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.5, .9));
    _cartButtonAnim = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.5, .9, curve: Curves.bounceInOut));

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeTopTextBottomCards(),
          // blue box
          HomeBlueBox(
            blueBoxAnim: _blueBoxAnim,
            listItemAnimationList: _listItemAnimationList,
            controller: _controller,
          ),
          // white bottom containter
          _getWhiteCard,
          Positioned(
            bottom: 10,
            right: 10,
            child: Opacity(
              opacity: _cartButtonAnim.value,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..translate(30 * (1 - _cartButtonAnim.value), 0.0, 0.0),
                child: CartFloatingBagButton(percent: 1, controllerValue: 0),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: HomeBottomNavigateBar(),
          ),
        ],
      ),
    );
  }

  Positioned get _getWhiteCard => Positioned(
        left: 0,
        right: 0,
        bottom: (-context.screenHeight * .8) * (1 - _whiteCardAnim.value),
        height: context.screenHeight * .8,
        child: DecoratedBox(
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
