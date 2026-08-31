import 'package:flutter/material.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/theme/app_motion.dart';

class AmountText extends StatefulWidget {
  final num amount;
  final bool isBangla;
  final bool includeSymbol;
  final bool compact;
  final bool animate;
  final TextStyle? style;

  const AmountText({
    super.key,
    required this.amount,
    this.isBangla = false,
    this.includeSymbol = true,
    this.compact = false,
    this.animate = false,
    this.style,
  });

  @override
  State<AmountText> createState() => _AmountTextState();
}

class _AmountTextState extends State<AmountText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.count,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    );

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant AmountText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount && widget.animate) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = (widget.style ?? AppTypography.amountLarge(isBangla: widget.isBangla)).copyWith(
      fontFeatures: AppTypography.tabularFontFeatures,
    );

    if (!widget.animate) {
      return Text(
        CurrencyFormatter.format(
          widget.amount,
          isBangla: widget.isBangla,
          includeSymbol: widget.includeSymbol,
          compact: widget.compact,
        ),
        style: effectiveStyle,
      );
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentVal = widget.amount * _animation.value;
        return Text(
          CurrencyFormatter.format(
            currentVal,
            isBangla: widget.isBangla,
            includeSymbol: widget.includeSymbol,
            compact: widget.compact,
          ),
          style: effectiveStyle,
        );
      },
    );
  }
}

// Alias for compatibility
typedef AnimatedCountText = AmountText;
