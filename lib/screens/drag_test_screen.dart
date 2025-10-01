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
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              spacing: 20,
              children: List.generate(
                6,
                (i) => Draggable(
                  key: Key("Draggable-0$i"),
                  data: 10,
                  feedback: Transform.scale(
                    scale: 1 + _test,
                    child: Image.asset(MyImage.boxImg, width: 170, height: 170),
                  ),
                  child: Column(
                    children: [
                      Image.asset(MyImage.boxImg, width: 170, height: 170),
                      Text("Box 0$i"),
                    ],
                  ),
                  onDragUpdate: (details) {
                    _currentPoint = details.localPosition;
                    _test += .0005;
                    setState(() {});
                    // print(
                    //     "dx ${details.localPosition.dx.toStringAsFixed(3)} <---> dy ${details.localPosition.dy.toStringAsFixed(3)}");
                  },
                ),
              ),
            ),
          ),
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
                setState(() {});
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
