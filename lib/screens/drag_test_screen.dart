import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';
import 'package:ui_challenge_02/constant/my_image.dart';

class DragTestScreen extends StatefulWidget {
  const DragTestScreen({super.key});
  @override
  State<DragTestScreen> createState() => _DragTestScreenState();
}

class _DragTestScreenState extends State<DragTestScreen> {
  double _percent = 0.0, _test = 0;
  Offset _currentPoint = Offset(0, 0),
      _targetCenter = Offset(0, 0),
      _targetRightCorner = Offset(150, 150);

  final GlobalKey<_ScalingFeedbackWidgetState> _feedbackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _targetCenter =
            Offset(context.screenWidth - 75, context.screenHeight - 75);
        _targetRightCorner = Offset(context.screenWidth, context.screenHeight);

        print("center : $_targetCenter");
        print("center : $_targetRightCorner");
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
          Draggable(
            data: 10,
            // 4. Pass the key and initial parameters to the feedback widget.
            feedback: ScalingFeedbackWidget(
              key: _feedbackKey,
              scale: _percent,
              child: Image.asset(MyImage.boxImg, width: 170, height: 170),
            ),
            // childWhenDragging: Column(
            //   children: [
            //     Image.asset(MyImage.boxImg, width: 170, height: 170),
            //     Text("Box 0"),
            //   ],
            // ),
            child: Column(
              children: [
                Image.asset(MyImage.boxImg, width: 170, height: 170),
                Text("Box 0"),
              ],
            ),
          ),

          // SingleChildScrollView(
          //   physics: NeverScrollableScrollPhysics(),
          //   child: Column(
          //     spacing: 20,
          //     children:
          //  List.generate(
          //   6,
          //   (i) =>
          // Draggable(
          //   feedback: ScalingFeedbackWidget(
          //     key: _feedbackKey,
          //     scale: 1 + _test,
          //     child: Image.asset(MyImage.boxImg, width: 170, height: 170),
          //   ),
          //   child: Column(
          //     children: [
          //       Image.asset(MyImage.boxImg, width: 170, height: 170),
          //       Text("Box 0"),
          //     ],
          //   ),
          //   onDragUpdate: (details) {
          //     _currentPoint = details.localPosition;
          //     _test += .0005;
          //     setState(() {});
          //     // print(
          //     //     "dx ${details.localPosition.dx.toStringAsFixed(3)} <---> dy ${details.localPosition.dy.toStringAsFixed(3)}");
          //   },
          // ),
          //     ),
          //   ),
          // ),
          Positioned(
            right: 0,
            bottom: 0,
            height: 150,
            width: 150,
            child: DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  constraints: BoxConstraints.expand(),
                  color: Colors.grey.shade300,
                  child: Center(child: Icon(Icons.badge)),
                );
              },
              onMove: (details) {
                // print(
                //     "dx ${details.offset.dx.toStringAsPrecision(3)} <---> dy ${details.offset.dy.toStringAsFixed(3)}");
                // Offset center = Offset(100, 100);
                // Offset corner = Offset(150, 150); // Using bottom-right corner
                // Offset point = Offset(75, 75);

                _percent = MyDimens().getDistancePercentage(
                  currentpoint: _currentPoint,
                  center: _targetCenter,
                  rightCorner: _targetRightCorner,
                );
                _test += .0005;
                setState(() {});

                _feedbackKey.currentState?.updateScale(_percent);
                print(
                    'current Point from ${_percent.toStringAsFixed(2)}% center');
              },
              onAcceptWithDetails: (DragTargetDetails<int> details) {},
            ),
          ),
        ],
      ),
    );
  }
}

class ScalingFeedbackWidget extends StatefulWidget {
  final double scale; // The dynamic value you want to update
  final Widget child; // Your child widget

  const ScalingFeedbackWidget({
    super.key,
    required this.scale,
    required this.child,
  });

  @override
  State<ScalingFeedbackWidget> createState() => _ScalingFeedbackWidgetState();
}

class _ScalingFeedbackWidgetState extends State<ScalingFeedbackWidget> {
  // 2. A method to update the state from the outside.
  void updateScale(double newScale) {
    setState(() {
      // This will trigger a rebuild of this specific StatefulWidget.
    });
    // If you need to store the new value, you would manage state internally
    // or use a state management solution to get the latest value.
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale, // This will be rebuilt when updateScale is called.
      child: widget.child,
    );
  }
}
