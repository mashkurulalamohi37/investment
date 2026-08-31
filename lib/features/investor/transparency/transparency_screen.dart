import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/expense_tile.dart';
import 'package:swapnojatri/core/widgets/animated_count_text.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class TransparencyScreen extends StatefulWidget {
  final AppState state;

  const TransparencyScreen({
    super.key,
    required this.state,
  });

  @override
  State<TransparencyScreen> createState() => _TransparencyScreenState();
}

class _TransparencyScreenState extends State<TransparencyScreen> {
  int _touchedIndex = -1;

  final List<Map<String, dynamic>> _chartData = [
    {
      'titleEn': 'Land Acquisition (22.5 Decimals)',
      'titleBn': 'জমি ক্রয় (২২.৫ শতাংশ)',
      'value': 1550000.0,
      'pct': '75.6%',
      'color': Color(0xFF0D3B2E),
    },
    {
      'titleEn': 'Sub-Registry & Govt Taxes',
      'titleBn': 'সাব-রেজিস্ট্রি ও সরকারি কর',
      'value': 285000.0,
      'pct': '13.9%',
      'color': AppColors.accentGold,
    },
    {
      'titleEn': 'Boundary Wall & Earth Filling',
      'titleBn': 'সীমানা প্রাচীর ও মাটি ভরাট',
      'value': 125000.0,
      'pct': '6.1%',
      'color': AppColors.success,
    },
    {
      'titleEn': 'Legal Vetting & Administration',
      'titleBn': 'আইনি যাচাই ও প্রশাসনিক ব্যয়',
      'value': 90000.0,
      'pct': '4.4%',
      'color': AppColors.info,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;

    final targetFund = widget.state.landVest100.targetFund;
    final collected = widget.state.totalProjectCollected;
    final utilized = widget.state.totalProjectExpenses;
    final remaining = (targetFund - utilized).clamp(0.0, targetFund);

    final expenses = widget.state.expenses;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'লাইভ তহবিল স্বচ্ছতা ও হিসাব' : 'Live Fund Transparency',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBangla ? 'তহবিল অডিট প্রতিবেদন প্রস্তুত হচ্ছে' : 'Audited fund report is being generated...'),
                ),
              );
            },
            icon: const Icon(Icons.picture_as_pdf_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last updated banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.1),
                borderRadius: AppRadius.borderMd,
                border: Border.all(
                  color: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_outlined, size: 16, color: AppColors.success),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isBangla
                          ? 'সর্বশেষ আপডেট: ৩১ আগস্ট ২০২৬, রাত ১১:১৫ • অডিটর: হুসাইন অ্যান্ড অ্যাসোসিয়েটস'
                          : 'Last Verified: 31 Aug 2026, 11:15 PM • Audited by Hossain & Associates',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4-Card Balance Grid with AnimatedCountText
            Row(
              children: [
                Expanded(
                  child: _balanceCard(
                    title: isBangla ? 'লক্ষ্যমাত্রা তহবিল' : 'Opening Target',
                    amount: targetFund,
                    isDark: isDark,
                    isBangla: isBangla,
                    accentColor: isDark ? AppColors.accentGoldLight : AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _balanceCard(
                    title: isBangla ? 'সংগৃহীত মূলধন' : 'Total Collected',
                    amount: collected,
                    isDark: isDark,
                    isBangla: isBangla,
                    accentColor: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _balanceCard(
                    title: isBangla ? 'অনুমোদিত ব্যয়' : 'Total Utilized',
                    amount: utilized,
                    isDark: isDark,
                    isBangla: isBangla,
                    accentColor: AppColors.warningDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _balanceCard(
                    title: isBangla ? 'তহবিল স্থিতি' : 'Remaining Balance',
                    amount: remaining,
                    isDark: isDark,
                    isBangla: isBangla,
                    accentColor: AppColors.info,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Interactive Fund Utilization Breakdown Visualizer
            Text(
              isBangla ? 'খাতভিত্তিক ব্যয় বণ্টন চার্ট' : 'Fund Utilization by Category',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 190,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                _touchedIndex = -1;
                                return;
                              }
                              _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        sectionsSpace: 3,
                        centerSpaceRadius: 44,
                        sections: List.generate(_chartData.length, (i) {
                          final isTouched = i == _touchedIndex;
                          final data = _chartData[i];
                          final radius = isTouched ? 56.0 : 46.0;
                          return PieChartSectionData(
                            value: data['value'] as double,
                            color: data['color'] as Color,
                            title: data['pct'] as String,
                            radius: radius,
                            titleStyle: TextStyle(
                              fontSize: isTouched ? 13 : 11,
                              fontWeight: FontWeight.bold,
                              color: data['color'] == AppColors.accentGold ? AppColors.primaryDark : Colors.white,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 14),

                  // Dynamic Category List Breakdown
                  ...List.generate(_chartData.length, (i) {
                    final item = _chartData[i];
                    final isHighlighted = _touchedIndex == i;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: isHighlighted
                          ? BoxDecoration(
                              color: (item['color'] as Color).withValues(alpha: 0.15),
                              borderRadius: AppRadius.borderSm,
                            )
                          : null,
                      child: _legendItem(
                        item['color'] as Color,
                        isBangla ? item['titleBn'] as String : item['titleEn'] as String,
                        CurrencyFormatter.format(item['value'] as double, isBangla: isBangla),
                        isDark,
                        isBangla,
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Live Expense Voucher Trail
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isBangla ? 'অনুমোদিত ব্যয় ভাউচার তালিকা' : 'Expense Voucher Audit Trail',
                  style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                ),
                Text(
                  '${expenses.length} Vouchers',
                  style: AppTypography.caption(isDark: isDark).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            ...expenses.map((expense) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpenseTile(
                    expense: expense,
                    isBangla: isBangla,
                    onViewBillTap: () {
                      _showVoucherBillInspectionModal(context, expense.voucherNo, isDark, isBangla);
                    },
                  ),
                )),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showVoucherBillInspectionModal(BuildContext context, String voucherNo, bool isDark, bool isBangla) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'অনুমোদিত ভাউচার ও রসিদ' : 'Verified Voucher & Bill Receipt',
                      style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                    ),
                    Text(
                      voucherNo,
                      style: AppTypography.caption(isDark: isDark).copyWith(fontFamily: 'monospace', fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.grey.shade100,
                borderRadius: AppRadius.borderLg,
                border: Border.all(color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.verified_rounded, size: 48, color: AppColors.success),
                    const SizedBox(height: 12),
                    Text(
                      'Official Sub-Registry Government Challan',
                      style: AppTypography.headingSmall(isDark: isDark).copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SHA-256: 4f8b9e1c3a7d2f5e0b6a8c4d2e1f3a5b',
                      style: AppTypography.caption(isDark: isDark).copyWith(fontFamily: 'monospace', fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _balanceCard({
    required String title,
    required double amount,
    required bool isDark,
    required bool isBangla,
    Color? accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: AppRadius.borderMd,
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          AnimatedCountText(
            endValue: amount,
            isBangla: isBangla,
            style: AppTypography.financialAmountSmall(isDark: isDark, color: accentColor).copyWith(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String title, String amount, bool isDark, bool isBangla) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 11.5),
            ),
          ],
        ),
        Text(
          amount,
          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 11.5,
          ),
        ),
      ],
    );
  }
}
