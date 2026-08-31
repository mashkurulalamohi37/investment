import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/lot_map_widget.dart';
import 'package:swapnojatri/core/widgets/figure.dart';
import 'package:swapnojatri/core/widgets/matra_rule_widget.dart';
import 'package:swapnojatri/data/models/user_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/admin/modules/investments_manager_screen.dart';
import 'package:swapnojatri/features/admin/modules/expense_manager_screen.dart';
import 'package:swapnojatri/features/admin/modules/kyc_approvals_screen.dart';
import 'package:swapnojatri/features/admin/modules/audit_logs_screen.dart';
import 'package:swapnojatri/features/admin/modules/reports_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AppState state;

  const AdminDashboardScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;

    final totalInvestors = state.adminTotalInvestors;
    final totalCollection = state.adminTotalCollection;
    final pendingPayments = state.adminPendingPaymentsCount;
    final pendingKyc = state.adminPendingKycCount;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: AppRadius.borderChip,
                border: Border.all(color: palette.ruleStrong, width: 1.0),
              ),
              child: Text(
                'ADMIN',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: palette.pine,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isBangla ? 'প্রশাসক কনসোল' : 'Management Console',
              style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => state.switchRole(UserRole.investor),
            child: Text(
              isBangla ? 'বিনিয়োগকারী ভিউ' : 'Investor View',
              style: TextStyle(color: palette.pine, fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Operational Metrics Grid (Dense 4-Grid Figure blocks)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Figure(
                            label: isBangla ? 'মোট সংগৃহীত মূলধন' : 'Total Collection',
                            value: CurrencyFormatter.format(totalCollection, isBangla: isBangla, compact: true),
                            isBangla: isBangla,
                          ),
                        ),
                        Container(width: 1, height: 36, color: palette.rule),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Figure(
                            label: isBangla ? 'মোট বিনিয়োগকারী' : 'Active Investors',
                            value: isBangla ? '${CurrencyFormatter.toBanglaDigits(totalInvestors.toString())} জন' : '$totalInvestors Investors',
                            isBangla: isBangla,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Figure(
                            label: isBangla ? 'পেমেন্ট যাচাই অপেক্ষমাণ' : 'Pending Verification',
                            value: isBangla ? '${CurrencyFormatter.toBanglaDigits(pendingPayments.toString())} টি' : '$pendingPayments Pending',
                            accentColor: palette.amberInk,
                            isBangla: isBangla,
                          ),
                        ),
                        Container(width: 1, height: 36, color: palette.rule),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Figure(
                            label: isBangla ? 'কেওয়াইসি রিভিউ বাকি' : 'Pending KYC',
                            value: isBangla ? '${CurrencyFormatter.toBanglaDigits(pendingKyc.toString())} টি' : '$pendingKyc Pending',
                            accentColor: palette.amberInk,
                            isBangla: isBangla,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 100-Share Cadastral Map Inspector (§10)
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Text(
                isBangla ? '১০০টি শেয়ার লট বরাদ্দ মানচিত্র' : '100-Lot Cadastral Inspector',
                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),

              LotMapWidget(
                totalShares: state.landVest100.totalShares,
                allocatedShares: state.landVest100.allocatedShares,
                userLots: const ['LOT-041', 'LOT-042', 'LOT-043', 'LOT-044'],
                isBangla: isBangla,
                isInteractive: true,
              ),
              const SizedBox(height: 24),

              // Dense 44px Management Rows (§10)
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Text(
                isBangla ? 'প্রশাসনিক মডিউল ও অডিট লগ' : 'Management Modules & Registers',
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
                  children: [
                    _denseAdminRow(
                      title: isBangla ? 'বিনিয়োগ ও লট বরাদ্দ ইঞ্জিন' : 'Payment Verification & Lot Allocation',
                      badge: '$pendingPayments',
                      badgeColor: palette.amberInk,
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminInvestmentsManagerScreen(state: state)),
                        );
                      },
                    ),
                    _denseAdminRow(
                      title: isBangla ? 'ব্যয় ভাউচার ও খতিয়ান ব্যবস্থাপনা' : 'Expense Voucher & Treasury Register',
                      badge: '৳ 20.5L',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminExpenseManagerScreen(state: state)),
                        );
                      },
                    ),
                    _denseAdminRow(
                      title: isBangla ? 'কেওয়াইসি ও কমপ্লায়েন্স অনুমোদন' : 'KYC Verification Queue',
                      badge: '$pendingKyc',
                      badgeColor: palette.amberInk,
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminKycApprovalsScreen(state: state)),
                        );
                      },
                    ),
                    _denseAdminRow(
                      title: isBangla ? 'অপরিবর্তনীয় নিরাপত্তা অডিট লগ' : 'Immutable Security Audit Logs',
                      badge: '${state.auditLogs.length}',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminAuditLogsScreen(state: state)),
                        );
                      },
                    ),
                    _denseAdminRow(
                      title: isBangla ? 'নিয়ন্ত্রক ও অডিট রিপোর্ট জেনারেটর' : 'Regulatory & Tax Reports (PDF/CSV)',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminReportsScreen(state: state)),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _denseAdminRow({
    required String title,
    String? badge,
    Color? badgeColor,
    required AppPalette palette,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTypography.bodyStrong(isDark: isDark).copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (badge != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: AppRadius.borderChip,
                  border: Border.all(color: badgeColor ?? palette.rule, width: 0.8),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: badgeColor ?? palette.inkSecondary,
                  ),
                ),
              ),
            Icon(Icons.chevron_right_rounded, size: 16, color: palette.inkTertiary),
          ],
        ),
      ),
    );
  }
}
