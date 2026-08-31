import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/kpi_card.dart';
import 'package:swapnojatri/core/widgets/share_grid_matrix_widget.dart';
import 'package:swapnojatri/data/models/user_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/admin/modules/investments_manager_screen.dart';
import 'package:swapnojatri/features/admin/modules/expense_manager_screen.dart';
import 'package:swapnojatri/features/admin/modules/kyc_approvals_screen.dart';
import 'package:swapnojatri/features/admin/modules/audit_logs_screen.dart';
import 'package:swapnojatri/features/admin/modules/reports_screen.dart';
import 'package:swapnojatri/features/investor/transparency/transparency_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AppState state;

  const AdminDashboardScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final user = state.currentUser;

    final totalInvestors = state.adminTotalInvestors;
    final totalCollection = state.adminTotalCollection;
    final utilizationPct = (state.adminFundUtilizationPercentage * 100).toInt();
    final pendingPayments = state.adminPendingPaymentsCount;
    final pendingKyc = state.adminPendingKycCount;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.accentGold,
                borderRadius: AppRadius.borderXs,
              ),
              child: const Text(
                'ADMIN',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              isBangla ? 'অ্যাডমিন ড্যাশবোর্ড' : 'Management Console',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
          ],
        ),
        actions: [
          // Switch back to Investor Mode
          TextButton.icon(
            onPressed: () {
              state.switchRole(UserRole.investor);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBangla ? 'বিনিয়োগকারী মোডে ফিরে যাওয়া হয়েছে' : 'Switched to Investor Portal'),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_rounded, size: 16),
            label: Text(
              isBangla ? 'বিনিয়োগকারী ভিউ' : 'Investor View',
              style: TextStyle(
                color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin Profile Ribbon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isDark
                    ? const LinearGradient(colors: [Color(0xFF261D0A), Color(0xFF0F0C05)])
                    : const LinearGradient(colors: [Color(0xFFFEF3C7), Color(0xFFFFFBEB)]),
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: AppColors.accentGold.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(user.avatarUrl),
                    backgroundColor: AppColors.accentGoldMuted,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: AppTypography.headingSmall(isDark: isDark).copyWith(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Super Admin & Finance Manager • Swapnojatri Platform',
                          style: AppTypography.caption(isDark: isDark).copyWith(
                            color: isDark ? AppColors.accentGoldLight : AppColors.accentGoldDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Top Executive KPI Grid
            Row(
              children: [
                Expanded(
                  child: KpiCard(
                    label: isBangla ? 'মোট বিনিয়োগকারী' : 'Total Investors',
                    value: isBangla ? '${CurrencyFormatter.toBanglaDigits(totalInvestors.toString())} জন' : '$totalInvestors Active',
                    icon: Icons.groups_rounded,
                    isBangla: isBangla,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: KpiCard(
                    label: isBangla ? 'মোট সংগৃহীত তহবিল' : 'Total Collection',
                    value: CurrencyFormatter.format(totalCollection, isBangla: isBangla, compact: true),
                    icon: Icons.account_balance_wallet_rounded,
                    accentColor: AppColors.success,
                    isBangla: isBangla,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: KpiCard(
                    label: isBangla ? 'তহবিল ব্যবহার হার' : 'Fund Utilization',
                    value: '$utilizationPct%',
                    icon: Icons.donut_large_rounded,
                    accentColor: AppColors.warningDark,
                    isBangla: isBangla,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: KpiCard(
                    label: isBangla ? 'যাচাইাধীন পেমেন্ট' : 'Pending Verification',
                    value: '$pendingPayments Requests',
                    icon: Icons.hourglass_top_rounded,
                    accentColor: pendingPayments > 0 ? AppColors.error : AppColors.success,
                    isBangla: isBangla,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminInvestmentsManagerScreen(state: state)),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Operational Management Modules
            Text(
              isBangla ? 'প্রশাসনিক মডিউল ও নিয়ন্ত্রণ' : 'Operational Management Modules',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 14),

            _adminModuleCard(
              icon: Icons.assignment_turned_in_rounded,
              title: isBangla ? 'বিনিয়োগ ও শেয়ার লট বরাদ্দ' : 'Investments & Share Allocation',
              subtitle: isBangla ? 'পেমেন্ট যাচাই ও স্বয়ংক্রিয় লট প্রদান' : 'Verify bank slips & assign lots',
              badge: pendingPayments > 0 ? '$pendingPayments New' : null,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminInvestmentsManagerScreen(state: state)),
                );
              },
              isDark: isDark,
            ),
            _adminModuleCard(
              icon: Icons.receipt_long_rounded,
              title: isBangla ? 'তহবিল ব্যবহার ও খরচ অনুমোদন' : 'Expense & Fund Ledger',
              subtitle: isBangla ? 'ভাউচার তৈরি ও ব্যালেন্স সমন্বয়' : 'Create vouchers & post expenses',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminExpenseManagerScreen(state: state)),
                );
              },
              isDark: isDark,
            ),
            _adminModuleCard(
              icon: Icons.verified_user_rounded,
              title: isBangla ? 'কেওয়াইসি ও বিনিয়োগকারী অনুমোদন' : 'KYC & Compliance Queue',
              subtitle: isBangla ? 'এনআইডি ও ব্যাংক যাচাই' : 'Verify identity & nominees',
              badge: pendingKyc > 0 ? '$pendingKyc Pending' : null,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminKycApprovalsScreen(state: state)),
                );
              },
              isDark: isDark,
            ),
            _adminModuleCard(
              icon: Icons.query_stats_rounded,
              title: isBangla ? 'লাইভ তহবিল স্বচ্ছতা ড্যাশবোর্ড' : 'Live Fund Transparency',
              subtitle: isBangla ? 'পাবলিক ভল্ট ও চার্ট নিরীক্ষা' : 'Real-time project financials',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransparencyScreen(state: state)),
                );
              },
              isDark: isDark,
            ),
            _adminModuleCard(
              icon: Icons.security_rounded,
              title: isBangla ? 'অডিট লগ ও নিরাপত্তা ট্রেইল' : 'Immutable Audit Logs',
              subtitle: isBangla ? 'আইপি, ইউজার ও সময়সহ লগ' : 'Searchable system logs',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminAuditLogsScreen(state: state)),
                );
              },
              isDark: isDark,
            ),
            _adminModuleCard(
              icon: Icons.grid_view_rounded,
              title: isBangla ? '১০০ শেয়ার লট ম্যাট্রিক্স পরিদর্শক' : '100-Share Lot Matrix Inspector',
              subtitle: isBangla ? 'প্রতিটি লটের মালিকানা ও স্ট্যাটাস ম্যাপ' : 'Visual breakdown of all 100 share lots',
              onTap: () {
                _showLotMatrixInspector(context, isDark, isBangla);
              },
              isDark: isDark,
            ),
            _adminModuleCard(
              icon: Icons.analytics_rounded,
              title: isBangla ? 'আর্থিক ও অডিট রিপোর্ট এক্সপোর্ট' : 'Reports & Exports Console',
              subtitle: isBangla ? 'পিডিএফ ও সিএসভি ডাউনলোড' : 'Export statements & matrices',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminReportsScreen(state: state)),
                );
              },
              isDark: isDark,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showLotMatrixInspector(BuildContext context, bool isDark, bool isBangla) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isBangla ? 'ল্যান্ডভেস্ট ১০০ শেয়ার লট রেজিস্টার' : 'LandVest 100 Lot Register',
                  style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ShareGridMatrixWidget(
              totalShares: state.landVest100.totalShares,
              allocatedShares: state.landVest100.allocatedShares,
              isInteractive: false,
              isBangla: isBangla,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _adminModuleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    String? badge,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: AppRadius.borderMd,
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.15),
            borderRadius: AppRadius.borderSm,
          ),
          child: Icon(icon, color: isDark ? AppColors.accentGoldLight : AppColors.primary, size: 22),
        ),
        title: Text(
          title,
          style: AppTypography.headingSmall(isDark: isDark).copyWith(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(subtitle, style: AppTypography.caption(isDark: isDark)),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: AppRadius.borderFull,
                ),
                child: Text(
                  badge,
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              )
            : const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.lightTextMuted),
        onTap: onTap,
      ),
    );
  }
}
