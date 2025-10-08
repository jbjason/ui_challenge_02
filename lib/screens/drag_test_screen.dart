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

class _DragTestScreenState extends State<DragTestScreen> {
  double _leftPoint = 0.0, _topPoint = 0.0, _percent = 1;
  Offset _targetCenter = Offset(0, 0);
  Offset _currentPoint = Offset(0, 0), _targetRightCorner = Offset(150, 150);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _targetCenter =
            Offset(context.screenWidth - 80, context.screenHeight - 80);
        _targetRightCorner = Offset(context.screenWidth, context.screenHeight);
        // print("center : $_targetCenter");
        // print("center : $_targetRightCorner");
        _leftPoint = (context.screenWidth / 2) - 80;
        setState(() {});
      },
    );
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
            left: _leftPoint,
            top: _topPoint,
            width: 160,
            height: 160,
            child: GestureDetector(
              onPanEnd: (details) {
                _topPoint = 0.0;
                _leftPoint = (context.screenWidth / 2) - 80;
                setState(() => _percent = 1);
              },
              onPanCancel: () {
                _topPoint = 0.0;
                _leftPoint = (context.screenWidth / 2) - 80;
                setState(() => _percent = 1);
              },
              onPanUpdate: (details) {
                _currentPoint = details.localPosition;
                //-80 bcz details.localPosition gives center offset
                _leftPoint = (_currentPoint.dx - 80).abs();
                _topPoint = (_currentPoint.dy - 80).abs();
                //print("left: $_leftPoint. top: $_topPoint");
                Offset differnece = _currentPoint - _targetCenter;
                differnece = Offset(differnece.dx.abs(), differnece.dy.abs());
                if (differnece.dx <= 40 || differnece.dy <= 40) {
                  _percent = MyDimens().getDistancePercentage(
                    currentpoint: _currentPoint,
                    center: _targetCenter,
                    rightCorner: _targetRightCorner,
                  );
                  _printPerncet(_targetCenter, differnece);
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
        ],
      ),
    );
  }

  void _printPerncet(Offset center, Offset difference) {
    Logger().w("""percent = $_percent. 
       Current(${_currentPoint.dx.toStringAsFixed(2)},${_currentPoint.dy.toStringAsFixed(2)})   Center(${center.dx.toStringAsFixed(2)},${center.dy.toStringAsFixed(2)}) 
       Differnce(${difference.dx.toStringAsFixed(2)},${difference.dy.toStringAsFixed(2)})""");
  }
}
