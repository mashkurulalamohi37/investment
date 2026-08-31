import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/holding_card.dart';
import 'package:swapnojatri/core/widgets/matra_rule_widget.dart';
import 'package:swapnojatri/core/widgets/project_card.dart';
import 'package:swapnojatri/core/widgets/ledger_row.dart';
import 'package:swapnojatri/core/widgets/document_card.dart';
import 'package:swapnojatri/core/widgets/figure.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/project_detail/project_detail_screen.dart';
import 'package:swapnojatri/features/investor/transparency/transparency_screen.dart';
import 'package:swapnojatri/features/investor/document_vault/document_vault_screen.dart';
import 'package:swapnojatri/features/investor/notifications/notifications_screen.dart';

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
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final project = state.landVest100;
    final transactions = state.transactions;
    final documents = state.documents;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'স্বপ্নযাত্রী • প্লট ৪১৮' : 'Swapnojatri • Plot 418',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          // Language Switcher
          TextButton(
            onPressed: () => state.toggleLanguage(),
            child: Text(
              isBangla ? 'EN' : 'বাং',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: palette.pine,
              ),
            ),
          ),

          // Notifications
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen(state: state)),
              );
            },
            icon: Stack(
              children: [
                Icon(Icons.notifications_none_rounded, size: 20, color: palette.ink),
                if (state.unreadNotificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: palette.vermilion, shape: BoxShape.circle),
                    ),
                  ),
              ],
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
              // 1. Holding Card (Hero)
              HoldingCard(
                totalInvested: state.totalInvested,
                totalShares: state.totalSharesOwned,
                realizedProfit: state.totalRealizedProfit,
                isBangla: isBangla,
                onExploreTap: () => onNavigateTab(1),
                onTransparencyTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransparencyScreen(state: state)),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Quick Action Shortcuts Bar
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _homeQuickAction(
                      icon: Icons.grid_view_rounded,
                      label: isBangla ? 'আমার লট (৪১-৪৪)' : 'My Lots (41-44)',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailScreen(project: project, state: state),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    _homeQuickAction(
                      icon: Icons.account_balance_wallet_outlined,
                      label: isBangla ? 'তহবিল স্বচ্ছতা' : 'Treasury Ledger',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TransparencyScreen(state: state)),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    _homeQuickAction(
                      icon: Icons.folder_open_outlined,
                      label: isBangla ? 'দলিল ভল্ট' : 'Document Vault',
                      palette: palette,
                      isDark: isDark,
                      onTap: () => onNavigateTab(2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 2. Matra Rule + Plot 418 Section with Lot Map Miniature & Funding Line
              MatraRuleWidget(width: 32, color: palette.pine, animate: true),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'প্লট ৪১৮ সুযোগ' : 'Plot 418 Holding',
                    style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailScreen(project: project, state: state),
                        ),
                      );
                    },
                    child: Text(
                      isBangla ? 'নকশা ও বিস্তারিত' : 'View survey & details',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                        color: palette.pine,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

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
              const SizedBox(height: 32),

              // 3. Fund Transparency Section (Remaining Balance Figure)
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'তহবিল ও ব্যয় নিরীক্ষা' : 'Fund Transparency & Audit',
                    style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransparencyScreen(state: state)),
                      );
                    },
                    child: Text(
                      isBangla ? 'ভাউচার খতিয়ান' : 'Voucher ledger',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                        color: palette.pine,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

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
                        label: isBangla ? 'উত্তোলিত তহবিল' : 'Collected',
                        value: CurrencyFormatter.format(1887000, isBangla: isBangla, compact: true),
                        isBangla: isBangla,
                      ),
                    ),
                    Container(width: 1, height: 36, color: palette.rule),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Figure(
                        label: isBangla ? 'ব্যয়িত মূলধন' : 'Committed',
                        value: CurrencyFormatter.format(2050000, isBangla: isBangla, compact: true),
                        isBangla: isBangla,
                      ),
                    ),
                    Container(width: 1, height: 36, color: palette.rule),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Figure(
                        label: isBangla ? 'অবশিষ্ট স্থিতি' : 'Remaining',
                        value: CurrencyFormatter.format(500000, isBangla: isBangla, compact: true),
                        accentColor: palette.pine,
                        isBangla: isBangla,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 4. Recent Activity (4 Ruled Ledger Rows)
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'সাম্প্রতিক হিসাব বিবরণী' : 'Recent Activity',
                    style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () => onNavigateTab(3),
                    child: Text(
                      isBangla ? 'সম্পূর্ণ লেজার' : 'All transactions',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                        color: palette.pine,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  children: [
                    ...transactions.take(4).map((txn) => LedgerRow(
                          transaction: txn,
                          isBangla: isBangla,
                          onTap: () => onNavigateTab(3),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 5. Sealed Legal Documents (2 Most Recent)
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'আইনি ও দলিল ভল্ট' : 'Legal & Title Vault',
                    style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DocumentVaultScreen(state: state)),
                      );
                    },
                    child: Text(
                      isBangla ? 'সকল দলিল' : 'All documents',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                        color: palette.pine,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ...documents.take(2).map((doc) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: DocumentCard(
                      document: doc,
                      isBangla: isBangla,
                      onDownload: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isBangla ? 'দলিল ডাউনলোড হচ্ছে...' : 'Downloading document...'),
                            backgroundColor: palette.pine,
                          ),
                        );
                      },
                    ),
                  )),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeQuickAction({
    required IconData icon,
    required String label,
    required AppPalette palette,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: AppRadius.borderControl,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: AppRadius.borderControl,
          border: Border.all(color: palette.rule, width: 1.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: palette.pine),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: palette.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
