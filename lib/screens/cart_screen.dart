import 'dart:ui';
import 'package:flutter/cupertino.dart';
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
  final GlobalKey _myWidgetKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _boxAcceptAnim;
  double _leftPoint = 0.0, _topPoint = 0.0, _percent = 1;
  double _startLeftPoint = 0.0, _startTopPoint = 0.0;
  Offset _targetLeftTop = Offset(0, 0), _targetBottomRight = Offset(0, 0);
  Offset _currentPoint = Offset(0, 0);
  int _selectedColor = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
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

  void _listener() => setState(() => _boxAnimObDragAccepted());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
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
                    Positioned(
                      left: _startLeftPoint,
                      top: _startTopPoint,
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Image.asset(
                          MyImage.boxImg,
                          color: MyConstant.colors[_selectedColor],
                        ),
                      ),
                    ),
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Bonsai Plant ABC",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Text(
                "\$ 124 /=",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: List.generate(
                  MyConstant.colors.length,
                  (i) => InkWell(
                    onTap: () => setState(() => _selectedColor = i),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedColor == i
                            ? MyConstant.colors[i]
                            : Colors.transparent,
                      ),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 12, backgroundColor: MyConstant.colors[i]),
                      ),
                    ),
                  ),
                ),
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
    super.dispose();
  }
}
