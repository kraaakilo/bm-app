import 'dart:math';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double paidBills;
  final double unpaidBills;
  final double totalBills;
  final double radius;

  CirclePainter({
    this.radius = 70,
    this.paidBills = 0,
    this.unpaidBills = 0,
    this.totalBills = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint grayPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;

    Paint bluePaint = Paint()
      ..color = const Color(0xFF0AE1A0)
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;

    Paint redPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;

    if (unpaidBills > 0 || paidBills > 0) {
      double totalCircumference = 2 * pi * radius;
      double unpaidBillsArcLength =
          (unpaidBills / totalBills) * totalCircumference;
      double paidBillsArcLength = (paidBills / totalBills) * totalCircumference;

      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        -pi / 2,
        unpaidBillsArcLength / radius,
        false,
        redPaint,
      );

      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        -pi / 2 + unpaidBillsArcLength / radius,
        paidBillsArcLength / radius,
        false,
        bluePaint,
      );
    } else {
      // Draw a grey circle when both unpaidBills and paidBills are zero
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        radius,
        grayPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
