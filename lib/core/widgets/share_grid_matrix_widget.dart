import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';

class ShareGridMatrixWidget extends StatefulWidget {
  final int totalShares;
  final int allocatedShares;
  final List<String> userLots;
  final int selectedSharesCount;
  final Function(int sharesCount)? onSelectShares;
  final bool isBangla;
  final bool isInteractive;

  const ShareGridMatrixWidget({
    super.key,
    this.totalShares = 100,
    required this.allocatedShares,
    this.userLots = const ['LOT-041', 'LOT-042', 'LOT-043', 'LOT-044'],
    this.selectedSharesCount = 2,
    this.onSelectShares,
    this.isBangla = false,
    this.isInteractive = true,
  });

  @override
  State<ShareGridMatrixWidget> createState() => _ShareGridMatrixWidgetState();
}

class _ShareGridMatrixWidgetState extends State<ShareGridMatrixWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.isBangla;

    // Parse user lot numbers (e.g. LOT-041 -> index 40)
    final userIndices = <int>{};
    for (var lot in widget.userLots) {
      final numStr = lot.replaceAll('LOT-', '');
      final idx = int.tryParse(numStr);
      if (idx != null) {
        userIndices.add(idx - 1);
      }
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: AppRadius.borderXl,
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header & Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBangla ? '১০০ শেয়ারের ভিজ্যুয়াল লট ম্যাপ' : '100-Share Ownership Matrix',
                    style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.5,
                    ),
                  ),
                  Text(
                    isBangla ? 'সাভার জমির ১০০টি নির্দিষ্ট শেয়ার লটের লাইভ ম্যাপ' : 'Real-time lot allocation visualizer for LandVest 100',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accentGold.withValues(alpha: 0.15),
                  borderRadius: AppRadius.borderXs,
                ),
                child: Text(
                  '10×10 LOTS',
                  style: AppTypography.caption(isDark: isDark).copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: isDark ? AppColors.accentGoldLight : AppColors.accentGoldDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 10x10 Grid View
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.totalShares,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final lotNo = (index + 1).toString().padLeft(3, '0');
              final isUserLot = userIndices.contains(index);
              final isAllocated = index < widget.allocatedShares && !isUserLot;
              final isAvailable = index >= widget.allocatedShares;

              // Check if currently selected in calculator
              final isSelectedInCalculator = isAvailable &&
                  (index < widget.allocatedShares + widget.selectedSharesCount);

              Color tileBg;
              Color borderColor;
              Widget? iconWidget;

              if (isUserLot) {
                // User's owned lot (Glowing Gold)
                tileBg = AppColors.accentGold;
                borderColor = AppColors.accentGoldLight;
                iconWidget = const Icon(Icons.star_rounded, size: 10, color: AppColors.primaryDark);
              } else if (isAllocated) {
                // Other investor allocated lot (Deep Emerald)
                tileBg = isDark ? const Color(0xFF0F3B2C) : const Color(0xFF14533D);
                borderColor = Colors.transparent;
                iconWidget = const Icon(Icons.lock_rounded, size: 8, color: Colors.white60);
              } else if (isSelectedInCalculator) {
                // Highlighted for current subscription selection
                tileBg = isDark ? AppColors.accentGold.withValues(alpha: 0.35) : AppColors.primarySubtle;
                borderColor = isDark ? AppColors.accentGoldLight : AppColors.primary;
                iconWidget = Icon(
                  Icons.check_rounded,
                  size: 10,
                  color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                );
              } else {
                // Available for investment
                tileBg = isDark ? AppColors.darkSurface : const Color(0xFFF1F5F9);
                borderColor = isDark ? AppColors.darkDivider : const Color(0xFFCBD5E1);
              }

              return Tooltip(
                message: isUserLot
                    ? 'LOT-$lotNo (Your Allocated Share)'
                    : (isAllocated ? 'LOT-$lotNo (Allocated)' : 'LOT-$lotNo (Available)'),
                child: GestureDetector(
                  onTap: () {
                    if (isAvailable && widget.isInteractive && widget.onSelectShares != null) {
                      final selectedCount = (index - widget.allocatedShares + 1).clamp(1, 4);
                      widget.onSelectShares!(selectedCount);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: tileBg,
                      borderRadius: AppRadius.borderXs,
                      border: Border.all(color: borderColor, width: 1),
                      boxShadow: isUserLot
                          ? [
                              BoxShadow(
                                color: AppColors.accentGold.withValues(alpha: 0.4),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: iconWidget ??
                          Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w600,
                              color: isAllocated
                                  ? Colors.white70
                                  : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                            ),
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Legend Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _legend(
                color: isDark ? const Color(0xFF0F3B2C) : const Color(0xFF14533D),
                label: isBangla
                    ? 'বরাদ্দকৃত (${CurrencyFormatter.toBanglaDigits((widget.allocatedShares - widget.userLots.length).toString())})'
                    : 'Allocated (${widget.allocatedShares - widget.userLots.length})',
                isDark: isDark,
              ),
              _legend(
                color: AppColors.accentGold,
                label: isBangla
                    ? 'আপনার লট (${CurrencyFormatter.toBanglaDigits(widget.userLots.length.toString())})'
                    : 'Your Lots (${widget.userLots.length})',
                isDark: isDark,
                hasStar: true,
              ),
              _legend(
                color: isDark ? AppColors.darkSurface : const Color(0xFFF1F5F9),
                borderColor: const Color(0xFF94A3B8),
                label: isBangla
                    ? 'উপলব্ধ (${CurrencyFormatter.toBanglaDigits((widget.totalShares - widget.allocatedShares).toString())})'
                    : 'Available (${widget.totalShares - widget.allocatedShares})',
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legend({
    required Color color,
    Color? borderColor,
    required String label,
    required bool isDark,
    bool hasStar = false,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.borderXs,
            border: borderColor != null ? Border.all(color: borderColor, width: 1) : null,
          ),
          child: hasStar
              ? const Center(child: Icon(Icons.star_rounded, size: 8, color: AppColors.primaryDark))
              : null,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.caption(isDark: isDark).copyWith(fontSize: 10.5, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
