import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/theme/app_motion.dart';

enum AppButtonVariant { primary, secondary, quiet, destructive }

typedef ButtonVariant = AppButtonVariant;

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final bool isBangla;
  final double? height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.isBangla = false,
    this.height,
  });

  // Compatibility Named Constructors
  factory AppButton.primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    IconData? icon,
    bool isBangla = false,
    double? height,
  }) =>
      AppButton(
        key: key,
        label: text,
        onPressed: onPressed,
        variant: AppButtonVariant.primary,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        icon: icon,
        isBangla: isBangla,
        height: height,
      );

  factory AppButton.secondary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    IconData? icon,
    bool isBangla = false,
    double? height,
  }) =>
      AppButton(
        key: key,
        label: text,
        onPressed: onPressed,
        variant: AppButtonVariant.secondary,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        icon: icon,
        isBangla: isBangla,
        height: height,
      );

  factory AppButton.outline({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    IconData? icon,
    bool isBangla = false,
    double? height,
  }) =>
      AppButton(
        key: key,
        label: text,
        onPressed: onPressed,
        variant: AppButtonVariant.secondary,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        icon: icon,
        isBangla: isBangla,
        height: height,
      );

  factory AppButton.gold({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    IconData? icon,
    bool isBangla = false,
    double? height,
  }) =>
      AppButton(
        key: key,
        label: text,
        onPressed: onPressed,
        variant: AppButtonVariant.primary,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        icon: icon,
        isBangla: isBangla,
        height: height,
      );

  factory AppButton.ghost({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    IconData? icon,
    bool isBangla = false,
    double? height,
  }) =>
      AppButton(
        key: key,
        label: text,
        onPressed: onPressed,
        variant: AppButtonVariant.quiet,
        isLoading: isLoading,
        isFullWidth: isFullWidth,
        icon: icon,
        isBangla: isBangla,
        height: height,
      );

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    Color bg;
    Color border;
    Color text;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        bg = _isPressed ? palette.pineDeep : (isEnabled ? palette.pine : palette.surfaceSunken);
        border = Colors.transparent;
        text = isEnabled ? palette.canvas : palette.inkTertiary;
        break;
      case AppButtonVariant.secondary:
        bg = _isPressed ? palette.surfaceSunken : palette.surface;
        border = isEnabled ? palette.ruleStrong : palette.rule;
        text = isEnabled ? palette.ink : palette.inkTertiary;
        break;
      case AppButtonVariant.quiet:
        bg = _isPressed ? palette.pineTint : Colors.transparent;
        border = Colors.transparent;
        text = isEnabled ? palette.pine : palette.inkTertiary;
        break;
      case AppButtonVariant.destructive:
        bg = _isPressed ? palette.vermilion.withValues(alpha: 0.08) : Colors.transparent;
        border = isEnabled ? palette.vermilion : palette.rule;
        text = isEnabled ? palette.vermilion : palette.inkTertiary;
        break;
    }

    final content = AnimatedScale(
      scale: _isPressed && isEnabled ? 0.985 : 1.0,
      duration: AppMotion.instant,
      child: AnimatedContainer(
        duration: AppMotion.instant,
        height: widget.height ?? 48,
        constraints: BoxConstraints(
          minWidth: widget.isFullWidth ? double.infinity : 100,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: AppRadius.borderControl,
          border: Border.all(color: border, width: 1.0),
        ),
        child: Center(
          child: widget.isLoading
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(text),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 16, color: text),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      widget.label,
                      style: AppTypography.bodyStrong(isDark: isDark, isBangla: widget.isBangla).copyWith(
                        color: text,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled
          ? (_) {
              setState(() => _isPressed = false);
              HapticFeedback.selectionClick();
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      child: widget.isFullWidth ? content : IntrinsicWidth(child: content),
    );
  }
}
