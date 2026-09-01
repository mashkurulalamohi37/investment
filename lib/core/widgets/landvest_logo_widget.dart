import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Accurate Vector Emblem & Logo for LandVest 100
/// Featuring the signature Gold & Navy architectural "LV" skyscraper monogram
class LandVestLogoWidget extends StatelessWidget {
  final double size;
  final bool showText;
  final bool isDark;
  final Color? goldColor;
  final Color? navyColor;

  const LandVestLogoWidget({
    super.key,
    this.size = 64.0,
    this.showText = true,
    this.isDark = false,
    this.goldColor,
    this.navyColor,
  });

  @override
  Widget build(BuildContext context) {
    final gold = goldColor ?? const Color(0xFFC59B27); // Luxury Metallic Gold
    final navy = navyColor ?? const Color(0xFF0F2B48); // Deep Architectural Navy
    final textColor = isDark ? Colors.white : const Color(0xFF0F2B48);

    final emblem = SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LandVestEmblemPainter(
          goldColor: gold,
          navyColor: navy,
        ),
      ),
    );

    if (!showText) {
      return emblem;
    }

    final fontSize = (size * 0.28).clamp(12.0, 32.0);
    final subFontSize = (fontSize * 0.85).clamp(10.0, 24.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        emblem,
        SizedBox(height: size * 0.12),
        // "LANDVEST" Text
        Text(
          'LANDVEST',
          style: GoogleFonts.cinzel(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            letterSpacing: size * 0.08,
            height: 1.0,
          ),
        ),
        SizedBox(height: size * 0.06),
        // "—— 100 ——" Sub-branding with gold accent lines
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size * 0.35,
              height: 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gold.withValues(alpha: 0.0), gold],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * 0.08),
              child: Text(
                '100',
                style: GoogleFonts.cormorantGaramond(
                  color: gold,
                  fontSize: subFontSize,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  height: 1.0,
                ),
              ),
            ),
            Container(
              width: size * 0.35,
              height: 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gold, gold.withValues(alpha: 0.0)],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// CustomPainter that renders the stylized architectural LV monogram
class _LandVestEmblemPainter extends CustomPainter {
  final Color goldColor;
  final Color navyColor;

  _LandVestEmblemPainter({
    required this.goldColor,
    required this.navyColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final navyPaint = Paint()
      ..color = navyColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final goldPaint = Paint()
      ..color = goldColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final lightGoldPaint = Paint()
      ..color = const Color(0xFFDFB754)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Center offset coordinates mapped in 0.0 - 1.0 grid
    // 1. "L" left vertical tower (Deep Navy)
    final lPath = Path();
    lPath.moveTo(w * 0.16, h * 0.22);
    lPath.lineTo(w * 0.29, h * 0.22);
    lPath.lineTo(w * 0.29, h * 0.72);
    lPath.lineTo(w * 0.44, h * 0.72);
    lPath.lineTo(w * 0.44, h * 0.82);
    lPath.lineTo(w * 0.12, h * 0.82);
    lPath.lineTo(w * 0.12, h * 0.72);
    lPath.lineTo(w * 0.16, h * 0.72);
    lPath.close();
    canvas.drawPath(lPath, navyPaint);

    // Left tower top serif / accent
    final lTopSerif = Path();
    lTopSerif.moveTo(w * 0.11, h * 0.22);
    lTopSerif.lineTo(w * 0.34, h * 0.22);
    lTopSerif.lineTo(w * 0.34, h * 0.18);
    lTopSerif.lineTo(w * 0.11, h * 0.18);
    lTopSerif.close();
    canvas.drawPath(lTopSerif, navyPaint);

    // 2. Central High-Rise Tower (Navy with Gold Crown)
    final centerTower = Path();
    centerTower.moveTo(w * 0.38, h * 0.14);
    centerTower.lineTo(w * 0.47, h * 0.04); // spire peak
    centerTower.lineTo(w * 0.56, h * 0.14);
    centerTower.lineTo(w * 0.56, h * 0.75);
    centerTower.lineTo(w * 0.38, h * 0.75);
    centerTower.close();
    canvas.drawPath(centerTower, navyPaint);

    // Center Tower Facet / Highlight (Gold)
    final centerFacet = Path();
    centerFacet.moveTo(w * 0.47, h * 0.04);
    centerFacet.lineTo(w * 0.56, h * 0.14);
    centerFacet.lineTo(w * 0.56, h * 0.75);
    centerFacet.lineTo(w * 0.47, h * 0.75);
    centerFacet.close();
    canvas.drawPath(centerFacet, goldPaint);

    // 3. Right Tower / "V" arm (Gold angled architectural wing)
    final rightWing = Path();
    rightWing.moveTo(w * 0.58, h * 0.16);
    rightWing.lineTo(w * 0.67, h * 0.08); // peak
    rightWing.lineTo(w * 0.74, h * 0.16);
    rightWing.lineTo(w * 0.74, h * 0.65);
    rightWing.lineTo(w * 0.58, h * 0.65);
    rightWing.close();
    canvas.drawPath(rightWing, lightGoldPaint);

    // Far right angled chevron / architectural "V" diagonal
    final vDiagonalRight = Path();
    vDiagonalRight.moveTo(w * 0.88, h * 0.30);
    vDiagonalRight.lineTo(w * 0.94, h * 0.30);
    vDiagonalRight.lineTo(w * 0.52, h * 0.92);
    vDiagonalRight.lineTo(w * 0.45, h * 0.92);
    vDiagonalRight.lineTo(w * 0.72, h * 0.52);
    vDiagonalRight.close();
    canvas.drawPath(vDiagonalRight, goldPaint);

    // Far left angled chevron / architectural "V" diagonal (Navy)
    final vDiagonalLeft = Path();
    vDiagonalLeft.moveTo(w * 0.34, h * 0.52);
    vDiagonalLeft.lineTo(w * 0.52, h * 0.92);
    vDiagonalLeft.lineTo(w * 0.45, h * 0.92);
    vDiagonalLeft.lineTo(w * 0.28, h * 0.65);
    vDiagonalLeft.close();
    canvas.drawPath(vDiagonalLeft, navyPaint);

    // Base podium / foundation line
    final baseLine = Path();
    baseLine.moveTo(w * 0.08, h * 0.94);
    baseLine.lineTo(w * 0.92, h * 0.94);
    baseLine.lineTo(w * 0.92, h * 0.97);
    baseLine.lineTo(w * 0.08, h * 0.97);
    baseLine.close();
    canvas.drawPath(baseLine, goldPaint);
  }

  @override
  bool shouldRepaint(covariant _LandVestEmblemPainter oldDelegate) {
    return oldDelegate.goldColor != goldColor || oldDelegate.navyColor != navyColor;
  }
}
