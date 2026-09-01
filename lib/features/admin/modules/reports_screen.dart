import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AdminReportsScreen extends StatelessWidget {
  final AppState state;

  const AdminReportsScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;

    final reportTypes = [
      {'title': 'Project Collection & Allocation Summary', 'sub': 'LandVest 100 100-share matrix', 'format': 'PDF / CSV'},
      {'title': 'Payment Reconciliation & Deposit Slips', 'sub': 'City Bank, BRAC, bKash ledgers', 'format': 'CSV / Excel'},
      {'title': 'Fund Utilization & Expense Voucher Book', 'sub': 'Sub-Registry, Deeds, Fencing', 'format': 'PDF Book'},
      {'title': 'Investor Dividend Payout Entitlements', 'sub': 'H1/H2 2026 distribution records', 'format': 'PDF / CSV'},
      {'title': 'Asset Valuation & Mutation Register', 'sub': 'Plot 418 Savar 22.5 Decimals', 'format': 'PDF Statement'},
    ];

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          isBangla ? 'আর্থিক ও অডিট প্রতিবেদন এক্সপোর্ট' : 'Reports & Exports',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
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
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'অফিসিয়াল প্রতিবেদন তৈরি করুন' : 'Generate Regulatory Reports',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 14),

            ...reportTypes.map((rep) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: AppRadius.borderCard,
                    border: Border.all(
                      color: palette.rule,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: palette.pineTint,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.analytics_rounded, color: palette.pine, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rep['title']!,
                              style: AppTypography.headingSmall(isDark: isDark).copyWith(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              rep['sub']!,
                              style: AppTypography.caption(isDark: isDark),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Generating and downloading ${rep['title']} (${rep['format']})...'),
                              backgroundColor: palette.pine,
                            ),
                          );
                        },
                        icon: const Icon(Icons.download_rounded),
                        color: palette.pine,
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
