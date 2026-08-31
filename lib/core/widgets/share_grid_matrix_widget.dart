import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';

class ShareGridMatrixWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = this.isBangla;

    final userIndices = <int>{};
    for (var lot in userLots) {
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
        borderRadius: AppRadius.borderLg,
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
                    isBangla ? 'জমির ১০০টি নির্দিষ্ট শেয়ার লট মানচিত্র' : 'Cadastral Survey Lot Map (100 Shares)',
                    style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    isBangla
                        ? 'মৌজা: বিরুলিয়া, সাভার • দাগ নং ৪১৮ • প্রতিটি শেয়ার লট চিহ্নিত'
                        : 'Mouza: Birulia, Savar • RS Plot #418 • 1 Share = 0.225 Decimals',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : const Color(0xFFF1F5F9),
                  borderRadius: AppRadius.borderXs,
                  border: Border.all(
                    color: isDark ? AppColors.darkCardBorder : const Color(0xFFCBD5E1),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  '10×10 LOTS',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 10x10 Architectural Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalShares,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final lotNo = (index + 1).toString().padLeft(2, '0');
              final isUserLot = userIndices.contains(index);
              final isAllocated = index < allocatedShares && !isUserLot;
              final isAvailable = index >= allocatedShares;

              final isSelectedInCalculator = isAvailable &&
                  (index < allocatedShares + selectedSharesCount);

              Color tileBg;
              Color borderColor;
              Color textColor;

              if (isUserLot) {
                // User's lot: Rich solid forest emerald with gold accent border
                tileBg = const Color(0xFF0B281E);
                borderColor = AppColors.accentGold;
                textColor = AppColors.accentGoldLight;
              } else if (isAllocated) {
                // Allocated by others: Clean muted slate fill
                tileBg = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
                borderColor = Colors.transparent;
                textColor = isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);
              } else if (isSelectedInCalculator) {
                // Currently selected in subscription calculator
                tileBg = isDark ? const Color(0xFF0F3B2C) : const Color(0xFFDCFCE7);
                borderColor = AppColors.primaryLight;
                textColor = isDark ? Colors.white : AppColors.primaryDark;
              } else {
                // Available
                tileBg = isDark ? AppColors.darkSurface : const Color(0xFFFFFFFF);
                borderColor = isDark ? const Color(0xFF243242) : const Color(0xFFCBD5E1);
                textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
              }

              return Tooltip(
                message: isUserLot
                    ? 'LOT-$lotNo (Your Ownership)'
                    : (isAllocated ? 'LOT-$lotNo (Allocated)' : 'LOT-$lotNo (Available)'),
                child: GestureDetector(
                  onTap: () {
                    if (isAvailable && isInteractive && onSelectShares != null) {
                      final selectedCount = (index - allocatedShares + 1).clamp(1, 4);
                      onSelectShares!(selectedCount);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: tileBg,
                      borderRadius: AppRadius.borderXs,
                      border: Border.all(color: borderColor, width: isUserLot ? 1.5 : 0.8),
                    ),
                    child: Center(
                      child: Text(
                        lotNo,
                        style: TextStyle(
                          fontSize: 8.5,
                          fontFamily: 'monospace',
                          fontWeight: isUserLot ? FontWeight.w800 : FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 10),

          // Legend Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _legendItem(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                label: isBangla
                    ? 'বরাদ্দকৃত (${CurrencyFormatter.toBanglaDigits((allocatedShares - userLots.length).toString())})'
                    : 'Allocated (${allocatedShares - userLots.length})',
                isDark: isDark,
              ),
              _legendItem(
                color: const Color(0xFF0B281E),
                borderColor: AppColors.accentGold,
                label: isBangla
                    ? 'আপনার লট (${CurrencyFormatter.toBanglaDigits(userLots.length.toString())})'
                    : 'Your Lots (${userLots.length})',
                isDark: isDark,
              ),
              _legendItem(
                color: isDark ? AppColors.darkSurface : const Color(0xFFFFFFFF),
                borderColor: const Color(0xFF94A3B8),
                label: isBangla
                    ? 'উপলব্ধ (${CurrencyFormatter.toBanglaDigits((totalShares - allocatedShares).toString())})'
                    : 'Available (${totalShares - allocatedShares})',
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem({
    required Color color,
    Color? borderColor,
    required String label,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          width: 11,
          height: 11,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.borderXs,
            border: borderColor != null ? Border.all(color: borderColor, width: 1.2) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.caption(isDark: isDark).copyWith(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
