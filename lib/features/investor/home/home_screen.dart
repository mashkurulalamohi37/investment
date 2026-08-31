import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/portfolio_hero_card.dart';
import 'package:swapnojatri/core/widgets/kpi_card.dart';
import 'package:swapnojatri/core/widgets/project_card.dart';
import 'package:swapnojatri/core/widgets/transaction_tile.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/project_detail/project_detail_screen.dart';
import 'package:swapnojatri/features/investor/transparency/transparency_screen.dart';
import 'package:swapnojatri/features/investor/document_vault/document_vault_screen.dart';
import 'package:swapnojatri/features/investor/notifications/notifications_screen.dart';
import 'package:swapnojatri/features/investor/support/support_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppState state;
  final Function(int tabIndex) onNavigateTab;

  const HomeScreen({
    super.key,
    required this.state,
    required this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final user = state.currentUser;
    final project = state.landVest100;
    final transactions = state.transactions;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 300));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Authentic Banking User Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(user.avatarUrl),
                          backgroundColor: isDark ? AppColors.darkCard : AppColors.primarySubtle,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  user.name,
                                  style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla).copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.verified_rounded, size: 16, color: AppColors.success),
                              ],
                            ),
                            Text(
                              isBangla ? 'হিসাব নং: SWP-88210 • কেওয়াইসি যাচাইকৃত' : 'A/C: SWP-88210 • KYC Verified',
                              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                fontSize: 11,
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Language Switcher
                        TextButton(
                          onPressed: () => state.toggleLanguage(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppRadius.borderSm,
                              side: BorderSide(
                                color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                              ),
                            ),
                          ),
                          child: Text(
                            isBangla ? 'EN' : 'বাং',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Notifications
                        Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationsScreen(state: state),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.notifications_none_rounded),
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            ),
                            if (state.unreadNotificationCount > 0)
                              Positioned(
                                right: 2,
                                top: 2,
                                child: Container(
                                  width: 7,
                                  height: 7,
                                  decoration: const BoxDecoration(
                                    color: AppColors.error,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Portfolio Hero Card
                PortfolioHeroCard(
                  totalInvested: state.totalInvested,
                  totalShares: state.totalSharesOwned,
                  realizedProfit: state.totalRealizedProfit,
                  isBangla: isBangla,
                  onExploreTap: () => onNavigateTab(1),
                  onTransparencyTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransparencyScreen(state: state),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // 4-Grid Financial Metric Tiles
                Row(
                  children: [
                    Expanded(
                      child: KpiCard(
                        label: isBangla ? 'সক্রিয় প্রকল্প' : 'Active Projects',
                        value: isBangla ? '১ টি প্রকল্প' : '1 Project',
                        icon: Icons.layers_outlined,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: KpiCard(
                        label: isBangla ? 'মালিকানাধীন শেয়ার' : 'Total Shares',
                        value: isBangla
                            ? '${CurrencyFormatter.toBanglaDigits(state.totalSharesOwned.toString())} টি শেয়ার'
                            : '${state.totalSharesOwned} Shares',
                        icon: Icons.pie_chart_outline_rounded,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: KpiCard(
                        label: isBangla ? 'মোট উত্তোলিত লাভ' : 'Realized Return',
                        value: CurrencyFormatter.format(state.totalRealizedProfit, isBangla: isBangla, compact: true),
                        icon: Icons.trending_up_rounded,
                        accentColor: AppColors.success,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(3),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: KpiCard(
                        label: isBangla ? 'প্রক্রিয়াধীন লভ্যাংশ' : 'Pending Distr.',
                        value: CurrencyFormatter.format(state.pendingDistributionAmount, isBangla: isBangla, compact: true),
                        icon: Icons.schedule_rounded,
                        accentColor: AppColors.warningDark,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(3),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // Essential Banking Quick Services
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isBangla ? 'দ্রুত সেবা ও নিরীক্ষা' : 'Essential Services',
                      style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla).copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    _quickActionTile(
                      icon: Icons.search_rounded,
                      label: isBangla ? 'সকল সুযোগ' : 'Invest',
                      onTap: () => onNavigateTab(1),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 8),
                    _quickActionTile(
                      icon: Icons.account_balance_outlined,
                      label: isBangla ? 'তহবিল স্বচ্ছতা' : 'Transparency',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransparencyScreen(state: state),
                          ),
                        );
                      },
                      isDark: isDark,
                    ),
                    const SizedBox(width: 8),
                    _quickActionTile(
                      icon: Icons.folder_outlined,
                      label: isBangla ? 'দলিল ভল্ট' : 'Documents',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DocumentVaultScreen(state: state),
                          ),
                        );
                      },
                      isDark: isDark,
                    ),
                    const SizedBox(width: 8),
                    _quickActionTile(
                      icon: Icons.headset_mic_outlined,
                      label: isBangla ? 'সহায়তা' : 'Support',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupportScreen(state: state),
                          ),
                        );
                      },
                      isDark: isDark,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Featured Land Opportunity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isBangla ? 'চলমান প্রকল্প' : 'Featured Opportunity',
                      style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla).copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => onNavigateTab(1),
                      child: Text(
                        isBangla ? 'সকল প্রকল্প' : 'View All',
                        style: TextStyle(
                          color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                ProjectCard(
                  project: project,
                  isBangla: isBangla,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectDetailScreen(project: project, state: state),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Recent Ledger Activity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isBangla ? 'সাম্প্রতিক হিসাব বিবরণী' : 'Recent Transactions',
                      style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla).copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => onNavigateTab(3),
                      child: Text(
                        isBangla ? 'সম্পূর্ণ লেজার' : 'Full Ledger',
                        style: TextStyle(
                          color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                ...transactions.take(3).map((txn) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TransactionTile(
                        transaction: txn,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(3),
                      ),
                    )),

                const SizedBox(height: 20),

                // Institutional Compliance Footer Notice
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : const Color(0xFFF1F5F9),
                    borderRadius: AppRadius.borderMd,
                    border: Border.all(
                      color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shield_outlined, size: 16, color: AppColors.success),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isBangla
                              ? 'স্বপ্নযাত্রী ইনভেস্টমেন্ট বাংলাদেশ ভূমি নিবন্ধন ও এসক্রো আইনের অধীনে সুরক্ষিত।'
                              : 'Swapnojatri operates under Bangladesh Real Estate & Banking Escrow regulations.',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderMd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: AppRadius.borderMd,
            border: Border.all(
              color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
              width: 0.8,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: isDark ? AppColors.accentGoldLight : AppColors.primary),
              const SizedBox(height: 6),
              Text(
                label,
                style: AppTypography.caption(isDark: isDark).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
