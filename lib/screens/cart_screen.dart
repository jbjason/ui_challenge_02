import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';
import 'package:ui_challenge_02/widgets/cart_widgets/cart_blue_box.dart';
import 'package:ui_challenge_02/widgets/cart_widgets/cart_box_details.dart';
import 'package:ui_challenge_02/widgets/cart_widgets/cart_floating_bag_button.dart';
import 'package:ui_challenge_02/widgets/cart_widgets/cart_item_image.dart';
import 'package:ui_challenge_02/widgets/cart_widgets/cart_white_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  final GlobalKey _myWidgetKey = GlobalKey();
  late AnimationController _controller, _controller2;
  late Animation<double> _boxAcceptAnim;
  late Animation<Color?> _colorAnima;
  late Animation<double?> _sizeAnim, _countAnim;
  late Animation<double> curve;
  double _leftPoint = 0.0, _topPoint = 0.0, _percent = 1;
  double _startLeftPoint = 0.0, _startTopPoint = 0.0;
  Offset _targetLeftTop = Offset(0, 0), _targetBottomRight = Offset(0, 0);
  Offset _currentPoint = Offset(0, 0);
  int _previousColor = 0, _selectedColor = 0, _count = 0;

  @override
  void initState() {
    super.initState();
    _initController1();
    _initColorChangeController();
  }

  void _initController1() {
    _controller =
        AnimationController(vsync: this, duration: MyConstant.duration);
    _boxAcceptAnim =
        CurvedAnimation(curve: Interval(0, .5), parent: _controller);
    _countAnim = CurvedAnimation(
        parent: _controller, curve: Interval(.8, 1, curve: Curves.easeIn));
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        _setBoxInitialPoint();
        _setTargentPoint();
      }),
    );
    _controller.addListener(() => _listener());
  }

  void _initColorChangeController() {
    _controller2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    curve = CurvedAnimation(parent: _controller2, curve: Curves.slowMiddle);
    _colorAnima =
        ColorTween(begin: MyConstant.colors[0], end: MyConstant.colors[0])
            .animate(curve);

    _sizeAnim = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 180, end: 200), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 200, end: 180), weight: 50)
    ]).animate(curve);
  }

  void _listener() => setState(() => _boxAnimObDragAccepted());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          // blue box
          CartBlueBox(),
          // white bottom containter
          CartWhiteCard(),
          // bottom colorful cart icon
          Positioned(
            bottom: 10,
            right: 10,
            child: Transform.scale(
              scale: 1 + .5 * (1 - _percent.clamp(0, 1)),
              child: CartFloatingBagButton(
                percent: _percent,
                controllerValue: _controller.value,
                count: _count,
                countAnim: _countAnim.value ?? 0,
              ),
            ),
          ),
          // details --> text, Colors, buttons
          Positioned(
            top: context.screenHeight * .5,
            left: 0,
            right: 0,
            child: CartBoxDetails(
                selectedColor: _selectedColor, onTap: _onColorTap),
          ),
          // image on back --> not draggable
          Positioned(
            left: _startLeftPoint,
            top: _startTopPoint,
            child: CartItemImage(
              controller: _controller2,
              sizeAnimation: _sizeAnim,
              colorAnimation: _colorAnima,
            ),
          ),
          // Draggable image on front
          Positioned(
            left: _leftPoint,
            top: _topPoint,
            child: GestureDetector(
              onPanEnd: _onPanEnd,
              onPanUpdate: (details) {
                _currentPoint = details.localPosition;
                _leftPoint = _currentPoint.dx + 60;
                _topPoint = _currentPoint.dy + 60;
                _findDifference(_currentPoint);
                setState(() {});
                print("percent:     $_percent");
              },
              child: Transform.scale(
                scale: _percent.clamp(0, 1),
                child: Container(
                  key: _myWidgetKey,
                  child: CartItemImage(
                    controller: _controller2,
                    sizeAnimation: _sizeAnim,
                    colorAnimation: _colorAnima,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setBoxInitialPoint() {
    _leftPoint = (context.screenWidth / 2) - 75;
    _topPoint = context.screenHeight * .25;
    _startLeftPoint = _leftPoint;
    _startTopPoint = _topPoint;
  }

  void _setTargentPoint() {
    _targetLeftTop =
        Offset(context.screenWidth - 380, context.screenHeight - 380);
    _targetBottomRight = Offset(context.screenWidth, context.screenHeight - 20);
  }

  void _boxAnimObDragAccepted() {
    _leftPoint = lerpDouble(
        _leftPoint, (_targetBottomRight.dx - 130).abs(), _boxAcceptAnim.value)!;
    _topPoint = lerpDouble(
        _topPoint, (_targetBottomRight.dy - 140).abs(), _boxAcceptAnim.value)!;
    final currentOffset =
        (_myWidgetKey.currentContext!.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero);
    _findDifference(Offset(currentOffset.dx, currentOffset.dy + 20));
  }

  void _onPanEnd(DragEndDetails details) async {
    if (_percent < 1) {
      await _controller.forward(from: 0.0);
      _count++;
    }
    _setBoxInitialPoint();
    setState(() => _percent = 1);
  }

  void _findDifference(Offset currentPoint) {
    Offset differnece = currentPoint - _targetLeftTop;
    differnece = Offset(differnece.dx.abs(), differnece.dy.abs());
    _percent = MyDimens().getDistancePercentage(
      point: currentPoint,
      leftTop: _targetLeftTop,
      bottomRight: _targetBottomRight,
    );
  }

  void _onColorTap(int i) {
    _previousColor = _selectedColor;
    _selectedColor = i;
    _colorAnima = ColorTween(
      begin: MyConstant.colors[_previousColor],
      end: MyConstant.colors[_selectedColor],
    ).animate(curve);
    setState(() {});
    _controller2.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
