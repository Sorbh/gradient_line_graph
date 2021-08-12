import 'package:flutter/material.dart';

extension PathExtension on Path {
  void moveToOffset(Offset offset) => moveTo(offset.dx, offset.dy);
  void lineToOffset(Offset offset) => lineTo(offset.dx, offset.dy);
}

extension CanvasExtension on Canvas {
  drawGlowingPath(Path path, Paint paint,
      {int shadowSpread = 6, int spreadValue = 10}) {
    List shadows = [];
    for (var i = 1; i <= shadowSpread; i++) {
      var shadow = Paint()
        ..color = paint.color
        ..strokeWidth = paint.strokeWidth
        ..style = paint.style
        ..maskFilter = MaskFilter.blur(
            BlurStyle.outer,
            ((i * spreadValue).toDouble()) * 0.57735 +
                0.5) //convertRadiusToSigma
        ..strokeCap = paint.strokeCap;
      shadows.add(shadow);
    }

    shadows.forEach((element) {
      drawPath(path, element);
    });

    drawPath(path, paint);
  }

  drawGlowingCircle(Offset c, double radius, Paint paint,
      {int shadowSpread = 6, int spreadValue = 10}) {
    List shadows = [];
    for (var i = 1; i <= shadowSpread; i++) {
      var shadow = Paint()
        ..color = paint.color
        ..strokeWidth = paint.strokeWidth
        ..style = paint.style
        ..maskFilter = MaskFilter.blur(
            BlurStyle.outer,
            ((i * spreadValue).toDouble()) * 0.57735 +
                0.5) //convertRadiusToSigma
        ..strokeCap = paint.strokeCap;
      shadows.add(shadow);
    }

    shadows.forEach((element) {
      drawCircle(c, radius, element);
    });

    drawCircle(c, radius, paint);
  }
}
