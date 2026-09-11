import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/constants/app_config.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
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

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  int _selectedShares = 1;
  int _activeGalleryIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedShares = widget.project.minShares.clamp(1, widget.project.maxShares);
  }

  List<Map<String, String>> get _galleryItems {
    return [
      {
        'titleEn': 'Current Land Condition & Boundary',
        'titleBn': 'বর্তমান জমির অবস্থা ও বাউন্ডারি',
        'image': widget.project.imageUrl.isNotEmpty
            ? widget.project.imageUrl
            : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&auto=format&fit=crop&q=80',
      },
      {
        'titleEn': 'Access Highway & Connecting Road',
        'titleBn': 'সংযোগ সড়ক ও প্রধান হাইওয়ে অ্যাক্সেস',
        'image': 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop&q=80',
      },
      {
        'titleEn': 'Sustainable Planned Community Vision',
        'titleBn': 'পরিকল্পিত টেকসই কমিউনিটি রূপরেখা',
        'image': 'https://images.unsplash.com/photo-1448630360428-65456885c650?w=800&auto=format&fit=crop&q=80',
      },
      {
        'titleEn': 'Agro Farming & Seedling Growth',
        'titleBn': 'জৈব এগ্রো ফার্মিং ও উন্নত চারা উৎপাদন',
        'image': 'https://images.unsplash.com/photo-1592982537447-7440770cbfc9?w=800&auto=format&fit=crop&q=80',
      },
    ];
  }

  final List<Map<String, String>> _documents = const [
    {
      'titleEn': 'Project Prospectus (PDF)',
      'titleBn': 'প্রকল্প পরিচিতি ও বিবরণী (PDF)',
      'size': '2.4 MB',
      'type': 'PROSPECTUS',
    },
    {
      'titleEn': 'Investment Agreement & Trust Deed (PDF)',
      'titleBn': 'বিনিয়োগ চুক্তিপত্র ও ট্রাস্ট দলিল (PDF)',
      'size': '1.8 MB',
      'type': 'AGREEMENT',
    },
    {
      'titleEn': 'Project FAQ & Verification Guide (PDF)',
      'titleBn': 'প্রশ্নোত্তর ও যাচাইকরণ নির্দেশিকা (PDF)',
      'size': '850 KB',
      'type': 'FAQ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final project = widget.project;

    final totalShares = project.totalShares > 0 ? project.totalShares : 100;
    final allocatedShares = project.allocatedShares.clamp(0, totalShares);
    final availableShares = (totalShares - allocatedShares).clamp(0, totalShares);
    final progress = (allocatedShares / totalShares).clamp(0.0, 1.0);
    final isUpcoming = project.status == ProjectStatus.upcoming;
    final isClosed = project.status == ProjectStatus.closed || project.status == ProjectStatus.completed;

    final totalInvestment = _selectedShares * project.pricePerShare;
    // Estimated annual return based on 18.5% - 22.0%
    final minEstimatedReturn = totalInvestment * 0.185;
    final maxEstimatedReturn = totalInvestment * 0.220;
    final minQuarterlyDividend = minEstimatedReturn / 4;
    final maxQuarterlyDividend = maxEstimatedReturn / 4;

    return Scaffold(
      backgroundColor: palette.canvas,
      body: CustomScrollView(
        slivers: [
          // 1. Photo Hero App Bar with Rich Badges & Gradient
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: palette.surface,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                  child: IconButton(
                    icon: const Icon(Icons.share_outlined, size: 18, color: Colors.white),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      Clipboard.setData(ClipboardData(text: '${AppConfig.siteBaseUrl}/projects/${project.id}'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFF0066FF),
                          content: Text(
                            isBangla ? 'প্রজেক্ট লিঙ্ক কপি করা হয়েছে' : 'Project link copied to clipboard!',
                            style: GoogleFonts.hindSiliguri(color: Colors.white),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    _galleryItems[_activeGalleryIndex]['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF040D1A),
                      child: const Center(
                        child: Icon(Icons.apartment_rounded, size: 64, color: Colors.white54),
                      ),
                    ),
                  ),
                  // Deep gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.35),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Hero Badges & Header Content
                  Positioned(
                    bottom: 16,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badges Row
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.22),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
                              ),
                              child: Text(
                                project.code,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isUpcoming
                                    ? const Color(0xFFF59E0B).withValues(alpha: 0.3)
                                    : isClosed
                                        ? Colors.white.withValues(alpha: 0.2)
                                        : const Color(0xFF10B981).withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isUpcoming
                                      ? const Color(0xFFF59E0B)
                                      : isClosed
                                          ? Colors.white54
                                          : const Color(0xFF10B981),
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isUpcoming
                                          ? const Color(0xFFF59E0B)
                                          : isClosed
                                              ? Colors.white
                                              : const Color(0xFF10B981),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    isUpcoming
                                        ? (isBangla ? 'আসন্ন প্রকল্প' : 'UPCOMING')
                                        : isClosed
                                            ? (isBangla ? 'সম্পন্ন' : 'CLOSED')
                                            : (isBangla ? 'লাইভ প্রকল্প' : 'LIVE PROJECT'),
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0066FF).withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isBangla ? project.categoryNameBn : project.category,
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isBangla ? project.nameBn : project.name,
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded, size: 14, color: Color(0xFF38BDF8)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                project.location,
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 12.5,
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
          ),

          // 2. Project Details Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Philosophy Tagline Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF0066FF).withValues(alpha: 0.12),
                          const Color(0xFF0A2540).withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF0066FF).withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome_rounded, size: 16, color: Color(0xFF0066FF)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            isBangla
                                ? (project.philosophyQuoteBn ?? '“ছোট বিনিয়োগ, বড় ভবিষ্যৎ...”')
                                : (project.philosophyQuoteEn ?? '"Small investment, grand future..."'),
                            style: GoogleFonts.hindSiliguri(
                              fontSize: 12.5,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0066FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Floating 6-Grid Metrics Ribbon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: palette.rule, width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildRibbonCell(
                              label: isBangla ? 'প্রতি শেয়ার' : 'Per Share',
                              value: CurrencyFormatter.format(project.pricePerShare, isBangla: isBangla),
                              color: const Color(0xFF0066FF),
                              palette: palette,
                            ),
                            Container(width: 1, height: 38, color: palette.rule),
                            _buildRibbonCell(
                              label: isBangla ? 'প্রত্যাশিত ROI' : 'Target ROI',
                              value: '18.5% - 22.0%',
                              color: const Color(0xFF10B981),
                              palette: palette,
                            ),
                            Container(width: 1, height: 38, color: palette.rule),
                            _buildRibbonCell(
                              label: isBangla ? 'মোট শেয়ার' : 'Total Shares',
                              value: '$totalShares ${isBangla ? "টি" : "Units"}',
                              color: palette.ink,
                              palette: palette,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(height: 1, color: palette.rule),
                        ),
                        Row(
                          children: [
                            _buildRibbonCell(
                              label: isBangla ? 'বরাদ্দ সম্পন্ন' : 'Subscribed',
                              value: '$allocatedShares ${isBangla ? "টি" : "Units"}',
                              color: palette.ink,
                              palette: palette,
                            ),
                            Container(width: 1, height: 38, color: palette.rule),
                            _buildRibbonCell(
                              label: isBangla ? 'অবশিষ্ট শেয়ার' : 'Remaining',
                              value: '$availableShares ${isBangla ? "টি" : "Units"}',
                              color: const Color(0xFFF59E0B),
                              palette: palette,
                            ),
                            Container(width: 1, height: 38, color: palette.rule),
                            _buildRibbonCell(
                              label: isBangla ? 'এসক্রো ব্যাংক' : 'Escrow Bank',
                              value: 'City Bank',
                              color: const Color(0xFF0066FF),
                              palette: palette,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Funding Progress Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: palette.rule, width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isBangla ? 'প্রকল্প তহবিল সংগ্রহ অগ্রগতি' : 'Funding Progress',
                                  style: GoogleFonts.hindSiliguri(
                                    fontSize: 12,
                                    color: palette.inkSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${CurrencyFormatter.format(project.collectedFund, isBangla: isBangla)} / ${CurrencyFormatter.format(project.targetFund, isBangla: isBangla)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: palette.ink,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0066FF).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${(progress * 100).toInt()}%',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0066FF),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: palette.surfaceSunken,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0066FF)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isBangla
                                  ? '$allocatedShares টি শেয়ার বরাদ্দ হয়েছে'
                                  : '$allocatedShares shares allocated',
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 11.5,
                                color: palette.inkSecondary,
                              ),
                            ),
                            Text(
                              isBangla
                                  ? '$availableShares টি অবশিষ্ট'
                                  : '$availableShares shares remaining',
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFF59E0B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Interactive Investment & Returns Calculator
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF0A2540),
                          const Color(0xFF061529),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFF0066FF).withValues(alpha: 0.35)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0066FF).withValues(alpha: 0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0066FF).withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.calculate_rounded, color: Color(0xFF38BDF8), size: 18),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  isBangla ? 'রিটার্ন প্রক্ষেপণ ক্যালকুলেটর' : 'Investment Return Calculator',
                                  style: GoogleFonts.hindSiliguri(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.4)),
                              ),
                              child: Text(
                                'ROI: 18.5% - 22%',
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF4ADE80),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Share Stepper Row
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isBangla ? 'শেয়ার সংখ্যা নির্বাচন করুন' : 'Select Number of Shares',
                                    style: GoogleFonts.hindSiliguri(
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    '$_selectedShares ${isBangla ? "টি শেয়ার" : "Shares"} (${CurrencyFormatter.format(project.pricePerShare, isBangla: isBangla)}/শেয়ার)',
                                    style: GoogleFonts.hindSiliguri(
                                      fontSize: 12,
                                      color: const Color(0xFF38BDF8),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: _selectedShares > project.minShares
                                        ? () {
                                            HapticFeedback.selectionClick();
                                            setState(() => _selectedShares--);
                                          }
                                        : null,
                                    icon: const Icon(Icons.remove_circle_outline_rounded),
                                    color: Colors.white,
                                    disabledColor: Colors.white24,
                                  ),
                                  Text(
                                    '$_selectedShares',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _selectedShares < project.maxShares && _selectedShares < availableShares
                                        ? () {
                                            HapticFeedback.selectionClick();
                                            setState(() => _selectedShares++);
                                          }
                                        : null,
                                    icon: const Icon(Icons.add_circle_outline_rounded),
                                    color: const Color(0xFF38BDF8),
                                    disabledColor: Colors.white24,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Calculation Results Grid
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isBangla ? 'মোট বিনিয়োগ' : 'Total Investment',
                                      style: GoogleFonts.hindSiliguri(fontSize: 11, color: Colors.white70),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      CurrencyFormatter.format(totalInvestment, isBangla: isBangla),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isBangla ? 'প্রত্যাশিত বার্ষিক রিটার্ন' : 'Target Annual Profit',
                                      style: GoogleFonts.hindSiliguri(fontSize: 11, color: Colors.white70),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${CurrencyFormatter.format(minEstimatedReturn, isBangla: isBangla)} - ${CurrencyFormatter.format(maxEstimatedReturn, isBangla: isBangla)}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF4ADE80),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.25)),
                          ),
                          child: Text(
                            isBangla
                                ? 'ত্রৈমাসিক আনুমানিক লভ্যাংশ: ${CurrencyFormatter.format(minQuarterlyDividend, isBangla: isBangla)} - ${CurrencyFormatter.format(maxQuarterlyDividend, isBangla: isBangla)} (প্রতি ৩ মাস অন্তর)'
                                : 'Est. Quarterly Payout: ${CurrencyFormatter.format(minQuarterlyDividend, isBangla: false)} - ${CurrencyFormatter.format(maxQuarterlyDividend, isBangla: false)}',
                            style: GoogleFonts.hindSiliguri(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4ADE80),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Project Photo Gallery Slider
                  Text(
                    isBangla ? 'সাইট ফটো ও প্রকল্প গ্যালারি' : 'Project Site Gallery',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: palette.ink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _galleryItems.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final item = _galleryItems[index];
                        final isSelected = _activeGalleryIndex == index;
                        return InkWell(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() => _activeGalleryIndex = index);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF0066FF) : palette.rule,
                                width: isSelected ? 2.0 : 1.0,
                              ),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(11),
                                  child: Image.network(
                                    item['image']!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: palette.surfaceSunken,
                                      child: const Icon(Icons.image, size: 24, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.75),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 6,
                                  left: 6,
                                  right: 6,
                                  child: Text(
                                    isBangla ? item['titleBn']! : item['titleEn']!,
                                    style: GoogleFonts.hindSiliguri(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Project Description & Plan
                  Text(
                    isBangla ? 'প্রকল্পের বিবরণ ও পরিকল্পনা' : 'Project Overview & Strategy',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: palette.ink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: palette.rule, width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBangla ? project.descriptionBn : project.description,
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 13,
                            color: palette.ink,
                            height: 1.6,
                          ),
                        ),
                        if (project.profitModelBn != null) ...[
                          const SizedBox(height: 12),
                          Divider(height: 1, color: palette.rule),
                          const SizedBox(height: 10),
                          Text(
                            isBangla ? 'মুনাফা বণ্টন নীতিমালা:' : 'Profit-Sharing Model:',
                            style: GoogleFonts.hindSiliguri(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0066FF),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isBangla ? project.profitModelBn! : (project.profitModelEn ?? project.profitModelBn!),
                            style: GoogleFonts.hindSiliguri(
                              fontSize: 12,
                              color: palette.inkSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Shariah & City Bank Escrow Custody Security Vault Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF091F38),
                          const Color(0xFF061529),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF00C853).withValues(alpha: 0.35)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00C853).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.verified_user_rounded, color: Color(0xFF4ADE80), size: 18),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isBangla ? 'সিটি ব্যাংক এসক্রো ও শতভাগ নিরাপত্তা' : 'The City Bank PLC Escrow Protection',
                                    style: GoogleFonts.hindSiliguri(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    isBangla
                                        ? 'প্রতিটি শেয়ার ব্যাংক এসক্রো অ্যাকাউন্টে সম্পূর্ণ সুরক্ষিত'
                                        : '100% Segregated Escrow Account Protection',
                                    style: GoogleFonts.hindSiliguri(
                                      fontSize: 11,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildTrustCheckItem(
                          isBangla
                              ? 'সকল সাবস্ক্রিপশন অর্থ সিটি ব্যাংক এসক্রো অ্যাকাউন্টে সংরক্ষিত থাকে।'
                              : 'All capital held in segregated City Bank Escrow account.',
                        ),
                        _buildTrustCheckItem(
                          isBangla
                              ? 'নিবন্ধিত ট্রাস্ট দলিল ও ডিজিটাল শেয়ার সার্টিফিকেটের শতভাগ আইনি সুরক্ষা।'
                              : 'Registered Trust Deed & legal co-ownership certificate.',
                        ),
                        _buildTrustCheckItem(
                          isBangla
                              ? 'সাইট ইঞ্জিনিয়ারিং অডিট ও মাইলস্টোন সম্পন্ন হওয়া সাপেক্ষে তহবিল ছাড়।'
                              : 'Milestone-linked disbursement following physical site audit.',
                        ),
                        _buildTrustCheckItem(
                          isBangla
                              ? 'ডিজিটাল জিপিএস সীমানা ও সাব-রেজিস্ট্রি প্রত্যয়নকৃত রেকর্ড।'
                              : 'Digital GPS demarcated boundary and verified land titles.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Key Highlights Checklist
                  if (project.highlights.isNotEmpty) ...[
                    Text(
                      isBangla ? 'প্রকল্পের মূল বৈশিষ্ট্যসমূহ' : 'Key Project Highlights',
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: palette.ink,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: project.highlights.map((h) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: palette.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: palette.rule, width: 1.0),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.check_circle_rounded, color: Color(0xFF0066FF), size: 18),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    h,
                                    style: GoogleFonts.hindSiliguri(
                                      fontSize: 12.5,
                                      color: palette.ink,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Project Milestones Timeline
                  if (project.milestones.isNotEmpty) ...[
                    Text(
                      isBangla ? 'মাইলস্টোন ও বাস্তবায়নের সময়সূচি' : 'Milestones & Implementation',
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: palette.ink,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: palette.rule, width: 1.0),
                      ),
                      child: Column(
                        children: project.milestones.map((m) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: m.isCompleted
                                        ? const Color(0xFF10B981)
                                        : palette.surfaceSunken,
                                    border: Border.all(
                                      color: m.isCompleted
                                          ? const Color(0xFF10B981)
                                          : palette.ruleStrong,
                                    ),
                                  ),
                                  child: Icon(
                                    m.isCompleted ? Icons.check : Icons.schedule,
                                    size: 14,
                                    color: m.isCompleted ? Colors.white : palette.inkSecondary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isBangla ? m.titleBn : m.title,
                                        style: GoogleFonts.hindSiliguri(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: palette.ink,
                                        ),
                                      ),
                                      if (m.description.isNotEmpty)
                                        Text(
                                          m.description,
                                          style: GoogleFonts.hindSiliguri(
                                            fontSize: 11.5,
                                            color: palette.inkSecondary,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: m.isCompleted
                                        ? const Color(0xFF10B981).withValues(alpha: 0.12)
                                        : palette.surfaceSunken,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    m.isCompleted ? (isBangla ? 'সম্পন্ন' : 'DONE') : (isBangla ? 'চলমান' : 'PENDING'),
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: m.isCompleted ? const Color(0xFF10B981) : palette.inkSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Verified Legal Documents Vault
                  Text(
                    isBangla ? 'যাচাইকৃত প্রকল্প আইনি দলিল' : 'Verified Project Documents',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: palette.ink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: _documents.map((doc) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: palette.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: palette.rule, width: 1.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFEF4444), size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isBangla ? doc['titleBn']! : doc['titleEn']!,
                                      style: GoogleFonts.hindSiliguri(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                        color: palette.ink,
                                      ),
                                    ),
                                    Text(
                                      '${doc['size']} • Verified Official Record',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.5,
                                        color: palette.inkSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  HapticFeedback.selectionClick();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: const Color(0xFF0066FF),
                                      content: Text(
                                        isBangla
                                            ? '${doc['titleBn']} ডাউনলোড শুরু হয়েছে'
                                            : 'Downloading ${doc['titleEn']}...',
                                        style: GoogleFonts.hindSiliguri(color: Colors.white),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.file_download_outlined, color: Color(0xFF0066FF), size: 20),
                                tooltip: 'Download PDF',
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Project Location & Physical Map Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: palette.rule, width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0066FF).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.map_rounded, color: Color(0xFF0066FF), size: 18),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              isBangla ? 'প্রকল্প সাইট অবস্থান ও জিপিএস' : 'Project Site Location',
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: palette.ink,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          project.location,
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 12.5,
                            color: palette.inkSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isBangla ? 'গুগল ম্যাপ লিংক প্রস্তুত' : 'Google Maps query prepared: ${project.location}',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.open_in_new_rounded, size: 14),
                          label: Text(
                            isBangla ? 'গুগল ম্যাপে দেখুন' : 'View on Google Maps',
                            style: GoogleFonts.hindSiliguri(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0066FF),
                            side: const BorderSide(color: Color(0xFF0066FF), width: 1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),

      // 3. Sticky Bottom CTA Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: palette.surface,
          border: Border(top: BorderSide(color: palette.rule, width: 1.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Price & Shares summary
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBangla ? 'মোট বিনিয়োগ (৳)' : 'Total Investment',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 11,
                      color: palette.inkSecondary,
                    ),
                  ),
                  Text(
                    CurrencyFormatter.format(totalInvestment, isBangla: isBangla),
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0066FF),
                    ),
                  ),
                  Text(
                    '$_selectedShares ${isBangla ? "টি শেয়ার" : "Shares"} • $availableShares ${isBangla ? "টি অবশিষ্ট" : "left"}',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 10.5,
                      color: const Color(0xFFF59E0B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Invest / Pre-Book CTA
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isClosed
                        ? null
                        : () {
                            HapticFeedback.mediumImpact();
                            InvestmentFlowDialog.show(
                              context: context,
                              project: project,
                              state: widget.state,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUpcoming ? const Color(0xFFF59E0B) : const Color(0xFF0066FF),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      isUpcoming
                          ? (isBangla ? 'প্রি-বুক করুন' : 'Pre-Book Share')
                          : isClosed
                              ? (isBangla ? 'বরাদ্দ সমাপ্ত' : 'Sold Out')
                              : (isBangla ? 'বিনিয়োগ করুন' : 'Invest Now'),
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRibbonCell({
    required String label,
    required String value,
    required Color color,
    required AppPalette palette,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.hindSiliguri(
              fontSize: 10.5,
              color: palette.inkSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTrustCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF4ADE80)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.hindSiliguri(
                fontSize: 11.5,
                color: Colors.white.withValues(alpha: 0.9),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

