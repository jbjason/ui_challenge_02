import 'package:flutter/material.dart';
import 'package:ui_challenge_02/screens/drag_test_screen.dart';
import 'package:ui_challenge_02/screens/home_screen.dart';
import 'dart:math';

void main() {
  Offset center = Offset(100, 100);
  Offset corner = Offset(150, 150); // Using bottom-right corner
  Offset point = Offset(75, 90);

  double percentage = getDistancePercentage(point, center, corner);
  print('The point is ${percentage.toStringAsFixed(2)}% from the center');
  // Output: The point is 38.09% from the center

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DragTestScreen(),
    );
  }
}

double getDistancePercentage(Offset point, Offset center, Offset corner) {
  // Calculate actual distance from center to point
  double dxPoint = point.dx - center.dx;
  double dyPoint = point.dy - center.dy;
  double actualDistance = sqrt(dxPoint * dxPoint + dyPoint * dyPoint);

  // Calculate maximum possible distance (center to corner)
  double dxMax = corner.dx - center.dx;
  double dyMax = corner.dy - center.dy;
  double maxDistance = sqrt(dxMax * dxMax + dyMax * dyMax);

  // Return percentage
  return (actualDistance / maxDistance) * 100;
}
