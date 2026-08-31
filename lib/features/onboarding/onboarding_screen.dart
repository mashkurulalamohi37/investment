import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
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
    HapticFeedback.selectionClick();
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToAuth() {
    HapticFeedback.selectionClick();
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: [
              // 1. Top Brand Navigation Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Brand Crest & Monogram
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: palette.pine,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: palette.brass, width: 1.2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'স্ব',
                            style: TextStyle(
                              fontFamily: 'serif',
                              color: palette.brass,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isBangla ? 'স্বপ্নযাত্রী' : 'SWAPNOJATRI',
                                style: AppTypography.titleMedium(isDark: isDark, isBangla: _isBangla).copyWith(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _isBangla ? 'ভূমি ইনভেস্টমেন্ট' : 'Land Investment',
                                style: AppTypography.caption(isDark: isDark, isBangla: _isBangla).copyWith(
                                  color: palette.inkTertiary,
                                  fontSize: 9.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Language Switcher Chip
                  InkWell(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _isBangla = !_isBangla);
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: palette.ruleStrong, width: 1.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.language_rounded, size: 13, color: palette.pine),
                          const SizedBox(width: 4),
                          Text(
                            _isBangla ? 'English' : 'বাংলা',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: palette.pine,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 2. Middle Interactive Slides
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (idx) => setState(() => _currentPage = idx),
                  children: [
                    // Slide 1: Cadastral Land Survey
                    _buildSlide(
                      visual: _buildCadastralVisual(palette, isDark),
                      badge: _isBangla ? 'মৌজা ও খতিয়ান ভিত্তিক' : 'SURVEYED CADASTRAL PARCELS',
                      title: _isBangla
                          ? '১০০টি সুনির্দিষ্ট অংশে আইনত বিভক্ত জমি'
                          : 'Fractional Ownership in 100 Surveyed Lots',
                      body: _isBangla
                          ? 'সাভার মৌজার প্লট নং ৪১৮-এর প্রতিটি অংশ সাব-রেজিস্ট্রি দলিল, আরএস খতিয়ান ও নামজারি দ্বারা আইনত নিশ্চিত।'
                          : 'Each lot of Plot #418 is legally demarcated by registered title deeds, RS Khatian #902, and official mutation records.',
                      palette: palette,
                      isDark: isDark,
                    ),

                    // Slide 2: Transparent Public Ledger & Escrow
                    _buildSlide(
                      visual: _buildLedgerVisual(palette, isDark),
                      badge: _isBangla ? 'পাবলিক লেজার ও এসক্রো' : 'INSTITUTIONAL ESCROW LEDGER',
                      title: _isBangla
                          ? 'প্রতিটি টাকার স্বচ্ছ অডিট ও ব্যাংক হেফাজত'
                          : 'Full Public Ledger for Every Single Taka',
                      body: _isBangla
                          ? 'সিটি ব্যাংক পিএলসি এসক্রো হিসাব থেকে জমি রেজিস্ট্রি ও সীমানা নির্ধারণের প্রতিটি খরচ উন্মুক্ত ভাউচারে সংরক্ষিত।'
                          : 'Funds are safeguarded in City Bank PLC Escrow and disbursed strictly against audited public vouchers.',
                      palette: palette,
                      isDark: isDark,
                    ),

                    // Slide 3: Cryptographic Share Certificate
                    _buildSlide(
                      visual: _buildCertificateVisual(palette, isDark),
                      badge: _isBangla ? 'অফিসিয়াল সনদপত্র' : 'REGISTERED SHARE CERTIFICATE',
                      title: _isBangla
                          ? 'স্বাক্ষরিত ও সিলমোহরযুক্ত শেয়ার সনদ'
                          : 'Tamper-Proof Official Share Certificate',
                      body: _isBangla
                          ? 'বিনিয়োগ সম্পন্ন হওয়ামাত্র আপনার নামে ক্রিপ্টোগ্রাফিক হ্যাশযুক্ত আইনি সনদপত্র তাৎক্ষণিকভাবে ইস্যু করা হয়।'
                          : 'Upon subscription verification, an immutable, tamper-evident certificate is issued with a unique SHA-256 seal.',
                      palette: palette,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // 3. Bottom Progress Bar & Action Controls
              Column(
                children: [
                  // 3-Step Elegant Segmented Pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      final isActive = index == _currentPage;
                      final isPassed = index < _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 36 : 14,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isActive
                              ? palette.pine
                              : (isPassed ? palette.pine.withValues(alpha: 0.4) : palette.ruleStrong),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),

                  // Primary Action Button
                  AppButton(
                    label: _currentPage == 2
                        ? (_isBangla ? 'শুরু করুন' : 'Get Started')
                        : (_isBangla ? 'পরবর্তী ধাপ' : 'Next Step'),
                    variant: AppButtonVariant.primary,
                    isBangla: _isBangla,
                    onPressed: _nextPage,
                  ),
                  const SizedBox(height: 8),

                  // Secondary Sign In / Skip Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _navigateToAuth,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          _isBangla ? 'এড়িয়ে যান' : 'Skip',
                          style: TextStyle(
                            fontSize: 12,
                            color: palette.inkTertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _navigateToAuth,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _isBangla ? 'লগইন করুন' : 'Sign In',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: palette.pine,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(Icons.arrow_forward_rounded, size: 13, color: palette.pine),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide({
    required Widget visual,
    required String badge,
    required String title,
    required String body,
    required AppPalette palette,
    required bool isDark,
  }) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 6),
          // Visual Card
          visual,
          const SizedBox(height: 16),

          // Section Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: palette.pineTint,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: palette.pine.withValues(alpha: 0.2), width: 1.0),
            ),
            child: Text(
              badge,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: palette.pine,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Title in Rich Source Serif
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.titleLarge(isDark: isDark, isBangla: _isBangla).copyWith(
              fontSize: 18.5,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),

          // Body with High Contrast
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              body,
              textAlign: TextAlign.center,
              style: AppTypography.body(isDark: isDark, isBangla: _isBangla).copyWith(
                color: palette.inkSecondary,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  // Visual 1: Cadastral Survey Sheet Diagram
  Widget _buildCadastralVisual(AppPalette palette, bool isDark) {
    return Container(
      width: 240,
      height: 180,
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderCard,
        border: Border.all(color: palette.ruleStrong, width: 1.2),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: palette.pine.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Header Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'BIRULIA • PLOT 418',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: palette.inkSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Container(width: 4, height: 4, decoration: BoxDecoration(color: palette.brass, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text(
                    'NORTH ↑',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 8, color: palette.inkTertiary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),

          // 5x5 Survey Grid
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                border: Border.all(color: palette.rule, width: 1.0),
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 25,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final isOwned = index == 12; // Center Lot (LOT-042)
                  final isAllocated = index == 6 || index == 7 || index == 11 || index == 13 || index == 17;

                  return Container(
                    decoration: BoxDecoration(
                      color: isOwned
                          ? palette.pine
                          : (isAllocated ? palette.surfaceSunken : palette.surface),
                      border: Border.all(color: palette.rule, width: 0.6),
                    ),
                    child: Center(
                      child: isOwned
                          ? Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: palette.brass,
                                shape: BoxShape.circle,
                              ),
                            )
                          : Text(
                              (index + 31).toString().padLeft(3, '0'),
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 7,
                                color: isAllocated ? palette.inkTertiary : palette.inkSecondary,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Footer Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: palette.rule, width: 0.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _isBangla ? 'লট-০৪২ (আপনার অংশ)' : 'LOT-042 (YOURS)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 8.5,
                      fontWeight: FontWeight.w700,
                      color: palette.pine,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '0.225 DEC',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 8.5, fontWeight: FontWeight.w600, color: palette.inkSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Visual 2: Ruled Ledger Diagram
  Widget _buildLedgerVisual(AppPalette palette, bool isDark) {
    return Container(
      width: 240,
      height: 180,
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderCard,
        border: Border.all(color: palette.ruleStrong, width: 1.2),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: palette.pine.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ESCROW AUDIT LEDGER',
                style: TextStyle(fontFamily: 'monospace', fontSize: 8.5, fontWeight: FontWeight.w700, color: palette.pine),
              ),
              SealWidget(size: 20, isBangla: _isBangla),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(height: 1),
          const SizedBox(height: 6),

          _ledgerRowItem('VCH-001', 'Land Purchase Deed', '৳ 12,50,000', palette, isDark),
          const SizedBox(height: 4),
          _ledgerRowItem('VCH-002', 'Sub-Registry Stamp', '৳ 4,80,000', palette, isDark),
          const SizedBox(height: 4),
          _ledgerRowItem('VCH-003', 'Boundary Wall & RCC', '৳ 3,20,000', palette, isDark),

          const Spacer(),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: palette.rule, width: 0.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isBangla ? 'তহবিল স্থিতি:' : 'Treasury Balance:',
                  style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w500, color: palette.inkSecondary),
                ),
                Text(
                  '৳ 5,00,000',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: palette.pine,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ledgerRowItem(String code, String title, String amount, AppPalette palette, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: palette.ink)),
            Text(code, style: TextStyle(fontFamily: 'monospace', fontSize: 7.5, color: palette.inkTertiary)),
          ],
        ),
        Row(
          children: [
            Text(amount, style: TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.w700, color: palette.ink)),
            const SizedBox(width: 3),
            Icon(Icons.verified_rounded, size: 10, color: palette.jade),
          ],
        ),
      ],
    );
  }

  // Visual 3: Official Share Certificate
  Widget _buildCertificateVisual(AppPalette palette, bool isDark) {
    return Container(
      width: 240,
      height: 180,
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderCard,
        border: Border.all(color: palette.brass, width: 1.5),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: palette.brass.withValues(alpha: 0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Inner hairline border
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: palette.ruleStrong, width: 0.8),
              ),
              child: Column(
                children: [
                  Text(
                    'LANDVEST 100 SHARE CERTIFICATE',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 8.5,
                      fontWeight: FontWeight.w700,
                      color: palette.pine,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'Plot #418 • Savar Mouza • 1/100th Share',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 7.5, color: palette.inkTertiary),
                  ),
                  const SizedBox(height: 6),
                  const Divider(height: 1),
                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CERTIFICATE NO', style: TextStyle(fontFamily: 'monospace', fontSize: 7, color: palette.inkTertiary)),
                          Text('LV100-2026-042', style: TextStyle(fontFamily: 'monospace', fontSize: 9.5, fontWeight: FontWeight.w700, color: palette.ink)),
                        ],
                      ),
                      SealWidget(size: 28, isBangla: _isBangla),
                    ],
                  ),
                  const Spacer(),

                  // SHA-256 Stamp
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: palette.surfaceSunken,
                    child: Text(
                      'SHA256: 8f9b2d...91c0e4 • VERIFIED',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 7, color: palette.inkTertiary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
