import 'package:flutter/material.dart';

abstract class MyConstant {
  static const String font1 = "Casab";
  static const String font2 = "Script";
  static const String font3 = "Vinque";

  static const duration = Duration(milliseconds: 2000);
  static const List<String> circularIconTitles = [
    "Kitchen",
    "Bedroom",
    "Sofa",
    "Icebox",
    "Sports"
  ];

  static const List<IconData> circularIcons = [
    Icons.kitchen_outlined,
    Icons.bed_outlined,
    Icons.soap_outlined,
    Icons.ice_skating_outlined,
    Icons.sports_outlined,
  ];

  static const List<Color> colors = [
    Colors.blue,
    Colors.yellow,
    Colors.greenAccent,
  ];
}
