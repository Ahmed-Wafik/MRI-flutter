import 'package:flutter/material.dart';

class OvalBottomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
  final double height =35;
   path.lineTo(0, size.height - height);
      //Adds a quadratic bezier segment that curves from the current point
      //to the given point (x2,y2), using the control point (x1,y1).
      path.quadraticBezierTo(
          size.width / 4, size.height, size.width / 2, size.height);
      path.quadraticBezierTo(
          size.width * 3 / 4, size.height, size.width, size.height - height);

      path.lineTo(size.width, 0.0);
      path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}
