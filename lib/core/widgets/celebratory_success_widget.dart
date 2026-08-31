import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';

class CelebratorySuccessWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Widget> summaryRows;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isBangla;

  const CelebratorySuccessWidget({
    super.key,
    required this.title,
    required this.description,
    required this.summaryRows,
    required this.buttonText,
    required this.onButtonPressed,
    this.isBangla = false,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    required List<Widget> summaryRows,
    required String buttonText,
    required VoidCallback onButtonPressed,
    bool isBangla = false,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CelebratorySuccessWidget(
        title: title,
        description: description,
        summaryRows: summaryRows,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed,
        isBangla: isBangla,
      ),
    );
  }

  @override
  State<CelebratorySuccessWidget> createState() => _CelebratorySuccessWidgetState();
}

class _CelebratorySuccessWidgetState extends State<CelebratorySuccessWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeInOut)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated Ripple Halo & Checkmark
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Glow Halo
                  Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accentGold.withValues(alpha: 0.15),
                      ),
                    ),
                  ),
                  // Inner Success Emblem
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.goldGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentGold.withValues(alpha: 0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.check_rounded, color: AppColors.primaryDark, size: 42),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          Text(
            widget.title,
            style: AppTypography.headingLarge(isDark: isDark, isBangla: widget.isBangla),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: AppTypography.bodyMedium(isDark: isDark, isBangla: widget.isBangla),
            textAlign: TextAlign.center,
          ),

          if (widget.summaryRows.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBg,
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ),
              ),
              child: Column(
                children: widget.summaryRows,
              ),
            ),
          ],

          const SizedBox(height: 28),
          AppButton(
            text: widget.buttonText,
            onPressed: widget.onButtonPressed,
            variant: ButtonVariant.primary,
            isBangla: widget.isBangla,
          ),
        ],
      ),
    );
  }
}
