import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_image.dart';

class DragTestScreen extends StatefulWidget {
  const DragTestScreen({super.key});
  @override
  State<DragTestScreen> createState() => _DragTestScreenState();
}

class _DragTestScreenState extends State<DragTestScreen> {
  int acceptedData = 0;
  Offset? targetCenter = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => targetCenter =
          Offset(context.screenWidth - 50, context.screenHeight - 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Size: ${context.screenHeight}  -- ${context.screenWidth}");
    return Scaffold(
      appBar:
          AppBar(title: Text("Drag Test"), backgroundColor: Colors.deepPurple),
      body: Stack(
        children: [
          Column(
            spacing: 20,
            children: List.generate(
              3,
              (i) => Draggable(
                key: Key("Draggable-0$i"),
                data: 10,
                feedback: Image.asset(MyImage.boxImg, width: 200, height: 200),
                child: Column(
                  children: [
                    Image.asset(MyImage.boxImg, width: 200, height: 200),
                    Text("box --00 $i"),
                  ],
                ),
                onDragUpdate: (details) {
                  // print(
                  //     "dx ${details.delta.dx.toStringAsFixed(3)} <---> dy ${details.delta.dy.toStringAsFixed(3)}");
                },
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            height: 100,
            width: 100,
            child: DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  constraints: BoxConstraints.expand(),
                  color: Colors.grey.shade100,
                  child: Center(child: Icon(Icons.badge)),
                );
              },
              onMove: (details) {
                print(
                    "dx ${details.offset.dx.toStringAsPrecision(3)} <---> dy ${details.offset.dy.toStringAsFixed(3)}");
                
              },
              onAcceptWithDetails: (DragTargetDetails<int> details) {
                setState(() {
                  acceptedData += details.data;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
