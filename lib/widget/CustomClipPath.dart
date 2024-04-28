import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height - 40);

    final firstCurve = Offset(size.width - 30, size.height);
    final lastCurve = Offset(30, size.height);
    path.quadraticBezierTo(size.width, size.height - 40, firstCurve.dx, firstCurve.dy);
    path.quadraticBezierTo(size.width / 2, size.height, lastCurve.dx, lastCurve.dy);
    path.quadraticBezierTo(0, size.height - 40, lastCurve.dx, lastCurve.dy);

    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
class CustomPainterExample extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 50);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
