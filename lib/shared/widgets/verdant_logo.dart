import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

/// Geometric leaf: three angled lines meeting at a point.
class VerdantLogo extends StatelessWidget {
  const VerdantLogo({
    super.key,
    this.size = 48,
    this.color = kPrimaryGreen,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _VerdantLeafPainter(color: color),
    );
  }
}

class _VerdantLeafPainter extends CustomPainter {
  _VerdantLeafPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.shortestSide * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.miter
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;
    final tip = Offset(w * 0.55, h * 0.12);
    final left = Offset(w * 0.15, h * 0.88);
    final right = Offset(w * 0.92, h * 0.62);
    final mid = Offset(w * 0.42, h * 0.48);

    final p1 = Path()..moveTo(tip.dx, tip.dy)..lineTo(mid.dx, mid.dy);
    final p2 = Path()..moveTo(left.dx, left.dy)..lineTo(mid.dx, mid.dy);
    final p3 = Path()..moveTo(right.dx, right.dy)..lineTo(mid.dx, mid.dy);

    canvas.drawPath(p1, paint);
    canvas.drawPath(p2, paint);
    canvas.drawPath(p3, paint);

    canvas.drawCircle(mid, size.shortestSide * 0.05, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _VerdantLeafPainter oldDelegate) =>
      oldDelegate.color != color;
}
