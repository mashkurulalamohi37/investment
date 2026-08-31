import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
            await Future.delayed(const Duration(milliseconds: 600));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: Greeting, User Avatar & Notification Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(user.avatarUrl),
                          backgroundColor: AppColors.primarySubtle,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isBangla ? 'শুভ সন্ধ্যা,' : 'Good Evening,',
                              style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                            ),
                            Text(
                              user.name.split(' ').first,
                              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla).copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Language Toggle Button
                        IconButton(
                          onPressed: () => state.toggleLanguage(),
                          icon: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkCard : Colors.white,
                              borderRadius: AppRadius.borderSm,
                              border: Border.all(
                                color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                              ),
                            ),
                            child: Text(
                              isBangla ? 'EN' : 'বাং',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        // Notifications Bell
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
                              icon: const Icon(Icons.notifications_outlined),
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                            ),
                            if (state.unreadNotificationCount > 0)
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  width: 8,
                                  height: 8,
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
                ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1, end: 0),
                const SizedBox(height: 20),

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
                ).animate().fadeIn(duration: 500.ms, delay: 100.ms).slideY(begin: 0.08, end: 0),
                const SizedBox(height: 20),

                // 4-Grid Financial KPI Cards
                Row(
                  children: [
                    Expanded(
                      child: KpiCard(
                        label: isBangla ? 'চলমান বিনিয়োগ' : 'Active Projects',
                        value: isBangla ? '১ টি প্রকল্প' : '1 Project',
                        icon: Icons.terrain_rounded,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: KpiCard(
                        label: isBangla ? 'মোট শেয়ার লট' : 'Total Shares',
                        value: isBangla
                            ? '${CurrencyFormatter.toBanglaDigits(state.totalSharesOwned.toString())} টি শেয়ার'
                            : '${state.totalSharesOwned} Shares',
                        icon: Icons.pie_chart_rounded,
                        accentColor: isDark ? AppColors.accentGoldLight : AppColors.accentGoldDark,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(2),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: 0.08, end: 0),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: KpiCard(
                        label: isBangla ? 'অর্জিত লভ্যাংশ' : 'Realized Profit',
                        value: CurrencyFormatter.format(state.totalRealizedProfit, isBangla: isBangla, compact: true),
                        icon: Icons.trending_up_rounded,
                        accentColor: AppColors.success,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(3),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: KpiCard(
                        label: isBangla ? 'প্রক্রিয়াধীন লভ্যাংশ' : 'Pending Distr.',
                        value: CurrencyFormatter.format(state.pendingDistributionAmount, isBangla: isBangla, compact: true),
                        icon: Icons.hourglass_top_rounded,
                        accentColor: AppColors.warningDark,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(3),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 500.ms, delay: 280.ms).slideY(begin: 0.08, end: 0),

                const SizedBox(height: 24),

                // Quick Actions Horizontal Grid
                Text(
                  isBangla ? 'দ্রুত সেবা ও ফিচার' : 'Quick Actions',
                  style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                ).animate().fadeIn(duration: 400.ms, delay: 320.ms),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _quickActionButton(
                      icon: Icons.search_rounded,
                      label: isBangla ? 'প্রকল্পসমূহ' : 'Projects',
                      onTap: () => onNavigateTab(1),
                      isDark: isDark,
                    ),
                    _quickActionButton(
                      icon: Icons.query_stats_rounded,
                      label: isBangla ? 'স্বচ্ছতা' : 'Transparency',
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
                    _quickActionButton(
                      icon: Icons.folder_shared_rounded,
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
                    _quickActionButton(
                      icon: Icons.support_agent_rounded,
                      label: isBangla ? 'সাপোর্ট' : 'Support',
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
                ).animate().fadeIn(duration: 500.ms, delay: 360.ms).slideY(begin: 0.08, end: 0),

                const SizedBox(height: 28),

                // Spotlight Opportunity: LandVest 100
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isBangla ? 'চলমান বিনিয়োগ প্রকল্প' : 'Featured Opportunity',
                      style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                    ),
                    TextButton(
                      onPressed: () => onNavigateTab(1),
                      child: Text(
                        isBangla ? 'সব দেখুন' : 'View All',
                        style: TextStyle(
                          color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
                const SizedBox(height: 8),

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
                ).animate().fadeIn(duration: 500.ms, delay: 440.ms).slideY(begin: 0.08, end: 0),

                const SizedBox(height: 28),

                // Recent Transactions Activity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isBangla ? 'সাম্প্রতিক আর্থিক লেনদেন' : 'Recent Transactions',
                      style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                    ),
                    TextButton(
                      onPressed: () => onNavigateTab(3),
                      child: Text(
                        isBangla ? 'লেজার দেখুন' : 'Full Ledger',
                        style: TextStyle(
                          color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms, delay: 480.ms),
                const SizedBox(height: 8),

                ...transactions.take(3).map((txn) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TransactionTile(
                        transaction: txn,
                        isBangla: isBangla,
                        onTap: () => onNavigateTab(3),
                      ),
                    )).toList().animate().fadeIn(duration: 500.ms, delay: 520.ms).slideY(begin: 0.08, end: 0),

                const SizedBox(height: 24),

                // Legal Compliance Footer Notice
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightDivider,
                    borderRadius: AppRadius.borderMd,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shield_outlined, size: 16, color: AppColors.lightTextMuted),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isBangla
                              ? 'স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম সম্পূর্ণ আইনি বিধিমালা ও স্বচ্ছতার সাথে পরিচালিত।'
                              : 'Swapnojatri operates in compliance with Bangladesh legal and financial regulations.',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.borderMd,
      child: Container(
        width: 76,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: AppRadius.borderMd,
          border: Border.all(
            color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: isDark ? AppColors.accentGoldLight : AppColors.primary),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
