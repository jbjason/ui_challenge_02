// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
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
  double _leftPoint = 0.0, _topPoint = 0.0, _percent = 1;
  Offset _targetCenter = Offset(0, 0);
  Offset _currentPoint = Offset(0, 0), _targetRightCorner = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _targetCenter =
            Offset(context.screenWidth - 100, context.screenHeight - 100);
        _targetRightCorner = Offset(context.screenWidth, context.screenHeight);
        _leftPoint = (context.screenWidth / 2) - 100;
        setState(() {});
      },
    );

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _controller.addListener(() {
      print("----------${_controller.value}-------------");
      _leftPoint = lerpDouble(
          _leftPoint, (_targetRightCorner.dx -100).abs(), _controller.value)!;
      _topPoint = lerpDouble(
          _topPoint, (_targetRightCorner.dy-100).abs(), _controller.value)!;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("Size: ${context.screenHeight}  -- ${context.screenWidth}");
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
            child: Container(color: Colors.red),
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
                _topPoint = _currentPoint.dy - 70;

                //  print("left: $_leftPoint. top: $_topPoint");

                Offset differnece = _currentPoint - _targetCenter;
                differnece = Offset(differnece.dx.abs(), differnece.dy.abs());
                if (differnece.dx <= 60 || differnece.dy <= 60) {
                  _percent = MyDimens().getDistancePercentage(
                    currentpoint: _currentPoint,
                    center: _targetCenter,
                    rightCorner: _targetRightCorner,
                  );
                  _printPerncet(_targetCenter, differnece);
                } else {
                  _percent = 1;
                }
                setState(() {});
              },
              child: Container(
                color: Colors.amber,
                child: Transform.scale(
                  scale: _percent.clamp(0, 1),
                  child: Image.asset(MyImage.boxImg),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPanEnd(DragEndDetails details) async {
    if (_percent < 1) {
      print("its coming--------------------here----------");
      await _controller.forward(from: 0.0);

      Future.delayed(Duration());
    }
    _topPoint = 0.0;
    _leftPoint = (context.screenWidth / 2) - 80;
    setState(() => _percent = 1);
  }

  void _printPerncet(Offset center, Offset difference) {
    Logger().w("""percent = $_percent. 
       Current(${_currentPoint.dx.toStringAsFixed(2)},${_currentPoint.dy.toStringAsFixed(2)})   Center(${center.dx.toStringAsFixed(2)},${center.dy.toStringAsFixed(2)}) 
       Differnce(${difference.dx.toStringAsFixed(2)},${difference.dy.toStringAsFixed(2)})""");
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