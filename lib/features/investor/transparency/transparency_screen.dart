import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/figure.dart';
import 'package:swapnojatri/core/widgets/voucher_row.dart';
import 'package:swapnojatri/core/widgets/matra_rule_widget.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
import 'package:swapnojatri/data/models/expense_model.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'ALL';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showVoucherInspector(BuildContext context, ExpenseModel expense, AppPalette palette, bool isDark, bool isBangla) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: AppRadius.borderSheet,
            border: Border.all(color: palette.ruleStrong, width: 1.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 3,
                  decoration: BoxDecoration(
                    color: palette.ruleStrong,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isBangla ? 'ভাউচার রসিদ: ${expense.voucherNo}' : 'Voucher Slip: ${expense.voucherNo}',
                        style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${isBangla ? 'তারিখ:' : 'Date:'} ${CurrencyFormatter.formatDate(expense.incurredAt, isBangla: isBangla)}',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkSecondary,
                        ),
                      ),
                    ],
                  ),
                  SealWidget(size: 38, isBangla: isBangla),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 14),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: AppRadius.borderChip,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  children: [
                    _vRow(isBangla ? 'ব্যয়ের বিবরণ' : 'Description', isBangla ? expense.descriptionBn : expense.description, palette, isDark),
                    const Divider(height: 12),
                    _vRow(isBangla ? 'অর্থপ্রাপক (Payee)' : 'Payee', expense.payee, palette, isDark),
                    const Divider(height: 12),
                    _vRow(isBangla ? 'খরচের খাত' : 'Category', expense.category, palette, isDark),
                    const Divider(height: 12),
                    _vRow(
                      isBangla ? 'অনুমোদিত পরিমাণ' : 'Approved Amount',
                      CurrencyFormatter.format(expense.amount, isBangla: isBangla),
                      palette,
                      isDark,
                      highlight: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Escrow Audit Note
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                  borderRadius: AppRadius.borderChip,
                ),
                child: Row(
                  children: [
                    Icon(Icons.verified_user_outlined, size: 16, color: palette.pine),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        isBangla
                            ? 'সিটি ব্যাংক এসক্রো হিসাব থেকে অডিটরের মূল ভাউচার ও রসিদ যাচাইকরণ শেষে ছাড়কৃত।'
                            : 'Disbursed from City Bank Escrow upon auditor verification of original tax challan/bill.',
                        style: TextStyle(fontSize: 11, color: palette.inkSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: isBangla ? 'মূল রসিদ / চালান দেখুন' : 'View Original Bill / Challan',
                      variant: AppButtonVariant.primary,
                      isBangla: isBangla,
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isBangla ? 'ভাউচার রসিদ প্রদর্শিত হচ্ছে' : 'Displaying original voucher receipt'),
                            backgroundColor: palette.pine,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 90,
                    child: AppButton(
                      label: isBangla ? 'বন্ধ' : 'Close',
                      variant: AppButtonVariant.secondary,
                      isBangla: isBangla,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _vRow(String label, String val, AppPalette palette, bool isDark, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 11.5, color: palette.inkSecondary)),
        Flexible(
          child: Text(
            val,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
              color: highlight ? palette.pine : palette.ink,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final expenses = widget.state.expenses;

    const collected = 1887000.0;
    const spent = 2050000.0;
    const remaining = 500000.0;

    // Filter expenses by search query and category
    final filteredExpenses = expenses.where((exp) {
      if (_selectedCategory != 'ALL' && exp.category != _selectedCategory) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchVoucher = exp.voucherNo.toLowerCase().contains(query);
        final matchPayee = exp.payee.toLowerCase().contains(query);
        final matchDesc = exp.description.toLowerCase().contains(query);
        final matchDescBn = exp.descriptionBn.toLowerCase().contains(query);
        if (!matchVoucher && !matchPayee && !matchDesc && !matchDescBn) return false;
      }
      return true;
    }).toList();

    // Categorized expense vouchers
    final categories = <String, List<ExpenseModel>>{};
    for (var exp in filteredExpenses) {
      categories.putIfAbsent(exp.category, () => []).add(exp);
    }

    final allCategories = ['ALL', ...expenses.map((e) => e.category).toSet()];

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'তহবিল স্বচ্ছতা ও ভাউচার লেজার' : 'Fund Transparency & Audit Ledger',
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
              // 1. LEAD: 3 Figures Separated by Vertical Hairlines (§10)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderCard,
                  border: Border.all(color: palette.rule, width: 1.0),
                  boxShadow: isDark
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Figure(
                        label: isBangla ? 'উত্তোলিত তহবিল' : 'Collected',
                        value: CurrencyFormatter.format(collected, isBangla: isBangla, compact: true),
                        isBangla: isBangla,
                      ),
                    ),
                    Container(width: 1, height: 40, color: palette.rule),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Figure(
                        label: isBangla ? 'ব্যয়িত মূলধন' : 'Committed',
                        value: CurrencyFormatter.format(spent, isBangla: isBangla, compact: true),
                        isBangla: isBangla,
                      ),
                    ),
                    Container(width: 1, height: 40, color: palette.rule),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Figure(
                        label: isBangla ? 'অবশিষ্ট স্থিতি' : 'Remaining',
                        value: CurrencyFormatter.format(remaining, isBangla: isBangla, compact: true),
                        accentColor: palette.pine,
                        isBangla: isBangla,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Single-Series Area Plot in Confident Pine (§10)
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Text(
                isBangla ? 'মাসিক তহবিল ব্যবহার প্রবাহ' : 'Monthly Fund Drawdown Trend',
                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                height: 200,
                padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderCard,
                  border: Border.all(color: palette.rule, width: 1.0),
                  boxShadow: isDark
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      enabled: true,
                      handleBuiltInTouches: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => palette.ink,
                        tooltipRoundedRadius: 8,
                        tooltipPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            final valInLakh = spot.y;
                            final amount = valInLakh * 100000;
                            final formatted = CurrencyFormatter.format(amount, isBangla: isBangla, compact: false);
                            final monthsEn = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                            final monthsBn = ['জানুয়ারি', 'ফেব্রুয়ারি', 'মার্চ', 'এপ্রিল', 'মে', 'জুন'];
                            final monthName = isBangla ? monthsBn[spot.x.toInt()] : monthsEn[spot.x.toInt()];
                            return LineTooltipItem(
                              '$monthName\n$formatted',
                              GoogleFonts.hindSiliguri(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            );
                          }).toList();
                        },
                      ),
                      getTouchedSpotIndicator: (barData, spotIndexes) {
                        return spotIndexes.map((index) {
                          return TouchedSpotIndicatorData(
                            FlLine(
                              color: const Color(0xFF0066FF).withValues(alpha: 0.5),
                              strokeWidth: 1.5,
                              dashArray: [4, 4],
                            ),
                            FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, bar, index) {
                                return FlDotCirclePainter(
                                  radius: 6,
                                  color: Colors.white,
                                  strokeWidth: 3,
                                  strokeColor: const Color(0xFF0066FF),
                                );
                              },
                            ),
                          );
                        }).toList();
                      },
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 8,
                      getDrawingHorizontalLine: (val) {
                        return FlLine(
                          color: palette.rule.withValues(alpha: 0.6),
                          strokeWidth: 0.8,
                          dashArray: [4, 4],
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 42,
                          interval: 8,
                          getTitlesWidget: (val, meta) {
                            if (val == 0) return Text('৳ 0', style: TextStyle(fontSize: 10, color: palette.inkTertiary));
                            if (val == 8) return Text(isBangla ? '৳ ৮L' : '৳ 8L', style: TextStyle(fontSize: 10, color: palette.inkTertiary));
                            if (val == 16) return Text(isBangla ? '৳ ১৬L' : '৳ 16L', style: TextStyle(fontSize: 10, color: palette.inkTertiary));
                            if (val == 24) return Text(isBangla ? '৳ ২৪L' : '৳ 24L', style: TextStyle(fontSize: 10, color: palette.inkTertiary));
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 26,
                          interval: 1,
                          getTitlesWidget: (val, meta) {
                            final monthsEn = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                            final monthsBn = ['জানু', 'ফেব্রু', 'মার্চ', 'এপ্রিল', 'মে', 'জুন'];
                            final months = isBangla ? monthsBn : monthsEn;
                            final idx = val.toInt();
                            if (idx >= 0 && idx < months.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  months[idx],
                                  style: GoogleFonts.hindSiliguri(
                                    color: palette.inkSecondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 5,
                    minY: 0,
                    maxY: 28,
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 3.2),
                          FlSpot(1, 7.5),
                          FlSpot(2, 13.8),
                          FlSpot(3, 18.2),
                          FlSpot(4, 22.0),
                          FlSpot(5, 25.5),
                        ],
                        isCurved: true,
                        curveSmoothness: 0.35,
                        color: const Color(0xFF0066FF),
                        barWidth: 3.2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) {
                            return FlDotCirclePainter(
                              radius: 4.5,
                              color: Colors.white,
                              strokeWidth: 2.5,
                              strokeColor: const Color(0xFF0066FF),
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF0066FF).withValues(alpha: isDark ? 0.30 : 0.18),
                              const Color(0xFF0066FF).withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // 3. Search & Category Filters
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Text(
                isBangla ? 'অনুমোদিত ব্যয়ের খতিয়ান' : 'Audited Voucher Ledger',
                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),

              // Search Input
              Container(
                height: 42,
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderControl,
                  border: Border.all(color: palette.ruleStrong, width: 1.0),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val.trim()),
                  style: AppTypography.bodyStrong(isDark: isDark).copyWith(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: isBangla ? 'ভাউচার নং বা প্রাপকের নাম খুঁজুন...' : 'Search by voucher no or payee...',
                    hintStyle: AppTypography.caption(isDark: isDark).copyWith(color: palette.inkTertiary),
                    prefixIcon: Icon(Icons.search_rounded, size: 18, color: palette.inkTertiary),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 16),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 11),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Category Pills
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: allCategories.map((cat) {
                    final isSel = _selectedCategory == cat;
                    return InkWell(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() => _selectedCategory = cat);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSel ? palette.pine : palette.surface,
                          border: Border.all(color: isSel ? palette.pine : palette.rule, width: 1.0),
                          borderRadius: AppRadius.borderChip,
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                            color: isSel ? Colors.white : palette.inkSecondary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),

              // 4. Ruled Voucher Rows
              if (categories.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      isBangla ? 'কোনো ভাউচার পাওয়া যায়নি' : 'No matching vouchers found',
                      style: TextStyle(color: palette.inkSecondary, fontSize: 13),
                    ),
                  ),
                )
              else
                ...categories.entries.map((entry) {
                  final categoryName = entry.key;
                  final items = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sticky Ruled Category Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: palette.surfaceSunken,
                          border: Border.all(color: palette.ruleStrong, width: 0.8),
                        ),
                        child: Text(
                          categoryName.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: palette.inkSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      // Ruled Voucher Rows
                      Container(
                        decoration: BoxDecoration(
                          color: palette.surface,
                          border: Border(
                            left: BorderSide(color: palette.rule, width: 1.0),
                            right: BorderSide(color: palette.rule, width: 1.0),
                            bottom: BorderSide(color: palette.rule, width: 1.0),
                          ),
                        ),
                        child: Column(
                          children: items
                              .map(
                                (e) => InkWell(
                                  onTap: () => _showVoucherInspector(context, e, palette, isDark, isBangla),
                                  child: VoucherRow(
                                    expense: e,
                                    isBangla: isBangla,
                                    onViewBillTap: () => _showVoucherInspector(context, e, palette, isDark, isBangla),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
