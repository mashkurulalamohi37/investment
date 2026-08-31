import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';

/// Institutional Brass Seal (§7 of Khatian Specification)
/// Concentric brass rings, radial guilloche teeth, and engraved stamp legend.
class SealWidget extends StatelessWidget {
  final double size;
  final bool isBangla;

  const SealWidget({
    super.key,
    this.size = 44.0,
    this.isBangla = true,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return CustomPaint(
      size: Size(size, size),
      painter: _SealPainter(
        color: palette.brass,
        lightColor: palette.brassLight,
        isBangla: isBangla,
        size: size,
      ),
    );
  }
}

class _SealPainter extends CustomPainter {
  final Color color;
  final Color lightColor;
  final bool isBangla;
  final double size;

  _SealPainter({
    required this.color,
    required this.lightColor,
    required this.isBangla,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final center = Offset(canvasSize.width / 2, canvasSize.height / 2);
    final radius = canvasSize.width / 2;

    // Outer Ring
    final outerRingPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size >= 96 ? 2.0 : 1.2;
    canvas.drawCircle(center, radius - 1, outerRingPaint);

    // Inner Hairline Ring
    final innerRingPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;
    canvas.drawCircle(center, radius * 0.76, innerRingPaint);

    // Fine Radial Guilloche Teeth
    final teethCount = size >= 96 ? 48 : (size >= 44 ? 28 : 16);
    final toothPaint = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    for (int i = 0; i < teethCount; i++) {
      final angle = (i * 2 * math.pi) / teethCount;
      final outerX = center.dx + (radius - 1.5) * math.cos(angle);
      final outerY = center.dy + (radius - 1.5) * math.sin(angle);
      final innerX = center.dx + (radius * 0.76) * math.cos(angle);
      final innerY = center.dy + (radius * 0.76) * math.sin(angle);
      canvas.drawLine(Offset(innerX, innerY), Offset(outerX, outerY), toothPaint);
    }

    // Center Emblem or Text based on size
    if (size >= 44) {
      final textSpan = TextSpan(
        text: size >= 96 ? (isBangla ? 'যাচাইকৃত\nVERIFIED' : 'VERIFIED\nREGISTRY') : (isBangla ? 'যাচাই' : 'SEAL'),
        style: TextStyle(
          color: color,
          fontSize: size >= 96 ? 11 : 8.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
          letterSpacing: 0.5,
          height: 1.15,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: radius * 1.3);

      textPainter.paint(
        canvas,
        Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
      );
    } else {
      // Small 20px inline seal: center dot and inner disc
      final centerPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, 2.5, centerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SealPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.size != size || oldDelegate.isBangla != isBangla;
  }
}
