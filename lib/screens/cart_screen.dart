import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';
import 'package:ui_challenge_02/constant/my_image.dart';
import 'package:ui_challenge_02/widgets/cart_widgets/cart_item_image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  final GlobalKey _myWidgetKey = GlobalKey();
  late AnimationController _controller, _controller2;
  late Animation<double> _boxAcceptAnim;
  late Animation<Color?> _colorAnimation;
  late Animation<double?> _sizeAnimation;
  late Animation<double> curve;
  double _leftPoint = 0.0, _topPoint = 0.0, _percent = 1;
  double _startLeftPoint = 0.0, _startTopPoint = 0.0;
  Offset _targetLeftTop = Offset(0, 0), _targetBottomRight = Offset(0, 0);
  Offset _currentPoint = Offset(0, 0);
  int _previousColor = 0, _selectedColor = 0;

  @override
  void initState() {
    super.initState();
    _initController1();
    _initController2();
  }

  void _initController1() {
    _controller =
        AnimationController(vsync: this, duration: MyConstant.duration);
    _boxAcceptAnim =
        CurvedAnimation(curve: Interval(0, .5), parent: _controller);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        _setBoxInitialPoint();
        _setTargentPoint();
      }),
    );
    _controller.addListener(() => _listener());
  }

  void _initController2() {
    _controller2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    curve = CurvedAnimation(parent: _controller2, curve: Curves.slowMiddle);
    _colorAnimation =
        ColorTween(begin: MyConstant.colors[0], end: MyConstant.colors[0])
            .animate(curve);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
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
          Container(
            padding: EdgeInsets.only(top: 56),
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
          // bottom colorful cart icon
          Positioned(
            bottom: 10,
            right: 10,
            child: Transform.scale(
              scale: 1 + .5 * (1 - _percent.clamp(0, 1)),
              child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      tileMode: TileMode.clamp,
                      transform: GradientRotation(
                          20 * (1 - _percent.clamp(0, 1)) * _controller.value),
                      colors: [
                        Colors.deepOrange,
                        Colors.yellow,
                        Colors.yellow,
                        Colors.deepPurple,
                        Colors.deepPurple,
                        Colors.deepOrange,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        color: Colors.grey,
                        spreadRadius: 2,
                        offset: Offset(5, 10),
                      )
                    ],
                  ),
                  child: _percent < .5
                      ? Image.asset(MyImage.bagOpenImg, width: 45)
                      : Icon(CupertinoIcons.bag_fill,
                          color: Colors.white, size: 45)),
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: context.screenWidth,
                height: context.screenHeight * .5,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // image on back --> not draggable
                    Positioned(
                      left: _startLeftPoint,
                      top: _startTopPoint,
                      child: CartItemImage(
                        controller: _controller2,
                        sizeAnimation: _sizeAnimation,
                        colorAnimation: _colorAnimation,
                      ),
                    ),
                    // Draggable image on front
                    Positioned(
                      left: _leftPoint,
                      top: _topPoint,
                      width: 180,
                      height: 180,
                      child: GestureDetector(
                        onPanEnd: _onPanEnd,
                        onPanUpdate: (details) {
                          _currentPoint = details.localPosition;
                          _leftPoint = _currentPoint.dx + 60;
                          _topPoint = _currentPoint.dy + 60;
                          _findDifference(_currentPoint);
                          setState(() {});
                        },
                        child: Transform.scale(
                          scale: _percent.clamp(0, 1),
                          child: Container(
                            key: _myWidgetKey,
                            child: Image.asset(
                              MyImage.boxImg,
                              color: MyConstant.colors[_selectedColor],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Bonsai Plant ABC",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: MyConstant.font1,
                ),
              ),
              Text(
                "Bonsai Plant ABC",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontFamily: MyConstant.font1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "\$ 124",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: MyConstant.font1,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: List.generate(
                  MyConstant.colors.length,
                  (i) => InkWell(
                    onTap: () async {
                      _previousColor = _selectedColor;
                      _selectedColor = i;
                      _colorAnimation = ColorTween(
                        begin: MyConstant.colors[_previousColor],
                        end: MyConstant.colors[_selectedColor],
                      ).animate(curve);
                      setState(() {});
                      _controller2.forward(from: 0.0);
                    },
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedColor == i
                            ? MyConstant.colors[i]
                            : Colors.transparent,
                      ),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 10, backgroundColor: MyConstant.colors[i]),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {}, child: Text("Add to Cart")),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.primaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: MyConstant.font1),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        ),
      );

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
    if (_percent < 1) await _controller.forward(from: 0.0);
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

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
