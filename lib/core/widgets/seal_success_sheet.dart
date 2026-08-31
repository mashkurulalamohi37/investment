import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/theme/app_motion.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';

class SealSuccessSheet extends StatefulWidget {
  final String lotNumber;
  final String amount;
  final String escrowBank;
  final String certificateId;
  final bool isBangla;
  final VoidCallback? onViewCertificate;
  final VoidCallback? onBackToPortfolio;

  const SealSuccessSheet({
    super.key,
    required this.lotNumber,
    required this.amount,
    this.escrowBank = 'City Bank PLC (Gulshan)',
    this.certificateId = 'CERT-2026-LV100-076',
    this.isBangla = false,
    this.onViewCertificate,
    this.onBackToPortfolio,
  });

  @override
  State<SealSuccessSheet> createState() => _SealSuccessSheetState();
}

class _SealSuccessSheetState extends State<SealSuccessSheet> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.narrative,
    );

    _scaleAnimation = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _rotationAnimation = Tween<double>(begin: -7.0 * (math.pi / 180.0), end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeIn)),
    );

    _controller.forward().then((_) {
      HapticFeedback.heavyImpact();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.isBangla;

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderSheet,
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag Handle
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: palette.ruleStrong,
              borderRadius: AppRadius.borderFull,
            ),
          ),
          const SizedBox(height: 24),

          // 1. Landing 96px Seal (Moment 4)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: SealWidget(size: 96, isBangla: isBangla),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // 2. TitleLarge Header
          Text(
            isBangla
                ? '${widget.lotNumber} আপনার নামে বরাদ্দ হয়েছে'
                : '${widget.lotNumber} is allocated to you',
            style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            isBangla
                ? 'ল্যান্ডভেস্ট ১০০ • সাব-রেজিস্ট্রি দলিল ৪৯৮২/২০২৬'
                : 'LandVest 100 • Sub-Registry Title Deed #4982/2026',
            style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
              color: palette.inkSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // 3. Ruled Receipt Table
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: AppRadius.borderChip,
              border: Border.all(color: palette.rule, width: 1.0),
            ),
            child: Column(
              children: [
                _receiptRow(isBangla ? 'বরাদ্দকৃত লট নং' : 'Allocated Lot', widget.lotNumber, palette, isDark),
                const SizedBox(height: 8),
                _receiptRow(isBangla ? 'পরিশোধিত মূল্য' : 'Amount Paid', widget.amount, palette, isDark, isBold: true),
                const SizedBox(height: 8),
                _receiptRow(isBangla ? 'এসক্রো হেফাজত' : 'Escrow Custody', widget.escrowBank, palette, isDark),
                const SizedBox(height: 8),
                _receiptRow(isBangla ? 'সনদপত্র ট্র্যাকিং' : 'Certificate ID', widget.certificateId, palette, isDark),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 4. Action Buttons
          AppButton(
            label: isBangla ? 'মালিকানা সনদ দেখুন' : 'View Certificate',
            variant: AppButtonVariant.primary,
            isBangla: isBangla,
            onPressed: widget.onViewCertificate ?? () => Navigator.pop(context),
          ),
          const SizedBox(height: 8),
          AppButton(
            label: isBangla ? 'পোর্টফোলিওতে ফিরে যান' : 'Back to Portfolio',
            variant: AppButtonVariant.quiet,
            isBangla: isBangla,
            onPressed: widget.onBackToPortfolio ?? () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _receiptRow(String label, String value, AppPalette palette, bool isDark, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.caption(isDark: isDark).copyWith(
            color: palette.inkSecondary,
            fontSize: 11.5,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodyStrong(isDark: isDark).copyWith(
            color: palette.ink,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            fontSize: 12.5,
          ),
        ),
      ],
    );
  }
}

// Backward compatibility alias for CelebratorySuccessWidget
typedef CelebratorySuccessWidget = SealSuccessSheet;
