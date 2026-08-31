import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class SupportScreen extends StatelessWidget {
  final AppState state;

  const SupportScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;

    final faqs = [
      {
        'qEn': 'How does LandVest 100 share ownership work?',
        'qBn': 'ল্যান্ডভেস্ট ১০০ শেয়ারের মালিকানা কীভাবে নির্ধারিত হয়?',
        'aEn': 'LandVest 100 has a total of 100 shares at ৳25,500 each. Each share represents legal undivided co-ownership of the 22.5 decimal Savar plot, registered at the Sub-Registry office.',
        'aBn': 'ল্যান্ডভেস্ট ১০০ প্রকল্পে মোট ১০০টি শেয়ার রয়েছে, প্রতিটি ৳২৫,৫০০। প্রতিটি শেয়ার সাভারের ২২.৫ শতাংশ জমির অবিভাজ্য স্বত্বাধিকার নির্দেশ করে এবং তা সাব-রেজিস্ট্রি দলিলের মাধ্যমে নিশ্চিত করা হয়।',
      },
      {
        'qEn': 'What is the limit of shares per investor?',
        'qBn': 'একজন বিনিয়োগকারী সর্বোচ্চ কতটি শেয়ার নিতে পারেন?',
        'aEn': 'According to platform policy, each individual verified investor can subscribe between 1 to 4 shares to ensure fair democratization of land assets.',
        'aBn': 'প্ল্যাটফর্মের স্বচ্ছতা ও সুষ্ঠু অংশগ্রহণের নীতি অনুসারে একজন যাচাইকৃত বিনিয়োগকারী ১ থেকে সর্বোচ্চ ৪টি শেয়ার সাবস্ক্রাইব করতে পারবেন।',
      },
      {
        'qEn': 'How are profit distributions calculated and paid?',
        'qBn': 'লভ্যাংশ কীভাবে হিসাব ও প্রদান করা হয়?',
        'aEn': 'Distributions are calculated on audited realized profits using the formula: (Pool × Your Shares) ÷ 100. Payouts are sent directly to your verified bank or bKash account.',
        'aBn': 'অর্জিত প্রকৃত মুনাফার ওপর লভ্যাংশ হিসাব করা হয়: (মোট লভ্যাংশ পুল × আপনার শেয়ার) ÷ ১০০। অনুমোদনের পর অর্থ সরাসরি আপনার ব্যাংক বা বিকাশ অ্যাকাউন্টে পরিশোধ করা হয়।',
      },
      {
        'qEn': 'Where can I inspect the legal title deed and AC Land mutation?',
        'qBn': 'জমির মূল দলিল ও নামজারি খতিয়ান কোথায় দেখা যাবে?',
        'aEn': 'All verified deeds, mutation khatians, and legal search certificates are available in the Document Vault with cryptographically verified checksums.',
        'aBn': 'সকল সরকারি নিবন্ধিত দলিল, এসিল্যান্ড নামজারি খতিয়ান ও সুপ্রিম কোর্টের আইনজীবীর যাচাই প্রতিবেদন অ্যাপের "দলিল ভল্ট" সেকশনে রয়েছে।',
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'সহায়তা ও হেল্প সেন্টার' : 'Help & Support Center',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Direct Contact Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: isDark ? AppColors.heroGradientDark : AppColors.heroGradientLight,
                borderRadius: AppRadius.borderXl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accentGold.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.support_agent_rounded, color: AppColors.accentGoldLight, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBangla ? 'বিনিয়োগকারী হেল্পডেস্ক' : 'Investor Dedicated Support',
                            style: AppTypography.headingSmall().copyWith(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            isBangla ? 'শনিবার-বৃহস্পতিবার (সকাল ৯টা - রাত ৮টা)' : 'Sat-Thu (9:00 AM - 8:00 PM)',
                            style: AppTypography.caption().copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: isBangla ? 'হটলাইনে কল' : 'Call Desk',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Dialing Swapnojatri Helpdesk: +880 9612-000000')),
                            );
                          },
                          icon: Icons.phone_rounded,
                          variant: ButtonVariant.gold,
                          height: 42,
                          isBangla: isBangla,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          text: isBangla ? 'ইমেইল সাপোর্ট' : 'Email Us',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Email: support@swapnojatri.com')),
                            );
                          },
                          icon: Icons.email_outlined,
                          variant: ButtonVariant.outline,
                          height: 42,
                          isBangla: isBangla,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // FAQ Section
            Text(
              isBangla ? 'সচরাচর জিজ্ঞাসিত প্রশ্ন (FAQ)' : 'Frequently Asked Questions',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            ...faqs.map((faq) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: AppRadius.borderMd,
                    border: Border.all(
                      color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      isBangla ? faq['qBn']! : faq['qEn']!,
                      style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(
                          isBangla ? faq['aBn']! : faq['aEn']!,
                          style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla).copyWith(
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
