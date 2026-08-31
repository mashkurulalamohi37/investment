import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/status_chip.dart';
import 'package:swapnojatri/data/models/distribution_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class ProfitDistributionScreen extends StatelessWidget {
  final AppState state;

  const ProfitDistributionScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final periods = state.profitPeriods;
    final distributions = state.distributions;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'লভ্যাংশ বণ্টন ও হিসাব' : 'Profit & Distribution Engine',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pro-rata Formula — a plain ruled panel, not a second hero
            // gradient (the app has exactly one permitted gradient, used on
            // the holding card) and no gold border or tracked-out label.
            Builder(builder: (context) {
              final palette = context.palette;
              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderCard,
                  border: Border.all(color: palette.ruleStrong, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'স্বচ্ছ লভ্যাংশ বণ্টন সূত্র' : 'Pro-rata payout formula',
                      style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: palette.surfaceSunken,
                        borderRadius: AppRadius.borderChip,
                        border: Border.all(color: palette.rule, width: 1.0),
                      ),
                      child: Text(
                        'Investor payout = (Distribution pool x your eligible shares) / total project shares',
                        style: AppTypography.bodyStrong(isDark: isDark).copyWith(fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isBangla
                          ? 'আপনার ৪টি শেয়ারের জন্য ল্যান্ডভেস্ট ১০০ এর মোট লভ্যাংশ পুলের ৪% সরাসরি বরাদ্দ হবে।'
                          : 'Your 4 shares earn exactly 4% of the audited realized distribution pool.',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),

            // Payouts for Active Investor
            Text(
              isBangla ? 'আমার লভ্যাংশ বিতরণ বিবরণী' : 'My Payout Entitlements',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            ...distributions.map((dist) => Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.white,
                      borderRadius: AppRadius.borderLg,
                      border: Border.all(
                        color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dist.periodName,
                              style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            StatusChip.distribution(dist.status, isBangla: isBangla),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isBangla ? 'যোগ্য শেয়ার লট' : 'Eligible Shares',
                                  style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                                ),
                                Text(
                                  isBangla
                                      ? '${CurrencyFormatter.toBanglaDigits(dist.eligibleShares.toString())} টি শেয়ার'
                                      : '${dist.eligibleShares} Shares',
                                  style: AppTypography.headingSmall(isDark: isDark).copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  isBangla ? 'প্রদেয় লভ্যাংশ' : 'Entitled Amount',
                                  style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                                ),
                                Text(
                                  CurrencyFormatter.format(dist.amount, isBangla: isBangla),
                                  style: AppTypography.financialAmountSmall(
                                    isDark: isDark,
                                    color: dist.status == DistributionStatus.paid ? AppColors.success : null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (dist.paidAt != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.check_circle_rounded, size: 13, color: AppColors.success),
                              const SizedBox(width: 4),
                              Text(
                                '${isBangla ? 'পরিশোধ সম্পন্ন:' : 'Paid on:'} ${CurrencyFormatter.formatDate(dist.paidAt!, isBangla: isBangla)} (${dist.paymentReference})',
                                style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                  color: AppColors.successDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                )),

            const SizedBox(height: 24),

            // Financial Period Reconciliation History
            Text(
              isBangla ? 'প্রকল্প আর্থিক পিরিয়ড ও অডিট' : 'Audited Profit Periods',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            ...periods.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : AppColors.lightBg,
                      borderRadius: AppRadius.borderMd,
                      border: Border.all(
                        color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.periodName,
                          style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(isBangla ? 'মোট অর্জিত আয়' : 'Gross Revenue', style: AppTypography.caption(isDark: isDark, isBangla: isBangla)),
                            Text(CurrencyFormatter.format(p.grossRevenue, isBangla: isBangla), style: AppTypography.caption(isDark: isDark)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(isBangla ? 'প্রকৃত ব্যয়' : 'Realized Expenses', style: AppTypography.caption(isDark: isDark, isBangla: isBangla)),
                            Text('-${CurrencyFormatter.format(p.realizedExpense, isBangla: isBangla)}', style: AppTypography.caption(isDark: isDark)),
                          ],
                        ),
                        const Divider(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isBangla ? 'বণ্টনযোগ্য নিট মুনাফা পুল' : 'Net Distribution Pool',
                              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              CurrencyFormatter.format(p.distributionPool, isBangla: isBangla),
                              style: AppTypography.headingSmall(isDark: isDark).copyWith(
                                fontSize: 13.5,
                                color: AppColors.success,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
