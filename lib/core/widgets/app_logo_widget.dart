import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';

/// Official Swapnojatri Platform Logo Widget
/// Renders the official blue suitcase, birds, and paper-plane logo asset.
class SwapnojatriLogoWidget extends StatelessWidget {
  final double size;
  final bool showText;
  final bool isDark;
  final bool isBangla;
  final String? customSubtitle;

  const SwapnojatriLogoWidget({
    super.key,
    this.size = 40.0,
    this.showText = false,
    this.isDark = false,
    this.isBangla = true,
    this.customSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    final logoImg = ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.16),
      child: Image.asset(
        'assets/images/swapnojatri_logo.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Graceful vector fallback if asset loading delays
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00B4D8), Color(0xFF0066FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(size * 0.2),
              border: Border.all(color: Colors.white, width: 1.2),
            ),
            alignment: Alignment.center,
            child: Text(
              'স্বপ্নযাত্রী',
              style: GoogleFonts.hindSiliguri(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: size * 0.28,
              ),
            ),
          );
        },
      ),
    );

    if (!showText) {
      return logoImg;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logoImg,
        SizedBox(width: size * 0.25),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isBangla ? 'স্বপ্নযাত্রী' : 'SWAPNOJATRI',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.hindSiliguri(
                  fontSize: size * 0.42,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : palette.ink,
                  height: 1.1,
                ),
              ),
              Text(
                customSubtitle ?? (isBangla ? 'ইনভেস্টমেন্ট প্ল্যাটফর্ম' : 'Investment Platform'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.hindSiliguri(
                  fontSize: size * 0.28,
                  fontWeight: FontWeight.w500,
                  color: palette.pine,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
