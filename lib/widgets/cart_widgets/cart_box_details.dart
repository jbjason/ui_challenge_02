import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenge_02/constant/my_color.dart';
import 'package:ui_challenge_02/constant/my_constant.dart';

class CartBoxDetails extends StatelessWidget {
  const CartBoxDetails(
      {super.key, required this.selectedColor, required this.onTap});
  final int selectedColor;
  final Function(int i) onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Bonsai Plant",
          style: GoogleFonts.lora(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Text(
          "Footstool with stodrage. Ransta",
          style: GoogleFonts.lora(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "\$ 124",
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: List.generate(
            MyConstant.colors.length,
            (i) => InkWell(
              onTap: () => onTap(i),
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedColor == i
                      ? MyConstant.colors[i]
                      : Colors.transparent,
                ),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 10, backgroundColor: MyConstant.colors[i]),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: () {}, child: Text("Add to Cart")),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyColor.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
              child: Text(
                "Buy Now",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontFamily: MyConstant.font3),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
