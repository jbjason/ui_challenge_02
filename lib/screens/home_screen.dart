import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/widgets/cart_widgets/cart_blue_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _blueBoxAnim, _lisItemAnim, _whiteCardAnim;
  final List<Animation<double>> _listItemAnimationList = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _blueBoxAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.1, .5));
    _lisItemAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.2, .9));
    _whiteCardAnim =
        CurvedAnimation(parent: _controller, curve: const Interval(.5, .9));

    final int length = MyConstant.circularIcons.length;
    final intervalPerItem = 1 / length;
    for (int i = 0; i < length; i++) {
      _listItemAnimationList.add(
        CurvedAnimation(
          parent: _lisItemAnim,
          curve: Interval(
            i * intervalPerItem + .0, // starting interval
            (i + 1) * intervalPerItem + .0, // ending interval
            curve: Curves.bounceIn,
          ),
          // interval for 5 items  0 =(0,.2), 1=(.2,.4)......(.8,1)
        ),
      );
    }
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // top texts
                  Text(
                    "Jb Jason's Transaction",
                    style: TextStyle(
                      fontSize: 30,fontFamily: "Vinque"
                    )
                  ),
                  Text(
                    "Flutter Dev", style: TextStyle(
                      fontSize: 20,fontFamily: "Vinque"
                    )
                  ),
                  // spacer --> we r using spacer to but blue-box with the help of Stack()å 
                  const Spacer(),
                  // bottom list
                  SizedBox(
                    height: context.screenHeight * .25,
                    width: context.screenWidth,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Recommend"),
                            Icon(Icons.arrow_back_ios_new)
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.purple[50],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.deepPurple[50],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // blue box
          CartBlueBox(
            blueBoxAnim: _blueBoxAnim,
            listItemAnimationList: _listItemAnimationList,
            controller: _controller,
          ),
          // white bottom containter
          _getWhiteCard
        ],
      ),
    );
  }

  Positioned get _getWhiteCard => Positioned(
        left: 0,
        right: 0,
        bottom: (-context.screenHeight * .8) * (1 - _whiteCardAnim.value),
        height: context.screenHeight * .8,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [],
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
