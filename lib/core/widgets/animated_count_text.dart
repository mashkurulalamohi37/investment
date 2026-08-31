import 'package:flutter/material.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';

enum CountFormat { currency, integer, percentage }

/// High-performance animated financial counter supporting BDT Lakh/Crore formatting and Bangla numerals
class AnimatedCountText extends StatefulWidget {
  final double endValue;
  final double startValue;
  final Duration duration;
  final TextStyle? style;
  final CountFormat format;
  final bool isBangla;
  final bool compact;
  final Curve curve;

  const AnimatedCountText({
    super.key,
    required this.endValue,
    this.startValue = 0.0,
    this.duration = const Duration(milliseconds: 900),
    this.style,
    this.format = CountFormat.currency,
    this.isBangla = false,
    this.compact = false,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<AnimatedCountText> createState() => _AnimatedCountTextState();
}

class _AnimatedCountTextState extends State<AnimatedCountText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: widget.startValue, end: widget.endValue).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCountText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.endValue != widget.endValue) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.endValue,
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _format(double value) {
    switch (widget.format) {
      case CountFormat.currency:
        return CurrencyFormatter.format(
          value,
          isBangla: widget.isBangla,
          compact: widget.compact,
        );
      case CountFormat.integer:
        final intVal = value.round().toString();
        return widget.isBangla ? CurrencyFormatter.toBanglaDigits(intVal) : intVal;
      case CountFormat.percentage:
        final pctVal = '${value.round()}%';
        return widget.isBangla ? CurrencyFormatter.toBanglaDigits(pctVal) : pctVal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          _format(_animation.value),
          style: widget.style,
        );
      },
    );
  }
}
