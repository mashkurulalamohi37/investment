import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Lissajous Rosette Watermark (§7 of Khatian Specification)
/// Mathematical rosette at 0.6px stroke in brass at 22% opacity for share certificates.
class GuillocheWidget extends StatelessWidget {
  final double size;
  final Color color;

  const GuillocheWidget({
    super.key,
    this.size = 180.0,
    this.color = const Color(0xFF8F7328),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GuillochePainter(color: color),
    );
  }
}

class _GuillochePainter extends CustomPainter {
  final Color color;

  _GuillochePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    final paint = Paint()
      ..color = color.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    const points = 360;
    const a = 5;
    const b = 6;

    final path = Path();
    for (int i = 0; i <= points; i++) {
      final theta = (i * 2 * math.pi) / points;
      final r = (maxRadius * 0.9) * (0.6 + 0.4 * math.sin(a * theta));
      final x = center.dx + r * math.cos(b * theta);
      final y = center.dy + r * math.sin(b * theta);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Inner concentric ring
    canvas.drawCircle(center, maxRadius * 0.35, paint);
  }

  @override
  bool shouldRepaint(covariant _GuillochePainter oldDelegate) => oldDelegate.color != color;
}
