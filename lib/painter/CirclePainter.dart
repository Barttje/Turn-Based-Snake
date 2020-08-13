import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double radius;
  final Offset center;
  final Color color;
  final bool visible;
  CirclePainter(this.center, this.radius, this.color, this.visible);

  @override
  void paint(Canvas canvas, Size size) {
    if (this.visible) {
      Paint paint = Paint()..color = color;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.center != center || oldDelegate.visible != visible;
  }

  @override
  bool hitTest(Offset position) {
    final Path path = new Path();
    path.addRect(Rect.fromCircle(center: center, radius: radius));
    return path.contains(position);
  }
}
