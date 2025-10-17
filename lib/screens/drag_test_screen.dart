// ignore_for_file: use_build_context_synchronously
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';
import 'package:ui_challenge_02/constant/my_image.dart';
// ignore: unused_import
import 'dart:math' as math;

class DragTestScreen extends StatefulWidget {
  const DragTestScreen({super.key});
  @override
  State<DragTestScreen> createState() => _DragTestScreenState();
}

class _DragTestScreenState extends State<DragTestScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _myWidgetKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _boxAcceptAnim;
  double _leftPoint = 0.0, _topPoint = 0.0, _percent = 1;
  Offset _targetLeftTop = Offset(0, 0), _targetBottomRight = Offset(0, 0);
  Offset _currentPoint = Offset(0, 0);

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
      appBar: AppBar(backgroundColor: Colors.deepPurple),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            height: 200,
            width: 200,
            child: Container(color: Colors.grey.shade200),
          ),
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
                    transform: GradientRotation(20 * _controller.value),
                    colors: [
                      Colors.pink,
                      Colors.deepPurple,
                      Colors.yellow,
                      Colors.pink,
                    ],
                  ),
                ),
                child: Icon(
                    _percent > .7
                        ? CupertinoIcons.bag_fill
                        : CupertinoIcons.cart_fill,
                    size: 35,
                    color: Colors.white),
              ),
            ),
          ),
          Positioned(
            left: _leftPoint,
            top: _topPoint,
            width: 120,
            height: 120,
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
                  color: Colors.amber,
                  child: Image.asset(MyImage.boxImg),
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
    _topPoint = context.screenHeight * .15;
  }

  void _setTargentPoint() {
    _targetLeftTop =
        Offset(context.screenWidth - 380, context.screenHeight - 380);
    _targetBottomRight = Offset(context.screenWidth, context.screenHeight - 20);
  }

  void _boxAnimObDragAccepted() {
    _leftPoint = lerpDouble(
        _leftPoint, (_targetBottomRight.dx - 90).abs(), _boxAcceptAnim.value )!;
    _topPoint = lerpDouble(
        _topPoint, (_targetBottomRight.dy - 160).abs(), _boxAcceptAnim.value)!;
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


 // Draggable(
          //   data: 10,
          //   // 4. Pass the key and initial parameters to the feedback widget.
          //   feedback: Image.asset(MyImage.boxImg, width: 170, height: 170),
          //   // childWhenDragging: Column(
          //   //   children: [
          //   //     Image.asset(MyImage.boxImg, width: 170, height: 170),
          //   //     Text("Box 0"),
          //   //   ],
          //   // ),
          //   child: Column(
          //     children: [
          //       Image.asset(MyImage.boxImg, width: 170, height: 170),
          //       Text("Box 0"),
          //     ],
          //   ),
          // ),
          // // SingleChildScrollView(
          // //   physics: NeverScrollableScrollPhysics(),
          // //   child: Column(
          // //     spacing: 20,
          // //     children:
          // //  List.generate(
          // //   6,
          // //   (i) =>
          // // Draggable(
          // //   feedback: ScalingFeedbackWidget(
          // //     key: _feedbackKey,
          // //     scale: 1 + _test,
          // //     child: Image.asset(MyImage.boxImg, width: 170, height: 170),
          // //   ),
          // //   child: Column(
          // //     children: [
          // //       Image.asset(MyImage.boxImg, width: 170, height: 170),
          // //       Text("Box 0"),
          // //     ],
          // //   ),
          // //   onDragUpdate: (details) {
          // //     _currentPoint = details.localPosition;
          // //     _test += .0005;
          // //     setState(() {});
          // //     // print(
          // //     //     "dx ${details.localPosition.dx.toStringAsFixed(3)} <---> dy ${details.localPosition.dy.toStringAsFixed(3)}");
          // //   },
          // // ),
          // //     ),
          // //   ),
          // // ),
          // Positioned(
          //   right: 0,
          //   bottom: 0,
          //   height: 150,
          //   width: 150,
          //   child: DragTarget<int>(
          //     builder: (
          //       BuildContext context,
          //       List<dynamic> accepted,
          //       List<dynamic> rejected,
          //     ) {
          //       return Container(
          //         constraints: BoxConstraints.expand(),
          //         color: Colors.grey.shade300,
          //         child: Center(child: Icon(Icons.badge)),
          //       );
          //     },
          //     onMove: (details) {
          //       // print(
          //       //     "dx ${details.offset.dx.toStringAsPrecision(3)} <---> dy ${details.offset.dy.toStringAsFixed(3)}");
          //       // Offset center = Offset(100, 100);
          //       // Offset corner = Offset(150, 150); // Using bottom-right corner
          //       // Offset point = Offset(75, 75);
          //       _percent = MyDimens().getDistancePercentage(
          //         currentpoint: _currentPoint,
          //         center: _targetLeftTop,
          //         rightCorner: _targetBottomRight,
          //       );
          //       _test += .0005;
          //       setState(() {});
          //       print(
          //           'current Point from ${_percent.toStringAsFixed(2)}% center');
          //     },
          //     onAcceptWithDetails: (DragTargetDetails<int> details) {},
          //   ),
          // ),