import 'package:flutter/material.dart';

/// Authentic Google 4-Color 'G' Logo
class GoogleLogoWidget extends StatelessWidget {
  final double size;
  const GoogleLogoWidget({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double center = w / 2;
    final double radius = w / 2;
    final double strokeWidth = w * 0.22;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final rect = Rect.fromCircle(center: Offset(center, center), radius: radius - strokeWidth / 2);

    // Blue arc (Right & top-right)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, -0.75, 1.5, false, paint);

    // Green arc (Bottom & bottom-right)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, 0.75, 1.6, false, paint);

    // Yellow arc (Bottom-left & left)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, 2.35, 1.4, false, paint);

    // Red arc (Top & top-left)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, 3.75, 1.8, false, paint);

    // Blue horizontal bar in middle
    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final barRect = Rect.fromLTWH(center - 1, center - strokeWidth / 2, radius - strokeWidth / 4 + 1, strokeWidth);
    canvas.drawRect(barRect, barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Authentic 4-Color Microsoft Logo
class MicrosoftLogoWidget extends StatelessWidget {
  final double size;
  const MicrosoftLogoWidget({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    final boxSize = (size - 3) / 2;
    return SizedBox(
      width: size,
      height: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: boxSize, height: boxSize, color: const Color(0xFFF25022)), // Red-Orange
              const SizedBox(width: 3),
              Container(width: boxSize, height: boxSize, color: const Color(0xFF7FBA00)), // Green
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: boxSize, height: boxSize, color: const Color(0xFF00A4EF)), // Blue
              const SizedBox(width: 3),
              Container(width: boxSize, height: boxSize, color: const Color(0xFFFFB900)), // Yellow
            ],
          ),
        ],
      ),
    );
  }
}

/// Authentic Apple Logo
class AppleLogoWidget extends StatelessWidget {
  final double size;
  final Color? color;
  const AppleLogoWidget({super.key, this.size = 22, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.apple_rounded,
      size: size + 4,
      color: color ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF0A2540)),
    );
  }
}

/// Authentic bKash Brand Logo Badge
class BkashLogoWidget extends StatelessWidget {
  final double size;
  const BkashLogoWidget({super.key, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2136E).withValues(alpha: 0.3), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE2136E).withValues(alpha: 0.12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.asset(
          'assets/images/bkash_logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

/// Authentic Nagad Brand Logo Badge
class NagadLogoWidget extends StatelessWidget {
  final double size;
  const NagadLogoWidget({super.key, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF7941D).withValues(alpha: 0.3), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF7941D).withValues(alpha: 0.12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.asset(
          'assets/images/nagad_logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

/// Authentic Rocket (DBBL) Brand Logo Badge
class RocketLogoWidget extends StatelessWidget {
  final double size;
  const RocketLogoWidget({super.key, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF8C3494),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8C3494).withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/rocket_logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

/// Bank Wire Transfer Logo Badge
class BankTransferLogoWidget extends StatelessWidget {
  final double size;
  const BankTransferLogoWidget({super.key, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF0066FF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0066FF).withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/bank_wire_logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(
              Icons.account_balance_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
