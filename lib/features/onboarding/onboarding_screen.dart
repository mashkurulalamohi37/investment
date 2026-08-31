import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/features/auth/auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isBangla = true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: palette.canvas,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Top Bar: 3-Segment Segmented Progress Rule + Language Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 3-Segment Progress Rule
                  Row(
                    children: List.generate(3, (index) {
                      final isActive = index <= _currentPage;
                      return Container(
                        margin: const EdgeInsets.only(right: 6),
                        width: 28,
                        height: 2,
                        color: isActive ? palette.pine : palette.rule,
                      );
                    }),
                  ),

                  // Language Toggle
                  TextButton(
                    onPressed: () => setState(() => _isBangla = !_isBangla),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      _isBangla ? 'EN' : 'বাং',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: palette.pine,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Middle Slides
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (idx) => setState(() => _currentPage = idx),
                  children: [
                    // Step 1: Cadastral Survey Sheet Diagram
                    _buildSlide(
                      diagram: _buildLotMapDiagram(palette),
                      title: _isBangla ? '১০০টি সুনির্দিষ্ট অংশে জমির মালিকানা' : 'Fractional Ownership in 100 Surveyed Lots',
                      body: _isBangla
                          ? 'সাভার মৌজার প্লট নং ৪১৮-এর প্রতিটি অংশ সাব-রেজিস্ট্রি দলিল ও খতিয়ান দ্বারা চিহ্নিত।'
                          : 'Each lot of Plot #418 is legally demarcated by registered title deeds and official mutation records.',
                      palette: palette,
                      isDark: isDark,
                    ),

                    // Step 2: Ruled Voucher Ledger Diagram
                    _buildSlide(
                      diagram: _buildVoucherLedgerDiagram(palette),
                      title: _isBangla ? 'প্রতিটি টাকার স্বচ্ছ পাবলিক লেজার' : 'Public Ledger for Every Single Taka',
                      body: _isBangla
                          ? 'জমি ক্রয়, রেজিস্ট্রেশন ট্যাক্স ও সীমানা প্রাচীরের প্রতিটি ভাউচার অডিট রিপোর্টসহ উন্মুক্ত।'
                          : 'All land purchase, tax, and survey expenses are backed by audited vouchers in the public ledger.',
                      palette: palette,
                      isDark: isDark,
                    ),

                    // Step 3: Sealed Certificate Diagram
                    _buildSlide(
                      diagram: _buildCertificateDiagram(palette),
                      title: _isBangla ? 'অফিসিয়াল সিলমোহরযুক্ত সনদপত্র' : 'Legally Sealed Ownership Certificate',
                      body: _isBangla
                          ? 'বিনিয়োগ সম্পন্ন হওয়ামাত্র আপনার নামে ক্রিপ্টোগ্রাফিক ভেরিফায়েড শেয়ার সনদ ইস্যু হয়।'
                          : 'Instantly receive a verifiable share certificate with registered deed reference upon confirmation.',
                      palette: palette,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bottom Actions
              AppButton(
                label: _currentPage == 2
                    ? (_isBangla ? 'শুরু করুন' : 'Begin')
                    : (_isBangla ? 'পরবর্তী' : 'Continue'),
                variant: AppButtonVariant.primary,
                isBangla: _isBangla,
                onPressed: _nextPage,
              ),
              const SizedBox(height: 8),

              if (_currentPage < 2)
                AppButton(
                  label: _isBangla ? 'এড়িয়ে যান' : 'Skip',
                  variant: AppButtonVariant.quiet,
                  isBangla: _isBangla,
                  onPressed: _navigateToAuth,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide({
    required Widget diagram,
    required String title,
    required String body,
    required AppPalette palette,
    required bool isDark,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 140, child: Center(child: diagram)),
        const SizedBox(height: 32),
        Text(
          title,
          style: AppTypography.titleLarge(isDark: isDark, isBangla: _isBangla).copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: AppTypography.body(isDark: isDark, isBangla: _isBangla).copyWith(
            color: palette.inkSecondary,
            fontSize: 13.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLotMapDiagram(AppPalette palette) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border.all(color: palette.ruleStrong, width: 1.0),
      ),
      child: Stack(
        children: [
          // 4x4 Sample Mini Grid
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 16,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (context, idx) {
              final isUserCell = idx == 5;
              final isAllocated = idx < 8 && !isUserCell;

              return Container(
                decoration: BoxDecoration(
                  color: isUserCell ? palette.pine : (isAllocated ? palette.surfaceSunken : palette.surface),
                  border: Border.all(color: palette.rule, width: 0.6),
                ),
                child: isUserCell
                    ? Center(
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(color: palette.brass, shape: BoxShape.circle),
                        ),
                      )
                    : null,
              );
            },
          ),
          Positioned(
            bottom: 4,
            right: 6,
            child: Text(
              'PLOT 418',
              style: TextStyle(fontFamily: 'monospace', fontSize: 8, color: palette.inkTertiary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherLedgerDiagram(AppPalette palette) {
    return Container(
      width: 170,
      height: 120,
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border.all(color: palette.ruleStrong, width: 1.0),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('LEDGER #2026', style: TextStyle(fontFamily: 'monospace', fontSize: 8.5, color: palette.inkTertiary)),
              Container(width: 8, height: 8, decoration: BoxDecoration(color: palette.jade, shape: BoxShape.circle)),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 6),
          _miniVoucherRow('VCH-001', '৳ 15,50,000', palette),
          const SizedBox(height: 4),
          _miniVoucherRow('VCH-002', '৳ 2,85,000', palette),
          const SizedBox(height: 4),
          _miniVoucherRow('VCH-003', '৳ 1,25,000', palette),
        ],
      ),
    );
  }

  Widget _miniVoucherRow(String no, String amount, AppPalette palette) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(no, style: TextStyle(fontFamily: 'monospace', fontSize: 8, color: palette.inkSecondary)),
        Text(amount, style: TextStyle(fontFamily: 'monospace', fontSize: 8, fontWeight: FontWeight.w600, color: palette.ink)),
      ],
    );
  }

  Widget _buildCertificateDiagram(AppPalette palette) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border.all(color: palette.brass, width: 1.0),
      ),
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: palette.brass.withValues(alpha: 0.5), width: 0.6)),
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('CERTIFICATE', style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.w700, color: palette.brass)),
                const SizedBox(height: 6),
                Container(width: double.infinity, height: 1, color: palette.rule),
                const SizedBox(height: 8),
                Container(width: 50, height: 2, color: palette.inkTertiary),
                const SizedBox(height: 4),
                Container(width: 70, height: 2, color: palette.inkTertiary),
              ],
            ),
          ),
          Positioned(
            right: 4,
            bottom: 4,
            child: SealWidget(size: 28, isBangla: _isBangla),
          ),
        ],
      ),
    );
  }
}
