import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math.dart';

class ScoreLinearProgress extends CustomPainter {
  const ScoreLinearProgress(
      {required this.backColor,
      required this.frontColor,
      required this.strokeWidth,
      required this.value});
  final Color backColor, frontColor;
  final double strokeWidth, value;

  @override
  void paint(Canvas canvas, Size size) {
    final w = 190;
    final h = 100;
    final paint1 = Paint()
      ..strokeWidth = strokeWidth
      ..color = backColor
      //..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;//termina il bordo tondo
    final paint2 = Paint()
      ..strokeWidth = strokeWidth
      ..color = frontColor
      //..style = PaintingStyle.fill//rettangolo pieno
      ..strokeCap = StrokeCap.round;
    Offset startPoint = Offset(0, h / 2);
    Offset endPoint = Offset(w as double , h / 2);
    canvas.drawLine(startPoint,endPoint, paint1);
    Offset startPoint2 = Offset(0, h / 2);
    Offset endPoint2 = Offset(w * value / 100, h / 2);
    canvas.drawLine(startPoint2,endPoint2, paint2);
    final r =Rect.fromPoints(startPoint,endPoint);
    canvas.drawRect(r, paint2);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}