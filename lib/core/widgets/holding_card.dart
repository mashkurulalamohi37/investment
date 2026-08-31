import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/amount_text.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';

class HoldingCard extends StatelessWidget {
  final double totalInvested;
  final int totalShares;
  final double realizedProfit;
  final bool isBangla;
  final VoidCallback? onExploreTap;
  final VoidCallback? onTransparencyTap;

  const HoldingCard({
    super.key,
    required this.totalInvested,
    required this.totalShares,
    required this.realizedProfit,
    this.isBangla = false,
    this.onExploreTap,
    this.onTransparencyTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.holdingCardGradientDark : AppColors.holdingCardGradientLight,
        borderRadius: AppRadius.borderHero,
        border: Border.all(
          color: palette.brass.withValues(alpha: isDark ? 0.35 : 0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: palette.pine.withValues(alpha: isDark ? 0.5 : 0.15),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Row: Gold Matra Line + Official Stamp Seal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 38,
                height: 2.0,
                decoration: BoxDecoration(
                  color: palette.brass,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              SealWidget(size: 26, isBangla: isBangla),
            ],
          ),
          const SizedBox(height: 12),

          // 2. Section Label
          Text(
            isBangla ? 'আপনার মোট জমি বিনিয়োগ' : 'Total Asset-Backed Holding',
            style: AppTypography.caption(isBangla: isBangla).copyWith(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 12,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),

          // 3. Amount in AmountHero with Champagne Gold accent
          AmountText(
            amount: totalInvested,
            isBangla: isBangla,
            animate: true,
            style: AppTypography.amountHero(isBangla: isBangla, color: Colors.white).copyWith(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),

          // 4. Hairline Divider at 12% Opacity
          Divider(
            color: Colors.white.withValues(alpha: 0.12),
            height: 1.0,
          ),
          const SizedBox(height: 16),

          // 5. Two-Column Ruled Table
          _tableRow(
            label1: isBangla ? 'মালিকানা অংশ' : 'Shares Allocated',
            val1: isBangla
                ? '${CurrencyFormatter.toBanglaDigits(totalShares.toString())}/১০০ অংশ'
                : '$totalShares of 100 Shares',
            label2: isBangla ? 'নির্দিষ্ট লট নং' : 'Cadastral Lots',
            val2: 'LOT-041..044',
            palette: palette,
            isBangla: isBangla,
          ),
          const SizedBox(height: 12),
          _tableRow(
            label1: isBangla ? 'হেফাজতকারী ব্যাংক' : 'Custody Escrow',
            val1: isBangla ? 'সিটি ব্যাংক পিএলসি' : 'City Bank PLC',
            label2: isBangla ? 'অর্জিত লভ্যাংশ' : 'Dividends Paid',
            val2: CurrencyFormatter.format(realizedProfit, isBangla: isBangla),
            val2Color: palette.brassLight,
            palette: palette,
            isBangla: isBangla,
          ),
        ],
      ),
    );
  }

  Widget _tableRow({
    required String label1,
    required String val1,
    required String label2,
    required String val2,
    Color? val2Color,
    required AppPalette palette,
    required bool isBangla,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                val1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label2,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                val2,
                style: TextStyle(
                  color: val2Color ?? Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Backward compatibility alias for PortfolioHeroCard
typedef PortfolioHeroCard = HoldingCard;
