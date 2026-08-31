import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/matra_rule_widget.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class SupportScreen extends StatelessWidget {
  final AppState state;

  const SupportScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
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
        'aEn': 'Distributions are calculated on audited realized profits using the formula: (Pool × Your Shares) ÷ 100. Payouts are sent directly to your verified bank account.',
        'aBn': 'অর্জিত প্রকৃত মুনাফার ওপর লভ্যাংশ হিসাব করা হয়: (মোট লভ্যাংশ পুল × আপনার শেয়ার) ÷ ১০০। অনুমোদনের পর অর্থ সরাসরি আপনার ব্যাংক অ্যাকাউন্টে পরিশোধ করা হয়।',
      },
      {
        'qEn': 'Where can I inspect the legal title deed and AC Land mutation?',
        'qBn': 'জমির মূল দলিল ও নামজারি খতিয়ান কোথায় দেখা যাবে?',
        'aEn': 'All verified deeds, mutation khatians, and legal search certificates are available in the Document Vault with cryptographically verified checksums.',
        'aBn': 'সকল সরকারি নিবন্ধিত দলিল, এসিল্যান্ড নামজারি খতিয়ান ও সুপ্রিম কোর্টের আইনজীবীর যাচাই প্রতিবেদন অ্যাপের "দলিল ভল্ট" সেকশনে রয়েছে।',
      },
    ];

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'সহায়তা ও প্রাতিষ্ঠানিক হেল্পডেস্ক' : 'Support & Investor Desk',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Card (Solid surface, 1px rule)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'বিনিয়োগকারী অফিসিয়াল হেল্পডেস্ক' : 'Official Investor Support Desk',
                      style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isBangla ? 'শনিবার-বৃহস্পতিবার (সকাল ৯টা - রাত ৮টা)' : 'Saturday - Thursday (9:00 AM - 8:00 PM)',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                        color: palette.inkSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.phone_in_talk_outlined, size: 16, color: palette.pine),
                            const SizedBox(width: 8),
                            Text('+880 9612-882200', style: TextStyle(fontFamily: 'monospace', fontSize: 13, fontWeight: FontWeight.w600, color: palette.ink)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.email_outlined, size: 16, color: palette.pine),
                            const SizedBox(width: 8),
                            Text('trust@swapnojatri.com', style: TextStyle(fontSize: 12, color: palette.inkSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // FAQ Accordion List
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Text(
                isBangla ? 'সাধারণ প্রশ্নোত্তর (FAQ)' : 'Frequently Asked Questions',
                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  children: faqs.map((faq) {
                    return ExpansionTile(
                      shape: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
                      collapsedShape: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
                      title: Text(
                        isBangla ? faq['qBn']! : faq['qEn']!,
                        style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(
                            isBangla ? faq['aBn']! : faq['aEn']!,
                            style: AppTypography.body(isDark: isDark, isBangla: isBangla).copyWith(
                              color: palette.inkSecondary,
                              fontSize: 12.5,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
