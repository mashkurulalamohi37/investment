import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/lot_map_widget.dart';
import 'package:swapnojatri/core/widgets/document_card.dart';
import 'package:swapnojatri/core/widgets/timeline_widget.dart';
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
                    // 1. HERO ELEMENT: Full-Width LotMapWidget (§10)
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
                    const SizedBox(height: 24),

                    // 3. Tab Bar with Matra Active Indicator
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

                    // 4. Tab Content Views
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

            // 5. STICKY BOTTOM BAR (§10)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: palette.surface,
                border: Border(top: BorderSide(color: palette.rule, width: 1.0)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isBangla
                            ? '${CurrencyFormatter.toBanglaDigits(_selectedShares.toString())}টি শেয়ারের মূল্য'
                            : 'Price for $_selectedShares shares',
                        style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        CurrencyFormatter.format(calculatedTotal, isBangla: isBangla),
                        style: AppTypography.amountMedium(isDark: isDark, isBangla: isBangla).copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      label: isBangla ? 'অংশ সংরক্ষণ করুন' : 'Reserve Shares',
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

  Widget _buildSpecificationTab(AppPalette palette, bool isDark, bool isBangla) {
    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border.all(color: palette.rule, width: 1.0),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _specRow(isBangla ? 'মৌজা ও জেলা' : 'Mouza & District', isBangla ? 'বিরুলিয়া, সাভার, ঢাকা' : 'Birulia, Savar, Dhaka', palette, isDark),
          _specRow(isBangla ? 'আরএস দাগ নং' : 'RS Plot (Daag)', '৪১৮ (Plot 418)', palette, isDark),
          _specRow(isBangla ? 'নামজারি খতিয়ান নং' : 'Mutation Khatian', '৯০২ (Khatian #902)', palette, isDark),
          _specRow(isBangla ? 'জমির মোট পরিমাপ' : 'Total Area', isBangla ? '২২.৫ শতাংশ (১৩.৬৩ কাঠা)' : '22.5 Decimals (13.63 Katha)', palette, isDark),
          _specRow(isBangla ? 'প্রতি অংশের মাপ' : 'Area per Share', isBangla ? '০.২২৫ শতাংশ (১/১০০ অংশ)' : '0.225 Decimals (1/100 Share)', palette, isDark),
          _specRow(isBangla ? 'সাব-রেজিস্ট্রি দলিল' : 'Sub-Registry Deed', '#4982/2026 (Savar)', palette, isDark),
          _specRow(isBangla ? 'এসক্রো ব্যাংক হেফাজত' : 'Escrow Custody', isBangla ? 'সিটি ব্যাংক পিএলসি (গুলশান কর্পোরেট)' : 'City Bank PLC (Gulshan Branch)', palette, isDark),
        ],
      ),
    );
  }

  Widget _specRow(String label, String value, AppPalette palette, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.caption(isDark: isDark).copyWith(color: palette.inkSecondary, fontSize: 12)),
          Text(value, style: AppTypography.bodyStrong(isDark: isDark).copyWith(fontSize: 12.5, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildRiskTab(AppPalette palette, bool isDark, bool isBangla) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border.all(color: palette.rule, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBangla ? 'আইনি ও এসক্রো ঝুঁকি নীতিমালা' : 'Legal & Risk Disclosures',
            style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isBangla
                ? '১. ভূমির মূল্য পরিবর্তনশীল। বিনিয়োগে কোনো প্রকার নিশ্চিত মুনাফার প্রতিশ্রুতি দেওয়া হয় না।\n\n২. সংগৃহীত অর্থ সিটি ব্যাংক পিএলসির ডেডিকেটেড এসক্রো হিসাবে জমা থাকে এবং কেবলমাত্র অনুমোদিত ভাউচারের বিপরীতে ছাড় করা হয়।\n\n৩. হস্তান্তরযোগ্য শেয়ার সনদের মাধ্যমে মালিকানা নিশ্চিত করা হয়।'
                : '1. Land values can fluctuate. Returns are asset-backed and not guaranteed.\n\n2. All investor capital is held in escrow at City Bank PLC and released only against audited expense vouchers.\n\n3. Ownership is formalized via registered fractional certificates.',
            style: AppTypography.body(isDark: isDark, isBangla: isBangla).copyWith(
              color: palette.inkSecondary,
              fontSize: 12.5,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
