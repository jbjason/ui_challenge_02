import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';
import 'package:ui_challenge_02/constant/my_dimens.dart';
import 'package:ui_challenge_02/constant/my_image.dart';
import 'package:ui_challenge_02/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jb Jason's Transaction",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    "Flutter Dev",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: size.height * .3,
                    width: size.width,
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
                        SizedBox(
                          height: size.height * .25,
                          child: Row(children: [
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
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: size.height * .15,
            bottom: size.height * .35,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartScreen()),
                );
              },
              child: Hero(
                tag: Key("hero-tag12"),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: MyColor.primaryColor,
                    borderRadius: BorderRadius.circular(17),
                    image: DecorationImage(
                      image: AssetImage(MyImage.galaxyImg),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        MyConstant.circularIconTitles.length,
                        (i) => MyDimens().getCircularItem(
                          MyConstant.circularIconTitles[i],
                          MyConstant.circularIcons[i],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
