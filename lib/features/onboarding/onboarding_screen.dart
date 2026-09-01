import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/landvest_logo_widget.dart';
import 'package:swapnojatri/core/widgets/app_logo_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: palette.canvas,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // 1. Top Header Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Brand Monogram & Title
                  SwapnojatriLogoWidget(
                    size: 34,
                    showText: true,
                    isDark: isDark,
                    isBangla: _isBangla,
                  ),

                  // Language Switcher Chip
                  InkWell(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _isBangla = !_isBangla);
                    },
                    borderRadius: AppRadius.borderChip,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: AppRadius.borderChip,
                        border: Border.all(color: palette.ruleStrong, width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.language_rounded, size: 14, color: palette.pine),
                          const SizedBox(width: 5),
                          Text(
                            _isBangla ? 'English' : 'বাংলা',
                            style: TextStyle(
                              fontSize: 11.5,
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
              const SizedBox(height: 10),

              // 2. Middle Slides
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (idx) => setState(() => _currentPage = idx),
                  children: [
                    // Slide 1: Multi-Project Investments
                    _buildSlide(
                      visual: _buildMultiProjectVisual(palette, isDark),
                      badge: _isBangla ? 'প্রকল্পভিত্তিক লাভ বণ্টন' : 'PROJECT PROFIT-SHARING',
                      title: _isBangla
                          ? 'ভিন্ন ভিন্ন প্রজেক্টে স্বচ্ছ অংশীদারিত্ব'
                          : 'Transparent Multi-Project Investments',
                      body: _isBangla
                          ? 'রিয়েল এস্টেট (LandVest 100) থেকে শুরু করে কৃষি ও লাভজনক বাণিজ্যিক উদ্যোগে অংশ নিয়ে সরাসরি নিট লভ্যাংশ অর্জনের সুযোগ।'
                          : 'Participate in diverse initiatives from Real Estate (LandVest 100) to Smart Agro Farming, and earn proportional net project dividends.',
                      palette: palette,
                      isDark: isDark,
                    ),

                    // Slide 2: Transparent Public Ledger & Escrow
                    _buildSlide(
                      visual: _buildLedgerVisual(palette, isDark),
                      badge: _isBangla ? 'স্বচ্ছ অডিট ও ব্যাংক নিরাপত্তা' : 'AUDITED ESCROW LEDGER',
                      title: _isBangla
                          ? 'প্রতিটি টাকার স্বচ্ছ অডিট ও নিরাপত্তা'
                          : 'Full Public Ledger for Every Project Taka',
                      body: _isBangla
                          ? 'ব্যাংক এসক্রো হেফাজত ও উন্মুক্ত অডিট ভাউচারের মাধ্যমে প্রকল্প ব্যয় ও অর্জিত আয়ের শতভাগ স্বচ্ছতা।'
                          : 'Project capital is safeguarded in designated banking escrow and disbursed against audited public vouchers.',
                      palette: palette,
                      isDark: isDark,
                    ),

                    // Slide 3: Cryptographic Share Certificate
                    _buildSlide(
                      visual: _buildCertificateVisual(palette, isDark),
                      badge: _isBangla ? 'ডিজিটাল সনদ ও লভ্যাংশ' : 'DIVIDEND SUBSCRIPTION CERTIFICATE',
                      title: _isBangla
                          ? 'কোনো জটিল দলিলের ঝামেলা ছাড়াই'
                          : 'Zero Personal Paperwork Hassle',
                      body: _isBangla
                          ? 'জমি বা খতিয়ানের জটিল প্রশাসনিক ঝামেলা ছাড়াই ব্যাংক বা বিকাশ অ্যাকাউন্টে সরাসরি লভ্যাংশ বণ্টন।'
                          : 'Receive verified dividends directly into your Bank or bKash account without the burden of managing property deeds.',
                      palette: palette,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              // 3. Bottom Action Area
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 3-Step Segmented Pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 24 : 8,
                        height: 5,
                        decoration: BoxDecoration(
                          color: isActive ? palette.pine : palette.ruleStrong,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),

                  // Next / Proceed Primary Button
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: _currentPage == 2
                          ? (_isBangla ? 'সরাসরি ডেমো এক্সপ্লোর করুন' : 'Explore Demo Platform')
                          : (_isBangla ? 'পরবর্তী ধাপ' : 'Next Step'),
                      variant: AppButtonVariant.primary,
                      isBangla: _isBangla,
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        if (_currentPage < 2) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOutCubic,
                          );
                        } else {
                          _proceedToAuth();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Secondary Skip & Direct Login Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _proceedToAuth,
                        child: Text(
                          _isBangla ? 'এড়িয়ে যান' : 'Skip',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: palette.inkSecondary,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _proceedToAuth,
                        icon: Icon(Icons.arrow_forward_rounded, size: 14, color: palette.pine),
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          _isBangla ? 'লগইন করুন' : 'Sign In',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: palette.pine,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _proceedToAuth() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const AuthScreen(),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 6),
                // 1. Visual Card
                visual,
                const SizedBox(height: 12),

                // 2. Section Badge & Headline
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                      decoration: BoxDecoration(
                        color: palette.pineTint,
                        borderRadius: AppRadius.borderChip,
                        border: Border.all(color: palette.pine.withValues(alpha: 0.3), width: 0.8),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: palette.pineDeep,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSerifBengali(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          height: 1.3,
                          color: palette.ink,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        body,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.anekBangla(
                          color: palette.inkSecondary,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  // Visual 1: Multi-Project Showcase (LandVest 100 + AgroVest)
  Widget _buildMultiProjectVisual(AppPalette palette, bool isDark) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      height: 200,
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderCard,
        border: Border.all(color: palette.ruleStrong, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F2B48).withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MULTI-PROJECT PORTFOLIO',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 8.5,
                  fontWeight: FontWeight.w700,
                  color: palette.inkSecondary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: palette.pineTint,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'PROFIT-SHARING',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: palette.pine,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Project Item 1: LandVest 100
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFC59B27).withValues(alpha: 0.3),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  const LandVestLogoWidget(size: 24, showText: false),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LandVest 100 • রিয়েল এস্টেট',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: palette.ink),
                        ),
                        Text(
                          '১০০ শেয়ার • প্রতি ভাগ ২৫,৫০০ ৳',
                          style: TextStyle(fontSize: 9.5, color: palette.inkSecondary),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '৭৪/১০০',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFC59B27),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Project Item 2: AgroVest Farm
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: palette.rule, width: 0.8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text('🌾', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'স্মার্ট এগ্রো ফার্মিং • সিজন ১',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: palette.ink),
                        ),
                        Text(
                          'ত্রৈমাসিক লভ্যাংশ • ১৫,০০০ ৳/ভাগ',
                          style: TextStyle(fontSize: 9.5, color: palette.inkSecondary),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'নতুন প্রজেক্ট',
                    style: TextStyle(
                      fontSize: 9.5,
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
    );
  }

  // Visual 2: Live Escrow Ledger Balance Diagram
  Widget _buildLedgerVisual(AppPalette palette, bool isDark) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      height: 200,
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderCard,
        border: Border.all(color: palette.ruleStrong, width: 1.0),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: palette.pine.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ESCROW & AUDIT RECONCILIATION',
                style: TextStyle(fontFamily: 'monospace', fontSize: 8.5, fontWeight: FontWeight.w700, color: palette.inkSecondary),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: palette.pineTint,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '100% AUDITED',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 8, fontWeight: FontWeight.w700, color: palette.pine),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: palette.rule, width: 0.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CITY BANK ESCROW ACCOUNT', style: TextStyle(fontFamily: 'monospace', fontSize: 8, color: palette.inkTertiary)),
                    const SizedBox(height: 2),
                    Text('৳ 25,50,000', style: TextStyle(fontFamily: 'serif', fontSize: 16, fontWeight: FontWeight.w700, color: palette.ink)),
                  ],
                ),
                Icon(Icons.account_balance_rounded, color: const Color(0xFFC59B27), size: 22),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _miniLedgerRow('Site Development & Execution', '৳ 1,50,000', 'VCH-01', palette),
                _miniLedgerRow('Agro Setup & Organic Farm Tools', '৳ 85,000', 'VCH-02', palette),
                _miniLedgerRow('Quarterly Dividend Distribution', '৳ 2,50,000', 'VCH-03', palette),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniLedgerRow(String desc, String amt, String vch, AppPalette palette) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: palette.surfaceSunken,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: palette.rule, width: 0.6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(vch, style: TextStyle(fontFamily: 'monospace', fontSize: 8, fontWeight: FontWeight.w700, color: palette.pine)),
              const SizedBox(width: 6),
              Text(desc, style: TextStyle(fontSize: 10, color: palette.ink)),
            ],
          ),
          Text(amt, style: TextStyle(fontFamily: 'monospace', fontSize: 9.5, fontWeight: FontWeight.w700, color: palette.ink)),
        ],
      ),
    );
  }

  // Visual 3: Digital Certificate Preview
  Widget _buildCertificateVisual(AppPalette palette, bool isDark) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      height: 200,
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderCard,
        border: Border.all(color: palette.ruleStrong, width: 1.0),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: palette.pine.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PROFIT-SHARING CERTIFICATE',
                style: TextStyle(fontFamily: 'monospace', fontSize: 8.5, fontWeight: FontWeight.w700, color: palette.inkSecondary),
              ),
              Text(
                '#LV100-2026-042',
                style: TextStyle(fontFamily: 'monospace', fontSize: 8.5, fontWeight: FontWeight.w700, color: const Color(0xFFC59B27)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFC59B27).withValues(alpha: 0.4), width: 1.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('REGISTERED SUBSCRIBER', style: TextStyle(fontFamily: 'monospace', fontSize: 7.5, color: palette.inkTertiary)),
                        Text('MASHKURUL ALAM OHI', style: TextStyle(fontFamily: 'serif', fontSize: 13, fontWeight: FontWeight.w700, color: palette.ink)),
                        Text('LANDVEST 100 • 4 SHARES SUBSCRIBED', style: TextStyle(fontFamily: 'monospace', fontSize: 8, fontWeight: FontWeight.w700, color: palette.pine)),
                        Text('PROPORTIONAL DIVIDEND ELIGIBLE', style: TextStyle(fontFamily: 'monospace', fontSize: 7.5, color: palette.inkSecondary)),
                      ],
                    ),
                  ),
                  const SealWidget(size: 38, isBangla: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DIGITAL SEAL VERIFIED', style: TextStyle(fontFamily: 'monospace', fontSize: 8, color: palette.pine, fontWeight: FontWeight.w700)),
              Text('SWAPNOJATRI REGISTRY', style: TextStyle(fontFamily: 'monospace', fontSize: 8, color: palette.inkTertiary)),
            ],
          ),
        ],
      ),
    );
  }
}
