import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/figure.dart';
import 'package:swapnojatri/core/widgets/voucher_row.dart';
import 'package:swapnojatri/core/widgets/matra_rule_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final expenses = widget.state.expenses;

    const collected = 1887000.0;
    const spent = 2050000.0;
    const remaining = 500000.0;

    // Categorized expense vouchers
    final categories = <String, List<dynamic>>{};
    for (var exp in expenses) {
      categories.putIfAbsent(exp.category, () => []).add(exp);
    }

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
                  border: Border.all(color: palette.rule, width: 1.0),
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
              const SizedBox(height: 28),

              // 2. Single-Series Area Plot in Pine (1.5px line, 8% fill, no grid, no shadow tooltip) (§10)
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
                height: 180,
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false), // No grid lines (§10)
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (val, meta) {
                            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                            final idx = val.toInt();
                            if (idx >= 0 && idx < months.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  months[idx],
                                  style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                                    color: palette.inkTertiary,
                                    fontSize: 9.5,
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
                    maxY: 22,
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 0),
                          FlSpot(1, 15.5),
                          FlSpot(2, 18.35),
                          FlSpot(3, 19.6),
                          FlSpot(4, 20.5),
                          FlSpot(5, 20.5),
                        ],
                        isCurved: true,
                        curveSmoothness: 0.25,
                        color: palette.pine,
                        barWidth: 1.5, // 1.5px pine line (§10)
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: palette.pine.withValues(alpha: 0.08), // 8% fill (§10)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // 3. Ruled Voucher Ledger Grouped by Category with Sticky Ruled Headers (§10)
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
                        children: items.map((e) => VoucherRow(expense: e, isBangla: isBangla)).toList(),
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
