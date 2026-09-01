import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/amount_text.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';

/// Wise-Inspired Holding Card (Clean, Flat, Pure White with Bold Paddy Green Figures)
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
        color: palette.surface,
        borderRadius: AppRadius.borderHero,
        border: Border.all(
          color: palette.rule,
          width: 1.0,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Row: Section Label Badge + Official Seal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: palette.pineTint,
                  borderRadius: AppRadius.borderChip,
                ),
                child: Text(
                  isBangla ? 'আপনার মোট পোর্টফোলিও বিনিয়োগ' : 'TOTAL PORTFOLIO HOLDING',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: palette.pine,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SealWidget(size: 24, isBangla: isBangla),
            ],
          ),
          const SizedBox(height: 14),

          // 2. Bold Paddy Green Balance Amount
          AmountText(
            amount: totalInvested,
            isBangla: isBangla,
            animate: true,
            style: AppTypography.amountHero(isBangla: isBangla, color: palette.pine).copyWith(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),

          // 3. Ruled 2-Column Stat Well in Soft Sunken Tint
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: AppRadius.borderControl,
              border: Border.all(color: palette.rule, width: 1.0),
            ),
            child: Column(
              children: [
                _tableRow(
                  label1: isBangla ? 'অংশীদারিত্ব শেয়ার' : 'Shares Subscribed',
                  val1: isBangla
                      ? '${CurrencyFormatter.toBanglaDigits(totalShares.toString())}টি শেয়ার'
                      : '$totalShares Shares',
                  label2: isBangla ? 'প্রজেক্ট রেফারেন্স' : 'Project Ref',
                  val2: 'LandVest 100',
                  palette: palette,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
                Divider(
                  color: palette.rule,
                  height: 16,
                  thickness: 0.8,
                ),
                _tableRow(
                  label1: isBangla ? 'হেফাজতকারী ব্যাংক' : 'Custody Escrow',
                  val1: isBangla ? 'সিটি ব্যাংক পিএলসি' : 'City Bank PLC',
                  label2: isBangla ? 'অর্জিত লভ্যাংশ' : 'Dividends Paid',
                  val2: CurrencyFormatter.format(realizedProfit, isBangla: isBangla),
                  val2Color: palette.pine,
                  palette: palette,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
              ],
            ),
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
    required bool isDark,
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
                style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                  color: palette.inkSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                val1,
                style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: palette.ink,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 26,
          color: palette.rule,
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label2,
                style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                  color: palette.inkSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                val2,
                style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: val2Color ?? palette.ink,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
