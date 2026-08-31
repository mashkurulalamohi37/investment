import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/matra_rule_widget.dart';
import 'package:swapnojatri/core/widgets/figure.dart';
import 'package:swapnojatri/core/widgets/share_certificate_widget.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class PortfolioScreen extends StatelessWidget {
  final AppState state;

  const PortfolioScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final investments = state.investments;
    final distributions = state.distributions;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'পোর্টফোলিও ও অংশীদারিত্ব' : 'Portfolio Holdings & Shares',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Figures
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Figure(
                        label: isBangla ? 'মোট বিনিয়োগ' : 'Total Invested',
                        value: CurrencyFormatter.format(state.totalInvested, isBangla: isBangla, compact: true),
                        isBangla: isBangla,
                      ),
                    ),
                    Container(width: 1, height: 36, color: palette.rule),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Figure(
                        label: isBangla ? 'মালিকানাধীন অংশ' : 'Total Shares',
                        value: isBangla
                            ? '${CurrencyFormatter.toBanglaDigits(state.totalSharesOwned.toString())} টি অংশ'
                            : '${state.totalSharesOwned} Shares',
                        isBangla: isBangla,
                      ),
                    ),
                    Container(width: 1, height: 36, color: palette.rule),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Figure(
                        label: isBangla ? 'মোট লভ্যাংশ' : 'Dividends',
                        value: CurrencyFormatter.format(state.totalRealizedProfit, isBangla: isBangla, compact: true),
                        accentColor: palette.pine,
                        isBangla: isBangla,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Section 1: Holdings as Ruled Rows (§10)
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Text(
                isBangla ? 'অংশীদারিত্ব খতিয়ান' : 'Project Holdings',
                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  children: investments.map((inv) {
                    return ExpansionTile(
                      shape: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
                      collapsedShape: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
                      title: Text(
                        isBangla ? inv.projectTitleBn : inv.projectTitle,
                        style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        isBangla
                            ? '${CurrencyFormatter.toBanglaDigits(inv.sharesCount.toString())}টি অংশ • ${CurrencyFormatter.format(inv.totalAmount, isBangla: true)}'
                            : '${inv.sharesCount} Shares • ${CurrencyFormatter.format(inv.totalAmount)}',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkSecondary,
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          color: palette.surfaceSunken,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBangla
                                    ? 'বরাদ্দকৃত লট: ${inv.assignedLots.isEmpty ? 'LOT-041, LOT-042, LOT-043, LOT-044' : inv.assignedLots.join(', ')}'
                                    : 'Allocated Lots: ${inv.assignedLots.isEmpty ? 'LOT-041, LOT-042, LOT-043, LOT-044' : inv.assignedLots.join(', ')}',
                                style: TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.w600, color: palette.pine),
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShareCertificateWidget(
                                        investorName: state.currentUser.name,
                                        lotNumbers: 'LOT-041, LOT-042, LOT-043, LOT-044',
                                        shareCount: inv.sharesCount,
                                        totalValue: inv.totalAmount,
                                        issueDate: inv.createdAt,
                                        isBangla: isBangla,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.workspace_premium_rounded, size: 16, color: palette.brass),
                                    const SizedBox(width: 6),
                                    Text(
                                      isBangla ? 'অফিসিয়াল মালিকানা সনদপত্র দেখুন' : 'View Registered Share Certificate',
                                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                        color: palette.pine,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              // Section 2: Dividend History as Second Ruled Section (§10)
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Text(
                isBangla ? 'বিতরণকৃত মুনাফা ও লভ্যাংশ ইতিহাস' : 'Dividend & Payout History',
                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  children: distributions.map((dist) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBangla ? dist.periodNameBn : dist.periodName,
                                style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isBangla ? '৪টি শেয়ারের বিপরীতে' : 'For 4 shares',
                                style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                                  color: palette.inkTertiary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '+ ${CurrencyFormatter.format(dist.investorAmount, isBangla: isBangla)}',
                            style: AppTypography.amountSmall(isDark: isDark, isBangla: isBangla).copyWith(
                              color: palette.jade,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
