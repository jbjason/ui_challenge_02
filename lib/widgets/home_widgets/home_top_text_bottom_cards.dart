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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Row(
              spacing: 20,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(MyImage.galaxyImg),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // top texts
                      Text("Good Morning Jb",
                          style: GoogleFonts.lora(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      Text("Mobile App Developer",
                          style: GoogleFonts.oswald(fontSize: 20,fontWeight: FontWeight.bold)),
                      // spacer --> we r using spacer to but blue-box with the help of Stack()å
                    ],
                  ),
                ),
              ],
            ),
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
                      Text("Recommend",
                          style: GoogleFonts.lora(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 20,
                        children: List.generate(
                          5,
                          (i) => Container(
                            width: context.screenWidth * .45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: i.isOdd
                                  ? Colors.purple[100]
                                  : Colors.deepPurple[50],
                            ),
                            child: Image.asset(MyImage.boxImage(i),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ),
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
