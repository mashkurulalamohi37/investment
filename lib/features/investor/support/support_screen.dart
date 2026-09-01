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
        'qEn': 'How does LandVest 100 & Swapnojatri profit-sharing work?',
        'qBn': 'ল্যান্ডভেস্ট ১০০ ও স্বপ্নযাত্রী প্ল্যাটফর্মে লাভ বণ্টন কীভাবে হয়?',
        'aEn': 'LandVest 100 is divided into 100 fractional shares at ৳25,500 each. Investors participate as profit-sharing partners and receive net project earnings proportionally, without having to manage complex land title deeds individually.',
        'aBn': 'ল্যান্ডভেস্ট ১০০ প্রকল্পে পুরো তহবিল ১০০টি শেয়ারে বিভক্ত (প্রতিটি ৳২৫,৫০০)। বিনিয়োগকারীরা প্রজেক্টে অর্থ দিয়ে অংশীদার হন এবং প্রজেক্টের নিট মুনাফা সমহারে পান। কোনো ব্যক্তিগত দলিলের জটিলতা পোহাতে হয় না।',
      },
      {
        'qEn': 'Do investors have to manage khatian, mouza or registry paperwork?',
        'qBn': 'বিনিয়োগকারীদের কি খতিয়ান, মৌজা বা দলিল সংক্রান্ত কাজ করতে হবে?',
        'aEn': 'No. Investors are profit-sharing partners. All legal, land administration, and operational aspects are handled transparently by the project management team.',
        'aBn': 'না। বিনিয়োগকারীরা কোনো জটিল কাগজপত্র বা খতিয়ান তদারকি করতে হবে না। প্রজেক্টের সকল প্রশাসনিক ও উন্নয়ন কাজ দায়িত্বপ্রাপ্ত টিম স্বচ্ছতার সাথে পরিচালনা করবে।',
      },
      {
        'qEn': 'Will there be other types of projects (e.g. Agriculture / Agro)?',
        'qBn': 'ভবিষ্যতে কি কৃষি বা অন্যান্য খাতের প্রকল্প আসবে?',
        'aEn': 'Yes! Swapnojatri is a multi-project platform. Alongside LandVest real estate, we are introducing smart agriculture (Agro-Farming), dairy, and commercial profit-sharing initiatives.',
        'aBn': 'হ্যাঁ! স্বপ্নযাত্রী একটি মাল্টি-প্রজেক্ট প্ল্যাটফর্ম। রিয়েল এস্টেট ছাড়াও সামনে কৃষি প্রজেক্ট (Agro Farming), ডেইরি ও লাভজনক বাণিজ্যিক উদ্যোগ যুক্ত হবে।',
      },
      {
        'qEn': 'How are profits calculated and transferred?',
        'qBn': 'লভ্যাংশ কীভাবে হিসাব ও পরিশোধ করা হয়?',
        'aEn': 'Profits are calculated based on transparent milestone revenue audits and distributed directly to your verified Bank or bKash account.',
        'aBn': 'প্রকল্পের আয় ও অডিটকৃত নিট মুনাফার ভিত্তিতে লভ্যাংশ হিসাব করে সরাসরি বিনিয়োগকারীর অনুমোদিত ব্যাংক বা বিকাশ অ্যাকাউন্টে ট্রান্সফার করা হয়।',
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
