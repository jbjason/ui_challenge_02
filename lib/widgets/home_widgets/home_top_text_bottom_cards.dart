import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenge_02/constant/media_extension.dart';
import 'package:ui_challenge_02/constant/my_image.dart';

class HomeTopTextBottomCards extends StatelessWidget {
  const HomeTopTextBottomCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top texts
            Text("Jb Jason Decoration",
                style: GoogleFonts.lora(
                    fontSize: 30, fontWeight: FontWeight.bold)),
            Text("App Developer", style: GoogleFonts.oswald(fontSize: 20)),
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
                              color: Colors.purple[100],
                            ),
                            child: Image.asset(MyImage.boxImage(0)),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.deepPurple[50],
                            ),
                            child: Image.asset(MyImage.boxImage(1)),
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
    );
  }
}
