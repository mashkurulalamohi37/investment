import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_motion.dart';

/// The Matra (মাত্রা) Structural Device (§3 of Khatian Specification)
/// A 1.5px horizontal rule in pine drawn left-to-right above section headings on first paint.
class MatraRuleWidget extends StatefulWidget {
  final double width;
  final Color? color;
  final bool animate;

  const MatraRuleWidget({
    super.key,
    this.width = 36.0,
    this.color,
    this.animate = false,
  });

  @override
  State<MatraRuleWidget> createState() => _MatraRuleWidgetState();
}

class _MatraRuleWidgetState extends State<MatraRuleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.narrative,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: AppMotion.draw,
    );

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? context.palette.pine;

    if (!widget.animate) {
      return Container(
        width: widget.width,
        height: 1.5,
        color: effectiveColor,
      );
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: widget.width * _animation.value,
            height: 1.5,
            color: effectiveColor,
          ),
        );
      },
    );
  }
}
