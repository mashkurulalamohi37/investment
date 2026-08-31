import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/lot_map_widget.dart';
import 'package:swapnojatri/core/widgets/document_card.dart';
import 'package:swapnojatri/core/widgets/timeline_widget.dart';
import 'package:swapnojatri/core/widgets/amount_text.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/investment_flow/investment_flow_dialog.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectModel project;
  final AppState state;

  const ProjectDetailScreen({
    super.key,
    required this.project,
    required this.state,
  });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedShares = 2;

  final List<String> _tabsEn = [
    'Specification',
    'Timeline',
    'Documents',
    'Risk & Escrow',
  ];

  final List<String> _tabsBn = [
    'জমির বিবরণ',
    'টাইমলাইন',
    'দলিলপত্র',
    'ঝুঁকি ও এসক্রো',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabsEn.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final project = widget.state.landVest100;

    final progress = (project.allocatedShares / project.totalShares).clamp(0.0, 1.0);
    final calculatedTotal = _selectedShares * project.pricePerShare;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        toolbarHeight: 56.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? project.titleBn : project.title,
              style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              isBangla ? 'প্লট ৪১৮ • সাভার মৌজা' : 'Plot 418 • Savar Mouza',
              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                color: palette.inkSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBangla ? 'প্রকল্পের রেফারেন্স কপি হয়েছে' : 'Project reference copied to clipboard'),
                  backgroundColor: palette.pine,
                ),
              );
            },
            icon: const Icon(Icons.share_outlined, size: 20),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. HERO ELEMENT: Full-Width Cadastral LotMapWidget (§10)
                    LotMapWidget(
                      totalShares: project.totalShares,
                      allocatedShares: project.allocatedShares,
                      userLots: const ['LOT-041', 'LOT-042', 'LOT-043', 'LOT-044'],
                      selectedSharesCount: _selectedShares,
                      onSelectShares: (count) => setState(() => _selectedShares = count),
                      isBangla: isBangla,
                      isInteractive: true,
                    ),
                    const SizedBox(height: 16),

                    // 2. Funding Progress Line
                    ClipRRect(
                      borderRadius: AppRadius.borderFull,
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 4,
                        backgroundColor: palette.surfaceSunken,
                        valueColor: AlwaysStoppedAnimation<Color>(palette.pine),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isBangla
                              ? '${CurrencyFormatter.toBanglaDigits(project.allocatedShares.toString())}/১০০ অংশ বরাদ্দ সম্পন্ন'
                              : '${project.allocatedShares} of 100 shares allocated',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                            fontSize: 11.5,
                            color: palette.inkSecondary,
                          ),
                        ),
                        Text(
                          isBangla
                              ? 'উপলব্ধ: ${CurrencyFormatter.toBanglaDigits((project.totalShares - project.allocatedShares).toString())} টি'
                              : 'Available: ${project.totalShares - project.allocatedShares}',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                            fontWeight: FontWeight.w600,
                            color: palette.pine,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 3. Interactive ROI & Land Projection Calculator
                    _buildCalculatorPanel(palette, isDark, isBangla, project),
                    const SizedBox(height: 24),

                    // 4. Tab Bar with Matra Active Indicator
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorColor: palette.pine,
                      indicatorWeight: 2.0,
                      labelColor: palette.pine,
                      unselectedLabelColor: palette.inkSecondary,
                      labelStyle: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla),
                      tabs: (isBangla ? _tabsBn : _tabsEn).map((t) => Tab(text: t)).toList(),
                    ),
                    const SizedBox(height: 16),

                    // 5. Tab Content Views
                    SizedBox(
                      height: 380,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Tab 1: Ruled Specification Table
                          _buildSpecificationTab(palette, isDark, isBangla),

                          // Tab 2: Timeline
                          SingleChildScrollView(
                            child: TimelineWidget(isBangla: isBangla),
                          ),

                          // Tab 3: Documents
                          SingleChildScrollView(
                            child: Column(
                              children: widget.state.documents
                                  .map((doc) => Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
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
                                      ))
                                  .toList(),
                            ),
                          ),

                          // Tab 4: Risk & Escrow
                          _buildRiskTab(palette, isDark, isBangla),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 5. Sticky Bottom Action Bar
            Container(
              decoration: BoxDecoration(
                color: palette.surface,
                border: Border(top: BorderSide(color: palette.rule, width: 1.0)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isBangla ? 'নির্বাচিত অংশ ($_selectedShares টি)' : 'Selected ($_selectedShares shares)',
                        style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      AmountText(
                        amount: calculatedTotal,
                        isBangla: isBangla,
                        style: AppTypography.amountLarge(isDark: isDark, isBangla: isBangla).copyWith(
                          fontSize: 18,
                          color: palette.pine,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 170,
                    child: AppButton(
                      label: isBangla ? 'অংশ সাবস্ক্রাইব' : 'Subscribe Share',
                      variant: AppButtonVariant.primary,
                      isBangla: isBangla,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => InvestmentFlowDialog(
                            project: project,
                            state: widget.state,
                            initialShares: _selectedShares,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Interactive ROI & Land Projection Calculator
  Widget _buildCalculatorPanel(AppPalette palette, bool isDark, bool isBangla, ProjectModel project) {
    final landDecimals = (_selectedShares * 0.225);
    final landKatha = (landDecimals / 1.65);
    final totalCapital = _selectedShares * project.pricePerShare;
    final annualDividend = totalCapital * 0.16; // 16% expected annual lease & agribusiness dividend
    final threeYearCapitalGain = totalCapital * 0.50; // 50% 3-year projected land appreciation

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderCard,
        border: Border.all(color: palette.ruleStrong, width: 1.0),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  isBangla ? 'বিনিয়োগ ও মুনাফা প্রজেকশন' : 'Investment & ROI Projection',
                  style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: palette.pineTint,
                  borderRadius: AppRadius.borderChip,
                ),
                child: Text(
                  '$_selectedShares% OWNERSHIP',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: palette.pine,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Stepper Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'শেয়ার সংখ্যা' : 'Shares',
                      style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      isBangla ? 'সর্বোচ্চ ১-৪ টি অনুমোদিত' : '1–4 shares limit',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                        color: palette.inkSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [1, 2, 3, 4].map((count) {
                  final isSel = _selectedShares == count;
                  return InkWell(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _selectedShares = count);
                    },
                    borderRadius: AppRadius.borderChip,
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      width: 32,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isSel ? palette.pine : palette.surfaceSunken,
                        border: Border.all(
                          color: isSel ? palette.pine : palette.rule,
                          width: 1.0,
                        ),
                        borderRadius: AppRadius.borderChip,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        isBangla ? CurrencyFormatter.toBanglaDigits(count.toString()) : '$count',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: isSel ? Colors.white : palette.ink,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // 2x2 Projection Grid
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'জমির অনুপাত' : 'Land Demarcation',
                      style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(color: palette.inkSecondary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isBangla
                          ? '${CurrencyFormatter.toBanglaDigits(landDecimals.toStringAsFixed(3))} শতাংশ (${CurrencyFormatter.toBanglaDigits(landKatha.toStringAsFixed(3))} কাঠা)'
                          : '${landDecimals.toStringAsFixed(3)} dec (${landKatha.toStringAsFixed(3)} katha)',
                      style: AppTypography.bodyStrong(isDark: isDark).copyWith(fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 28, color: palette.rule),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'বার্ষিক সম্ভাব্য লভ্যাংশ (১৬%)' : 'Est. Annual Dividend (16%)',
                      style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(color: palette.inkSecondary),
                    ),
                    const SizedBox(height: 2),
                    AmountText(
                      amount: annualDividend,
                      isBangla: isBangla,
                      style: AppTypography.bodyStrong(isDark: isDark).copyWith(
                        fontSize: 12.5,
                        color: palette.pine,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'মোট বিনিয়োগকৃত মূলধন' : 'Total Capital',
                      style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(color: palette.inkSecondary),
                    ),
                    const SizedBox(height: 2),
                    AmountText(
                      amount: totalCapital,
                      isBangla: isBangla,
                      style: AppTypography.bodyStrong(isDark: isDark).copyWith(fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 28, color: palette.rule),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? '৩ বছরের মূলধন বৃদ্ধি (+৫০%)' : '3-Yr Land Growth (+50%)',
                      style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(color: palette.inkSecondary),
                    ),
                    const SizedBox(height: 2),
                    AmountText(
                      amount: threeYearCapitalGain,
                      isBangla: isBangla,
                      style: AppTypography.bodyStrong(isDark: isDark).copyWith(
                        fontSize: 12.5,
                        color: palette.pine,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Tab 1: Ruled Specification Table (§10)
  Widget _buildSpecificationTab(AppPalette palette, bool isDark, bool isBangla) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: AppRadius.borderCard,
          border: Border.all(color: palette.ruleStrong, width: 1.0),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _specRow(isBangla ? 'মৌজার নাম' : 'Mouza', isBangla ? 'বিরুলিয়া, সাভার' : 'Birulia, Savar', palette, isDark),
            const Divider(height: 16),
            _specRow(isBangla ? 'সিএস / আরএস দাগ' : 'CS / RS Plot', 'Plot 418', palette, isDark),
            const Divider(height: 16),
            _specRow(isBangla ? 'খতিয়ান নম্বর' : 'Khatian Ref', 'RS Khatian 902', palette, isDark),
            const Divider(height: 16),
            _specRow(isBangla ? 'মোট জমির আয়তন' : 'Total Land Size', isBangla ? '২২.৫ শতাংশ (১৩.৬ কাঠা)' : '22.5 Decimals (13.6 Katha)', palette, isDark),
            const Divider(height: 16),
            _specRow(isBangla ? 'প্রতি অংশের আয়তন' : 'Area per Share', isBangla ? '০.২২৫ শতাংশ' : '0.225 Decimals (1/100th)', palette, isDark),
            const Divider(height: 16),
            _specRow(isBangla ? 'রাস্তা সংযোগ' : 'Road Access', isBangla ? '২০ ফুট প্রশস্ত অভ্যন্তরীণ রাস্তা' : '20ft Front Access Road', palette, isDark),
            const Divider(height: 16),
            _specRow(isBangla ? 'এসক্রো হেফাজত' : 'Escrow Bank', isBangla ? 'সিটি ব্যাংক পিএলসি' : 'City Bank PLC', palette, isDark),
          ],
        ),
      ),
    );
  }

  Widget _specRow(String label, String value, AppPalette palette, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.caption(isDark: isDark).copyWith(
            color: palette.inkSecondary,
            fontSize: 12.5,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodyStrong(isDark: isDark).copyWith(
            fontSize: 12.5,
          ),
        ),
      ],
    );
  }

  // Tab 4: Risk & Escrow Tab (§10)
  Widget _buildRiskTab(AppPalette palette, bool isDark, bool isBangla) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: AppRadius.borderCard,
              border: Border.all(color: palette.ruleStrong, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isBangla ? 'প্রাতিষ্ঠানিক এসক্রো ও সুরক্ষা' : 'Institutional Escrow & Custody',
                  style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla),
                ),
                const SizedBox(height: 10),
                Text(
                  isBangla
                      ? '• সমস্ত বিনিয়োগের অর্থ সিটি ব্যাংক পিএলসি পরিচালিত বিশেষ এসক্রো হিসাবে জমা থাকে।\n\n• জমি রেজিস্ট্রি ও সীমানা নির্ধারণের অডিটকৃত বিল ব্যতিরেকে কোনো অর্থ ছাড় করা হয় না।\n\n• প্রতিটি লট সাব-রেজিস্ট্রি দলিল ও রেজিস্টার্ড শেয়ার সনদ দ্বারা আইনত সংরক্ষিত।'
                      : '• Investor capital is held exclusively in a dedicated escrow account at City Bank PLC.\n\n• Funds are disbursed strictly against audited vouchers for land purchase and survey.\n\n• Every lot is legally demarcated by registered mutation records and tamper-evident share certificates.',
                  style: AppTypography.body(isDark: isDark, isBangla: isBangla).copyWith(
                    color: palette.inkSecondary,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
