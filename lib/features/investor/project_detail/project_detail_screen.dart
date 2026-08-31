import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/status_chip.dart';
import 'package:swapnojatri/core/widgets/timeline_widget.dart';
import 'package:swapnojatri/core/widgets/document_vault_card.dart';
import 'package:swapnojatri/core/widgets/share_grid_matrix_widget.dart';
import 'package:swapnojatri/core/widgets/animated_count_text.dart';
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
  int _calculatorShares = 2;

  final List<String> _tabsEn = [
    'Overview',
    'Fund Usage',
    'Timeline',
    'Assets',
    'Documents',
    'Risk & Legal',
    'Updates',
  ];

  final List<String> _tabsBn = [
    'সারসংক্ষেপ',
    'তহবিল ব্যবহার',
    'টাইমলাইন',
    'সম্পদ বিবরণ',
    'দলিলপত্র',
    'ঝুঁকি ও আইনি',
    'আপডেট',
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final project = widget.state.landVest100; // Live sync with state

    final progress = project.fundingProgress;
    final percent = (progress * 100).toInt();
    final calculatedTotal = _calculatorShares * project.pricePerShare;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 260.0,
              pinned: true,
              backgroundColor: isDark ? AppColors.darkBg : AppColors.primaryDark,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                style: IconButton.styleFrom(backgroundColor: Colors.black38),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isBangla ? 'প্রকল্পের লিঙ্ক কপি করা হয়েছে' : 'Project link copied to clipboard'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.share_outlined, color: Colors.white),
                  style: IconButton.styleFrom(backgroundColor: Colors.black38),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      project.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.primaryMedium,
                        child: const Center(
                          child: Icon(Icons.terrain_rounded, size: 64, color: AppColors.accentGoldLight),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.45),
                            Colors.transparent,
                            (isDark ? AppColors.darkBg : AppColors.primaryDark).withValues(alpha: 0.95),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.accentGold,
                                  borderRadius: AppRadius.borderXs,
                                ),
                                child: Text(
                                  project.code,
                                  style: AppTypography.caption().copyWith(
                                    color: AppColors.primaryDark,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                              StatusChip.project(project.status, isBangla: isBangla),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isBangla ? project.nameBn : project.name,
                            style: AppTypography.displayMedium(isDark: true, isBangla: isBangla).copyWith(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded, size: 14, color: AppColors.accentGoldLight),
                              const SizedBox(width: 4),
                              Text(
                                project.location,
                                style: AppTypography.bodySmall(isDark: true).copyWith(color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Sticky Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: isDark ? AppColors.accentGoldLight : AppColors.primary,
                  unselectedLabelColor: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                  indicatorColor: isDark ? AppColors.accentGoldLight : AppColors.primary,
                  indicatorWeight: 3,
                  labelStyle: AppTypography.headingSmall(isBangla: isBangla).copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: List.generate(
                    _tabsEn.length,
                    (i) => Tab(text: isBangla ? _tabsBn[i] : _tabsEn[i]),
                  ),
                ),
                isDark: isDark,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(isDark, isBangla, project, progress, percent, calculatedTotal),
            _buildFundUsageTab(isDark, isBangla, project),
            _buildTimelineTab(isDark, isBangla, project),
            _buildAssetsTab(isDark, isBangla),
            _buildDocumentsTab(isDark, isBangla),
            _buildRiskTab(isDark, isBangla),
            _buildUpdatesTab(isDark, isBangla),
          ],
        ),
      ),

      // Bottom Bar with Live CTA
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'প্রতি শেয়ার মূল্য' : 'Share Price',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                    ),
                    Text(
                      CurrencyFormatter.format(project.pricePerShare, isBangla: isBangla),
                      style: AppTypography.financialAmountMedium(isDark: isDark),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: AppButton(
                  text: isBangla ? 'এখনই বিনিয়োগ করুন' : 'Invest Now',
                  onPressed: () {
                    InvestmentFlowDialog.show(
                      context,
                      project: project,
                      state: widget.state,
                      initialShares: _calculatorShares,
                    );
                  },
                  icon: Icons.flash_on_rounded,
                  variant: ButtonVariant.primary,
                  isBangla: isBangla,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TAB 1: OVERVIEW & INTERACTIVE CALCULATOR
  Widget _buildOverviewTab(
    bool isDark,
    bool isBangla,
    ProjectModel project,
    double progress,
    int percent,
    double calculatedTotal,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Funding Progress Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: AppRadius.borderLg,
              border: Border.all(
                color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isBangla ? 'তহবিল সংগ্রহ অবস্থা' : 'Funding Progress',
                      style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla),
                    ),
                    Text(
                      isBangla ? '$percent% সংগৃহীত' : '$percent% Collected',
                      style: AppTypography.headingSmall(isDark: isDark).copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: AppRadius.borderFull,
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: isDark ? AppColors.darkDivider : const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                  ),
                ),
                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBangla ? 'সংগৃহীত তহবিল' : 'Collected Fund',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          CurrencyFormatter.format(project.collectedFund, isBangla: isBangla),
                          style: AppTypography.financialAmountSmall(isDark: isDark),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          isBangla ? 'লক্ষ্যমাত্রা' : 'Target Fund',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          CurrencyFormatter.format(project.targetFund, isBangla: isBangla),
                          style: AppTypography.financialAmountSmall(isDark: isDark),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Share Matrix Grid
          Row(
            children: [
              Expanded(
                child: _miniInfoCard(
                  label: isBangla ? 'মোট শেয়ার' : 'Total Shares',
                  value: isBangla ? '${CurrencyFormatter.toBanglaDigits(project.totalShares.toString())} টি' : '${project.totalShares}',
                  icon: Icons.pie_chart_outline_rounded,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _miniInfoCard(
                  label: isBangla ? 'বরাদ্দকৃত' : 'Allocated',
                  value: isBangla ? '${CurrencyFormatter.toBanglaDigits(project.allocatedShares.toString())} টি' : '${project.allocatedShares}',
                  icon: Icons.check_circle_outline_rounded,
                  isDark: isDark,
                  isBangla: isBangla,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _miniInfoCard(
                  label: isBangla ? 'উপলব্ধ' : 'Available',
                  value: isBangla ? '${CurrencyFormatter.toBanglaDigits(project.availableShares.toString())} টি' : '${project.availableShares}',
                  icon: Icons.lock_open_rounded,
                  isDark: isDark,
                  isBangla: isBangla,
                  color: isDark ? AppColors.accentGoldLight : AppColors.accentGoldDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Visual 100-Share Ownership Matrix
          ShareGridMatrixWidget(
            totalShares: project.totalShares,
            allocatedShares: project.allocatedShares,
            selectedSharesCount: _calculatorShares,
            onSelectShares: (count) {
              setState(() => _calculatorShares = count);
            },
            isBangla: isBangla,
          ),
          const SizedBox(height: 24),

          // INTERACTIVE INVESTMENT CALCULATOR
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: AppRadius.borderLg,
              border: Border.all(
                color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calculate_rounded, color: AppColors.accentGold, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          isBangla ? 'ইন্টারেক্টিভ শেয়ার ক্যালকুলেটর' : 'Interactive Share Calculator',
                          style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accentGold.withValues(alpha: 0.2),
                        borderRadius: AppRadius.borderFull,
                      ),
                      child: Text(
                        isBangla ? '১-৪ টি শেয়ার' : '1-4 Shares Limit',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          color: isDark ? AppColors.accentGoldLight : AppColors.accentGoldDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Share Selector Pills (1, 2, 3, 4)
                Row(
                  children: [1, 2, 3, 4].map((shares) {
                    final isSelected = _calculatorShares == shares;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: InkWell(
                          onTap: () => setState(() => _calculatorShares = shares),
                          borderRadius: AppRadius.borderMd,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDark ? AppColors.accentGold : AppColors.primary)
                                  : (isDark ? AppColors.darkCard : Colors.white),
                              borderRadius: AppRadius.borderMd,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.accentGold
                                    : (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                isBangla
                                    ? '${CurrencyFormatter.toBanglaDigits(shares.toString())} শেয়ার'
                                    : '$shares Share${shares > 1 ? 's' : ''}',
                                style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                  color: isSelected
                                      ? (isDark ? AppColors.primaryDark : Colors.white)
                                      : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),

                // Slider Control
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: isDark ? AppColors.accentGold : AppColors.primary,
                    inactiveTrackColor: isDark ? AppColors.darkDivider : const Color(0xFFCBD5E1),
                    thumbColor: isDark ? AppColors.accentGoldLight : AppColors.primaryDark,
                    overlayColor: AppColors.accentGold.withValues(alpha: 0.2),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: _calculatorShares.toDouble(),
                    min: 1.0,
                    max: 4.0,
                    divisions: 3,
                    onChanged: (val) => setState(() => _calculatorShares = val.round()),
                  ),
                ),
                const SizedBox(height: 10),

                // Live Calculated Total Box with AnimatedCountText
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: AppRadius.borderMd,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isBangla
                                ? 'মোট প্রদেয় মূলধন ($_calculatorShares টি শেয়ার)'
                                : 'Total Investment ($_calculatorShares Shares)',
                            style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                          ),
                          AnimatedCountText(
                            endValue: calculatedTotal,
                            isBangla: isBangla,
                            style: AppTypography.financialAmountMedium(
                              isDark: isDark,
                              color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isBangla ? 'প্রকল্পে মালিকানা অনুপাত' : 'Project Equity Entitlement',
                            style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                          ),
                          Text(
                            '$_calculatorShares% of LandVest 100',
                            style: AppTypography.headingSmall(isDark: isDark).copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Project Description & Highlights
          Text(
            isBangla ? 'প্রকল্প পরিচিতি' : 'Project Description',
            style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 8),
          Text(
            isBangla ? project.descriptionBn : project.description,
            style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 18),

          Text(
            isBangla ? 'মূল বৈশিষ্ট্যসমূহ' : 'Key Project Highlights',
            style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 10),
          ...project.highlights.map((h) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, size: 18, color: AppColors.success),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        h,
                        style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // TAB 2: FUND USAGE & BUDGET BREAKDOWN
  Widget _buildFundUsageTab(bool isDark, bool isBangla, ProjectModel project) {
    final expenses = widget.state.expenses;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBangla ? 'তহবিলের স্বচ্ছ ব্যবহার ও বণ্টন' : 'Fund Allocation & Usage Breakdown',
            style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 6),
          Text(
            isBangla
                ? 'ল্যান্ডভেস্ট ১০০ তহবিলের প্রতি পয়সার হিসাব পাবলিক ভল্টে যাচাইযোগ্য'
                : 'Complete audited allocation of the ৳25,50,000 project target fund',
            style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 18),

          _budgetProgressItem('Land Acquisition & Plot Purchase', 'জমি ক্রয় ও অধিগ্রহণ', 1550000, 2550000, isDark, isBangla),
          _budgetProgressItem('Govt Sub-Registry & Stamp Duty', 'রেজিস্ট্রেশন ফি ও স্ট্যাম্প ডিউটি', 285000, 2550000, isDark, isBangla),
          _budgetProgressItem('Site Demarcation & Boundary Wall', 'জমির সীমানা প্রাচীর ও পিলার', 125000, 2550000, isDark, isBangla),
          _budgetProgressItem('Legal Due Diligence & Search', 'আইনি যাচাইকরণ ও তল্লাশি ফি', 65000, 2550000, isDark, isBangla),
          _budgetProgressItem('AC Land Mutation & Khazna', 'এসিল্যান্ড নামজারি ও ডিসিআর ফি', 25000, 2550000, isDark, isBangla),
          const SizedBox(height: 24),

          Text(
            isBangla ? 'অনুমোদিত খরচের সাম্প্রতিক ভাউচার' : 'Approved Expense Vouchers',
            style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 12),
          ...expenses.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: AppRadius.borderMd,
                    border: Border.all(
                      color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.description,
                            style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Voucher: ${e.voucherNo} • ${e.payee}',
                            style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                          ),
                        ],
                      ),
                      Text(
                        CurrencyFormatter.format(e.amount, isBangla: isBangla),
                        style: AppTypography.financialAmountSmall(isDark: isDark),
                      ),
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // TAB 3: TIMELINE
  Widget _buildTimelineTab(bool isDark, bool isBangla, ProjectModel project) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBangla ? 'প্রকল্প মাইলস্টোন টাইমলাইন' : 'Project Milestones & Status',
            style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 6),
          Text(
            isBangla ? 'প্রতিটি মাইলস্টোনের আইনি অগ্রগতি ও নথি সংযুক্ত আছে' : 'Track legal execution and asset progress in chronological order',
            style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 20),
          MilestoneTimelineWidget(
            milestones: project.milestones,
            isBangla: isBangla,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // TAB 4: ASSETS
  Widget _buildAssetsTab(bool isDark, bool isBangla) {
    final asset = widget.state.assets.first;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBangla ? 'জমির সম্পদ রেজিস্টার' : 'Land Asset Register',
            style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: AppRadius.borderLg,
              border: Border.all(
                color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      asset.title,
                      style: AppTypography.headingSmall(isDark: isDark).copyWith(fontWeight: FontWeight.w700),
                    ),
                    StatusChip(
                      label: isBangla ? 'স্বত্ব দখলীয়' : 'Acquired',
                      textColor: AppColors.successDark,
                      bgColor: AppColors.successLight,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _assetRow(isBangla ? 'জমির পরিমাপ' : 'Land Area', '${asset.landAreaDecimals} Decimals (শতাংশ)', isDark, isBangla),
                _assetRow(isBangla ? 'সাব-রেজিস্ট্রি দলিল' : 'Deed Reference', asset.ownershipReference, isDark, isBangla),
                _assetRow(isBangla ? 'নামজারি ও খতিয়ান' : 'Mutation Khatian', asset.mutationKhatian, isDark, isBangla),
                _assetRow(isBangla ? 'অধিগ্রহণ ব্যয়' : 'Acquisition Cost', CurrencyFormatter.format(asset.purchaseValue, isBangla: isBangla), isDark, isBangla),
                _assetRow(isBangla ? 'বর্তমান বাজার মূল্য' : 'Current Market Value', CurrencyFormatter.format(asset.currentValue, isBangla: isBangla), isDark, isBangla),
                _assetRow(isBangla ? 'আইনি কর্মকর্তা' : 'Legal Officer', asset.legalVerificationOfficer ?? 'Supreme Court Advocate', isDark, isBangla),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // TAB 5: DOCUMENTS
  Widget _buildDocumentsTab(bool isDark, bool isBangla) {
    final docs = widget.state.documents;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBangla ? 'যাচাইকৃত দলিল ও নথি ভল্ট' : 'Verified Project Documents',
            style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 16),
          ...docs.map((doc) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: DocumentVaultCard(
                  document: doc,
                  isBangla: isBangla,
                  onDownload: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isBangla ? '${doc.fileName} ডাউনলোড শুরু হয়েছে' : 'Downloading ${doc.fileName}...',
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                ),
              )),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // TAB 6: RISK & LEGAL
  Widget _buildRiskTab(bool isDark, bool isBangla) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBangla ? 'আইনি কাঠামো ও ঝুঁকি সংক্রান্ত তথ্য' : 'Regulatory Framework & Risk Disclosures',
            style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warningLight.withValues(alpha: isDark ? 0.15 : 0.6),
              borderRadius: AppRadius.borderMd,
              border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isBangla ? 'বিনিয়োগ ঝুঁকি সতর্কতা' : 'Investment Risk Notice',
                  style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                    color: AppColors.warningDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isBangla
                      ? 'স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম প্রকল্পভিত্তিক জমি ক্রয় ও উন্নয়ন ব্যবস্থাপনা করে। প্রকল্পের লভ্যাংশ জমি বিক্রয় বা লিজের অর্জিত মুনাফার ওপর নির্ভর করে। কোনো ফিক্সড বা নিশ্চিত মুনাফা প্রতিশ্রুতি দেওয়া হয় না। সকল আর্থিক লেনদেন ব্যাংকিং চ্যানেলে পরিচালিত হয়।'
                      : 'Swapnojatri Investment Platform facilitates asset-backed land acquisition and management. Profit distributions are strictly tied to actual realized asset appreciation and rental yields. No returns are guaranteed. All transactions must be conducted via regulated banking channels.',
                  style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla).copyWith(
                    color: isDark ? AppColors.darkTextSecondary : const Color(0xFF78350F),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // TAB 7: UPDATES
  Widget _buildUpdatesTab(bool isDark, bool isBangla) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBangla ? 'প্রকল্পের সর্বশেষ খবর ও নোটিশ' : 'Latest Project Updates',
            style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
          ),
          const SizedBox(height: 16),
          _updateItem(
            date: '18 August 2026',
            title: isBangla ? 'নামজারি ও খতিয়ান সম্পাদন সম্পন্ন' : 'AC Land Mutation Officially Finalized',
            body: isBangla
                ? 'সাভার সহকারী কমিশনার (ভূমি) কার্যালয় থেকে নামজারি সম্পন্ন করে ডিসিআর কপি দলিল ভল্টে আপলোড করা হয়েছে।'
                : 'Savar AC Land Office has approved the mutation. DCR and Khatian documents are available in the vault.',
            isDark: isDark,
            isBangla: isBangla,
          ),
          const SizedBox(height: 12),
          _updateItem(
            date: '22 June 2026',
            title: isBangla ? 'জমির সীমানা প্রাচীর ও পিলার স্থাপন' : 'Boundary Wall and Concrete Demarcation Completed',
            body: isBangla
                ? '২২.৫ শতাংশ জমির সীমানা নির্ধারণ করে আরসিসি পিলার ও কাঁটাতারের নিরাপত্তা বেষ্টনী সম্পন্ন হয়েছে।'
                : 'Physical boundary demarcation with RCC pillars and security wire across 22.5 decimals is complete.',
            isDark: isDark,
            isBangla: isBangla,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _miniInfoCard({
    required String label,
    required String value,
    required IconData icon,
    required bool isDark,
    required bool isBangla,
    Color? color,
  }) {
    final effectiveColor = color ?? (isDark ? AppColors.accentGoldLight : AppColors.primary);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: AppRadius.borderMd,
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: effectiveColor),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTypography.headingSmall(isDark: isDark).copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 10.5),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _budgetProgressItem(
    String titleEn,
    String titleBn,
    double amount,
    double target,
    bool isDark,
    bool isBangla,
  ) {
    final ratio = amount / target;
    final pct = (ratio * 100).toStringAsFixed(1);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isBangla ? titleBn : titleEn,
                style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${CurrencyFormatter.format(amount, isBangla: isBangla)} ($pct%)',
                style: AppTypography.financialAmountSmall(isDark: isDark).copyWith(fontSize: 12.5),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: AppRadius.borderFull,
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 6,
              backgroundColor: isDark ? AppColors.darkDivider : const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _assetRow(String label, String value, bool isDark, bool isBangla) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 12),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _updateItem({
    required String date,
    required String title,
    required String body,
    required bool isDark,
    required bool isBangla,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: AppRadius.borderMd,
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
              color: isDark ? AppColors.accentGoldLight : AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
          ),
        ],
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  final bool isDark;

  _SliverTabBarDelegate(this._tabBar, {required this.isDark});

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: isDark ? AppColors.darkBg : AppColors.lightBg,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
