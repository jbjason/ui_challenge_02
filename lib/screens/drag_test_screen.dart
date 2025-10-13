// ignore_for_file: use_build_context_synchronously
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';
import 'package:ui_challenge_02/constant/my_image.dart';

class DragTestScreen extends StatefulWidget {
  const DragTestScreen({super.key});
  @override
  State<DragTestScreen> createState() => _DragTestScreenState();
}

class _DragTestScreenState extends State<DragTestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _boxAcceptAnim;
  double _leftPoint = 0.0, _topPoint = 0.0, _percent = 1;
  Offset _targetCenter = Offset(0, 0);
  Offset _currentPoint = Offset(0, 0), _targetRightCorner = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _controller =
        AnimationController(vsync: this, duration: MyConstant.duration);
    _boxAcceptAnim =
        CurvedAnimation(curve: Interval(0.0, 0.8), parent: _controller);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        _setBoxInitialPoint();
        _setTargentPoint();
      }),
    );
    _controller.addListener(() => setState(() => _boxAnimObDragAccepted()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Drag Test"), backgroundColor: Colors.deepPurple),
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
            left: _leftPoint,
            top: _topPoint,
            width: 140,
            height: 140,
            child: GestureDetector(
              onPanEnd: _onPanEnd,
              onPanUpdate: (details) {
                _currentPoint = details.localPosition;
                _leftPoint = _currentPoint.dx;
                _topPoint = _currentPoint.dy + 20;
                //  print("left: $_leftPoint. top: $_topPoint");
                _findDifference(_currentPoint);
                setState(() {});
              },
              child: Transform.scale(
                scale: _percent.clamp(0, 1),
                child: Container(
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
    _targetCenter =
        Offset(context.screenWidth - 150, context.screenHeight - 150);
    _targetRightCorner = Offset(context.screenWidth, context.screenHeight);
  }

  void _boxAnimObDragAccepted() {
    _leftPoint =
        lerpDouble(_leftPoint, _targetCenter.dx, _boxAcceptAnim.value)!;
    _topPoint = lerpDouble(
        _topPoint, (_targetCenter.dy - 75).abs(), _boxAcceptAnim.value)!;
    _findDifference(Offset(_leftPoint, _topPoint + 70));
  }

  void _onPanEnd(DragEndDetails details) async {
    if (_percent < 1) {
      await _controller.forward(from: 0.0);
      Future.delayed(Duration());
    }
    _setBoxInitialPoint();
    setState(() => _percent = 1);
  }

  void _findDifference(Offset currentPoint) {
    Offset differnece = currentPoint - _targetCenter;
    differnece = Offset(differnece.dx.abs(), differnece.dy.abs());
    //if (differnece.dy <= 150 ) {
    _percent = MyDimens().getDistancePercentage(
      currentpoint: currentPoint,
      center: _targetCenter,
      rightCorner: _targetRightCorner,
    );
    Logger().w("""percent = $_percent. 
       Current(${currentPoint.dx.toStringAsFixed(2)},${currentPoint.dy.toStringAsFixed(2)})   Center(${_targetCenter.dx.toStringAsFixed(2)},${_targetCenter.dy.toStringAsFixed(2)}) 
       Differnce(${differnece.dx.toStringAsFixed(2)},${differnece.dy.toStringAsFixed(2)})""");
    // } else {
    //   _percent = 1;
    // }
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
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
          //         center: _targetCenter,
          //         rightCorner: _targetRightCorner,
          //       );
          //       _test += .0005;
          //       setState(() {});
          //       print(
          //           'current Point from ${_percent.toStringAsFixed(2)}% center');
          //     },
          //     onAcceptWithDetails: (DragTargetDetails<int> details) {},
          //   ),
          // ),