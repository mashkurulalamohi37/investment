import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AppState state;
  final Function(int)? onNavigateTab;

  const AdminDashboardScreen({
    super.key,
    required this.state,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = state.isBangla;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isBangla ? 'ড্যাশবোর্ড' : 'Admin Dashboard',
          style: GoogleFonts.hindSiliguri(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, size: 22, color: palette.ink),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              Text(
                isBangla ? 'ওভারভিউ (সামগ্রিক চিত্র)' : 'Overview Summary',
                style: GoogleFonts.hindSiliguri(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: palette.inkSecondary,
                ),
              ),
              const SizedBox(height: 12),

              // 4 Metric KPI Cards (2x2 Grid)
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.apartment_rounded,
                      title: isBangla ? 'মোট প্রজেক্ট' : 'Total Projects',
                      value: '12',
                      actionText: 'View all',
                      color: const Color(0xFF0066FF),
                      palette: palette,
                      onTap: () {
                        if (onNavigateTab != null) onNavigateTab!(1);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.people_outline_rounded,
                      title: isBangla ? 'মোট ইউজার' : 'Total Users',
                      value: '1,248',
                      actionText: 'View all',
                      color: const Color(0xFF00B4D8),
                      palette: palette,
                      onTap: () {
                        if (onNavigateTab != null) onNavigateTab!(2);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildGrowthCard(
                      title: isBangla ? 'সংগৃহীত তহবিল' : 'Total Raised',
                      value: '৳ 2,45,36,000',
                      growth: '+ 12.5%',
                      palette: palette,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildGrowthCard(
                      title: isBangla ? 'মোট মুনাফা' : 'Total Profit',
                      value: '৳ 18,75,450',
                      growth: '+ 9.7%',
                      palette: palette,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Investment Line Chart Box ("বিনিয়োগের গ্রাফ")
              Container(
                padding: const EdgeInsets.fromLTRB(10, 16, 16, 14),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: palette.rule, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBangla ? 'বিনিয়োগের গ্রাফ' : 'Investment Growth',
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: palette.inkSecondary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    '৳ 18,75,000',
                                    style: GoogleFonts.poppins(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: palette.ink,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00C853).withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.arrow_upward_rounded, size: 12, color: Color(0xFF00C853)),
                                        Text(
                                          '+23.5%',
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF00C853),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: palette.surfaceSunken,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: palette.rule, width: 0.8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  isBangla ? 'এই মাস' : 'This Month',
                                  style: GoogleFonts.hindSiliguri(fontSize: 11.5, fontWeight: FontWeight.w600, color: palette.ink),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.keyboard_arrow_down_rounded, size: 15, color: palette.inkSecondary),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    SizedBox(
                      height: 175,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: LineTouchData(
                            enabled: true,
                            handleBuiltInTouches: true,
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipColor: (_) => const Color(0xFF0A2540),
                              tooltipRoundedRadius: 8,
                              tooltipPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((spot) {
                                  final valInLakh = spot.y;
                                  final amount = (valInLakh * 100000).toInt();
                                  final day = spot.x.toInt();
                                  return LineTooltipItem(
                                    isBangla ? '$day তারিখ\n৳ ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}' : 'Day $day\n৳ ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                                    GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 11.5,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                            getTouchedSpotIndicator: (barData, spotIndexes) {
                              return spotIndexes.map((index) {
                                return TouchedSpotIndicatorData(
                                  FlLine(
                                    color: const Color(0xFF0066FF).withValues(alpha: 0.4),
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
                            horizontalInterval: 5,
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
                                reservedSize: 34,
                                interval: 5,
                                getTitlesWidget: (val, meta) {
                                  if (val == 0) return Text('৳ 0', style: TextStyle(fontSize: 9.5, color: palette.inkTertiary));
                                  if (val == 5) return Text(isBangla ? '৳ ৫L' : '৳ 5L', style: TextStyle(fontSize: 9.5, color: palette.inkTertiary));
                                  if (val == 10) return Text(isBangla ? '৳ ১০L' : '৳ 10L', style: TextStyle(fontSize: 9.5, color: palette.inkTertiary));
                                  if (val == 15) return Text(isBangla ? '৳ ১৫L' : '৳ 15L', style: TextStyle(fontSize: 9.5, color: palette.inkTertiary));
                                  if (val == 20) return Text(isBangla ? '৳ ২০L' : '৳ 20L', style: TextStyle(fontSize: 9.5, color: palette.inkTertiary));
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 24,
                                interval: 5,
                                getTitlesWidget: (value, meta) {
                                  final day = value.toInt();
                                  if (day == 0) return Text('01', style: TextStyle(fontSize: 10, color: palette.inkTertiary));
                                  if (day % 5 == 0 && day <= 30) {
                                    final str = day < 10 ? '0$day' : '$day';
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(str, style: TextStyle(fontSize: 10, color: palette.inkTertiary)),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: 30,
                          minY: 0,
                          maxY: 20,
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 4.2),
                                FlSpot(5, 7.8),
                                FlSpot(10, 6.5),
                                FlSpot(15, 12.0),
                                FlSpot(20, 9.4),
                                FlSpot(25, 16.8),
                                FlSpot(30, 14.5),
                              ],
                              isCurved: true,
                              curveSmoothness: 0.35,
                              color: const Color(0xFF0066FF),
                              barWidth: 3.2,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                                checkToShowDot: (spot, barData) => spot.x == 15 || spot.x == 25,
                                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                  radius: 5,
                                  color: Colors.white,
                                  strokeWidth: 2.8,
                                  strokeColor: const Color(0xFF0066FF),
                                ),
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF0066FF).withValues(alpha: 0.28),
                                    const Color(0xFF0066FF).withValues(alpha: 0.0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Recent Activity ("সাম্প্রতিক কার্যকলাপ")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'সাম্প্রতিক কার্যকলাপ' : 'Recent Activity',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: palette.ink,
                    ),
                  ),
                  Text(
                    isBangla ? 'সব দেখুন' : 'View All',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0066FF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildActivityRow('নতুন বিনিয়োগ এসেছে', 'LandVest 100 • Arif Hossain', '৳ 25,500', '05 May 2026', palette),
              const SizedBox(height: 8),
              _buildActivityRow('নতুন ইনভেস্টর রেজিস্ট্রি', 'Arif Hossain', 'Verified', '05 May 2026', palette),
              const SizedBox(height: 8),
              _buildActivityRow('প্রজেক্ট আপডেট হয়েছে', 'GreenLand City', 'Milestone #2', '04 May 2026', palette),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
    required String actionText,
    required Color color,
    required AppPalette palette,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.rule, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              InkWell(
                onTap: onTap,
                child: Text(
                  actionText,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0066FF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: palette.ink),
          ),
          Text(
            title,
            style: GoogleFonts.hindSiliguri(fontSize: 12, color: palette.inkSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthCard({
    required String title,
    required String value,
    required String growth,
    required AppPalette palette,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.rule, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.hindSiliguri(fontSize: 12, color: palette.inkSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: palette.ink),
          ),
          const SizedBox(height: 4),
          Text(
            growth,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF00C853),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow(String title, String subtitle, String tag, String date, AppPalette palette) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.rule, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0066FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.bolt_rounded, size: 16, color: Color(0xFF0066FF)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.hindSiliguri(fontSize: 13, fontWeight: FontWeight.w700, color: palette.ink)),
                  Text(subtitle, style: GoogleFonts.poppins(fontSize: 10.5, color: palette.inkSecondary)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(tag, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0066FF))),
              Text(date, style: GoogleFonts.poppins(fontSize: 9.5, color: palette.inkTertiary)),
            ],
          ),
        ],
      ),
    );
  }
}
