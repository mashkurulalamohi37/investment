import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/status_chip.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/empty_state_view.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/project_detail/project_detail_screen.dart';

class PortfolioScreen extends StatelessWidget {
  final AppState state;
  final Function(int) onExploreTap;

  const PortfolioScreen({
    super.key,
    required this.state,
    required this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final investments = state.investments;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'আমার বিনিয়োগ পোর্টফোলিও' : 'My Portfolio',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Summary Box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: isDark ? AppColors.heroGradientDark : AppColors.heroGradientLight,
                borderRadius: AppRadius.borderXl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBangla ? 'পোর্টফোলিওতে মোট বিনিয়োগ' : 'TOTAL INVESTED CAPITAL',
                    style: AppTypography.caption().copyWith(
                      color: Colors.white70,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    CurrencyFormatter.format(state.totalInvested, isBangla: isBangla),
                    style: AppTypography.financialAmountLarge().copyWith(color: Colors.white, fontSize: 32),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white12),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBangla ? 'মোট শেয়ার' : 'Total Shares',
                            style: AppTypography.caption().copyWith(color: Colors.white70),
                          ),
                          Text(
                            isBangla
                                ? '${CurrencyFormatter.toBanglaDigits(state.totalSharesOwned.toString())} টি শেয়ার'
                                : '${state.totalSharesOwned} Shares',
                            style: AppTypography.headingSmall().copyWith(
                              color: AppColors.accentGoldLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBangla ? 'উত্তোলিত মুনাফা' : 'Realized Profit',
                            style: AppTypography.caption().copyWith(color: Colors.white70),
                          ),
                          Text(
                            CurrencyFormatter.format(state.totalRealizedProfit, isBangla: isBangla),
                            style: AppTypography.headingSmall().copyWith(
                              color: AppColors.successLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            isBangla ? 'প্রক্রিয়াধীন' : 'Pending Distr.',
                            style: AppTypography.caption().copyWith(color: Colors.white70),
                          ),
                          Text(
                            CurrencyFormatter.format(state.pendingDistributionAmount, isBangla: isBangla),
                            style: AppTypography.headingSmall().copyWith(
                              color: AppColors.warningLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Investment Holdings List
            Text(
              isBangla ? 'সাবস্ক্রিপশনকৃত প্রকল্পসমূহ' : 'Active Investment Holdings',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            if (investments.isEmpty)
              EmptyStateView(
                title: isBangla ? 'কোনো সক্রিয় বিনিয়োগ নেই' : 'No Active Investments',
                description: isBangla
                    ? 'ল্যান্ডভেস্ট ১০০ প্রকল্পে শেয়ার সাবস্ক্রাইব করে আপনার পোর্টফোলিও শুরু করুন।'
                    : 'Subscribe to shares in LandVest 100 to begin building your asset portfolio.',
                icon: Icons.terrain_rounded,
                buttonText: isBangla ? 'প্রকল্প দেখুন' : 'Explore Projects',
                onButtonPressed: () => onExploreTap(1),
                isBangla: isBangla,
              )
            else
              ...investments.map((inv) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(18),
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
                          // Top Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    inv.projectName,
                                    style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla).copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'ID: ${inv.investmentNo}',
                                    style: AppTypography.caption(isDark: isDark).copyWith(
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              StatusChip.investment(inv.status, isBangla: isBangla),
                            ],
                          ),
                          const SizedBox(height: 14),
                          const Divider(height: 1),
                          const SizedBox(height: 12),

                          // Lot numbers badges
                          if (inv.allocatedLotNumbers.isNotEmpty) ...[
                            Text(
                              isBangla ? 'বরাদ্দকৃত শেয়ার লট:' : 'Allocated Share Lots:',
                              style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: inv.allocatedLotNumbers.map((lot) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.15),
                                    borderRadius: AppRadius.borderXs,
                                    border: Border.all(
                                      color: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    lot,
                                    style: AppTypography.caption(isDark: isDark).copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'monospace',
                                      color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 12),
                          ],

                          // Financial breakdown
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isBangla ? 'শেয়ার সংখ্যা' : 'Shares',
                                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                                  ),
                                  Text(
                                    isBangla
                                        ? '${CurrencyFormatter.toBanglaDigits(inv.shares.toString())} টি শেয়ার'
                                        : '${inv.shares} Shares',
                                    style: AppTypography.headingSmall(isDark: isDark).copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    isBangla ? 'বিনিয়োগকৃত অর্থ' : 'Principal Amount',
                                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                                  ),
                                  Text(
                                    CurrencyFormatter.format(inv.grossAmount, isBangla: isBangla),
                                    style: AppTypography.financialAmountSmall(isDark: isDark),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Bottom Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  text: isBangla ? 'প্রকল্প বিবরণ' : 'Project Details',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProjectDetailScreen(
                                          project: state.landVest100,
                                          state: state,
                                        ),
                                      ),
                                    );
                                  },
                                  variant: ButtonVariant.outline,
                                  height: 40,
                                  isBangla: isBangla,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: AppButton(
                                  text: isBangla ? 'সনদপত্র ডাউনলোড' : 'Certificate',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isBangla
                                              ? 'শেয়ার সনদপত্র ডাউনলোড করা হচ্ছে (${inv.investmentNo})'
                                              : 'Downloading Official Share Certificate...',
                                        ),
                                        backgroundColor: AppColors.success,
                                      ),
                                    );
                                  },
                                  icon: Icons.download_rounded,
                                  variant: ButtonVariant.primary,
                                  height: 40,
                                  isBangla: isBangla,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),

            const SizedBox(height: 20),

            // Financial Clarity Disclaimer
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightDivider,
                borderRadius: AppRadius.borderMd,
              ),
              child: Text(
                isBangla
                    ? 'স্পষ্টীকরণ: অর্জিত লভ্যাংশ (Realized Profit) এবং প্রক্রিয়াধীন লভ্যাংশ (Pending Distribution) আলাদাভাবে হিসাব করা হয়। কোনো অনিশ্চিত অনুমানকে নিশ্চিত রিটার্ন হিসেবে গণ্য করা হয় না।'
                    : 'Transparency Note: Realized profits and pending payouts are segregated. No estimated growth figures represent guaranteed financial yield.',
                style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
