import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  final bool isBangla;

  const OnboardingScreen({
    super.key,
    required this.onComplete,
    this.isBangla = true,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, dynamic>> _getSlides(bool isBangla) {
    return [
      {
        'icon': Icons.account_balance_wallet_rounded,
        'titleEn': 'Invest with Transparency',
        'titleBn': 'স্বচ্ছতার সাথে নিরাপদ বিনিয়োগ',
        'descEn': 'Access verified, asset-backed land opportunities starting with LandVest 100 in strategic Dhaka locations.',
        'descBn': 'ঢাকার কৌশলগত এলাকায় ল্যান্ডভেস্ট ১০০ এর মাধ্যমে সম্পূর্ণ যাচাইকৃত ও দলিলভিত্তিক নিরাপদ জমিতে যৌথ বিনিয়োগ।',
        'badgeEn': 'LANDVEST 100 OPPORTUNITY',
        'badgeBn': 'ল্যান্ডভেস্ট ১০০ প্রকল্প',
      },
      {
        'icon': Icons.query_stats_rounded,
        'titleEn': 'Track Every Single Movement',
        'titleBn': 'তহবিলের প্রতি পয়সার স্বচ্ছ হিসাব',
        'descEn': 'Monitor real-time fund collection, vetted legal expenses, and land demarcation milestones directly from your phone.',
        'descBn': 'রিয়েল-টাইম তহবিল সংগ্রহ, সরকারি রেজিস্ট্রেশন ফি এবং জমির উন্নয়ন সংক্রান্ত প্রতিটি খরচের ভাউচার সরাসরি দেখুন।',
        'badgeEn': 'REAL-TIME FUND TRANSPARENCY',
        'badgeBn': 'লাইভ তহবিল স্বচ্ছতা',
      },
      {
        'icon': Icons.folder_shared_rounded,
        'titleEn': 'Verified Deeds & Payouts',
        'titleBn': 'ডিজিটাল দলিল ও সরাসরি লভ্যাংশ',
        'descEn': 'Instant access to Sub-Registry title deeds, AC land mutation khatians, and automated profit distributions.',
        'descBn': 'সাব-রেজিস্ট্রি মূল দলিল, এসিল্যান্ড নামজারি খতিয়ান এবং ব্যাংক/বিকাশে স্বয়ংক্রিয় লভ্যাংশ বণ্টন সুবিধা।',
        'badgeEn': 'VERIFIED DEED & DIVIDENDS',
        'badgeBn': 'যাচাইকৃত দলিল ও লভ্যাংশ',
      },
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final slides = _getSlides(widget.isBangla);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar (Logo & Skip)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primarySubtle,
                          borderRadius: AppRadius.borderSm,
                        ),
                        child: const Icon(
                          Icons.account_balance_rounded,
                          size: 18,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'SWAPNOJATRI',
                        style: AppTypography.headingSmall(isDark: isDark).copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  if (_currentPage < slides.length - 1)
                    TextButton(
                      onPressed: widget.onComplete,
                      child: Text(
                        widget.isBangla ? 'স্কিপ করুন' : 'Skip',
                        style: AppTypography.caption(isDark: isDark, isBangla: widget.isBangla).copyWith(
                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Middle Carousel Slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final slide = slides[index];

                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Institutional Emblem Container
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF132A22) : const Color(0xFF0B281E),
                              borderRadius: AppRadius.borderXl,
                              border: Border.all(
                                color: isDark ? const Color(0xFF234B3D) : const Color(0xFF1B4D3C),
                                width: 1.2,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                slide['icon'] as IconData,
                                size: 48,
                                color: AppColors.accentGoldLight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Pill Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.primaryDark : AppColors.primarySubtle,
                              borderRadius: AppRadius.borderFull,
                              border: Border.all(
                                color: AppColors.primaryLight.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              widget.isBangla ? slide['badgeBn'] : slide['badgeEn'],
                              style: AppTypography.caption(isDark: isDark, isBangla: widget.isBangla).copyWith(
                                color: isDark ? AppColors.accentGoldLight : AppColors.primaryDark,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Title
                          Text(
                            widget.isBangla ? slide['titleBn'] : slide['titleEn'],
                            style: AppTypography.headingLarge(isDark: isDark, isBangla: widget.isBangla).copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),

                          // Description
                          Text(
                            widget.isBangla ? slide['descBn'] : slide['descEn'],
                            style: AppTypography.bodyMedium(isDark: isDark, isBangla: widget.isBangla).copyWith(
                              fontSize: 14,
                              height: 1.45,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Navigation & Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                children: [
                  // Smooth Page Indicator Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(slides.length, (index) {
                      final isSelected = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isSelected ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark ? AppColors.accentGold : AppColors.primary)
                              : (isDark ? AppColors.darkDivider : const Color(0xFFCBD5E1)),
                          borderRadius: AppRadius.borderFull,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 28),

                  // Main Button CTA
                  if (_currentPage == slides.length - 1) ...[
                    AppButton(
                      text: widget.isBangla ? 'বিনিয়োগ শুরু করুন' : 'Get Started',
                      onPressed: widget.onComplete,
                      variant: ButtonVariant.primary,
                      isBangla: widget.isBangla,
                    ),
                    const SizedBox(height: 10),
                    AppButton(
                      text: widget.isBangla ? 'আমার অ্যাকাউন্ট আছে' : 'I already have an account',
                      onPressed: widget.onComplete,
                      variant: ButtonVariant.ghost,
                      isBangla: widget.isBangla,
                    ),
                  ] else ...[
                    AppButton(
                      text: widget.isBangla ? 'পরবর্তী' : 'Continue',
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      variant: ButtonVariant.primary,
                      isBangla: widget.isBangla,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
