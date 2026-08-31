import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/matra_rule_widget.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class KycScreen extends StatefulWidget {
  final AppState state;

  const KycScreen({
    super.key,
    required this.state,
  });

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  int _step = 0; // 0 = Checklist Overview, 1 = NID Capture Frame, 2 = Bank & Nominee
  final TextEditingController _nidController = TextEditingController(text: '1992269482910394');
  final TextEditingController _nomineeController = TextEditingController(text: 'Fatema Begum');
  final TextEditingController _nomineeRelationController = TextEditingController(text: 'Spouse');

  @override
  void dispose() {
    _nidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'কেওয়াইসি ও পরিচিতি যাচাই' : 'KYC & Identity Verification',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: _buildBody(palette, isDark, isBangla),
        ),
      ),
    );
  }

  Widget _buildBody(AppPalette palette, bool isDark, bool isBangla) {
    if (_step == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MatraRuleWidget(width: 32, color: palette.pine),
          const SizedBox(height: 8),
          Text(
            isBangla ? 'পরিচিতি যাচাই খতিয়ান' : 'Compliance & Identity Status',
            style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isBangla
                ? 'বাংলাদেশ ব্যাংক ও ভূমি মন্ত্রণালয়ের নীতিমালা অনুযায়ী বিনিয়োগকারীর পরিচিতি তথ্য বাধ্যতামূলক।'
                : 'Identity verification is mandatory under Bangladesh Real Estate and Anti-Money Laundering regulations.',
            style: AppTypography.body(isDark: isDark, isBangla: isBangla).copyWith(
              color: palette.inkSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),

          // Ruled Checklist
          Container(
            decoration: BoxDecoration(
              color: palette.surface,
              border: Border.all(color: palette.rule, width: 1.0),
            ),
            child: Column(
              children: [
                _checklistItem(
                  title: isBangla ? 'জাতীয় পরিচয়পত্র (এনআইডি)' : 'National ID (NID)',
                  subtitle: isBangla ? 'স্মার্ট এনআইডি ফ্রন্ট ও ব্যাক যাচাইকৃত' : 'Smart NID Verified: 1992269482910394',
                  isCompleted: true,
                  palette: palette,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
                _checklistItem(
                  title: isBangla ? 'বায়োমেট্রিক ও লাইভনেস ফেস স্ক্যান' : 'Biometric Face Liveness',
                  subtitle: isBangla ? 'মুখমণ্ডলের লাইভনেস ফ্রেম যাচাই সম্পন্ন' : 'Facial match score: 99.4%',
                  isCompleted: true,
                  palette: palette,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
                _checklistItem(
                  title: isBangla ? 'মনোনীত ব্যক্তির তথ্য (নমিনি)' : 'Nominee Registration',
                  subtitle: isBangla ? 'ফাতেমা বেগম (স্ত্রী) • ১০০% অংশীদার' : 'Fatema Begum (Spouse) • 100% Share',
                  isCompleted: true,
                  palette: palette,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
                _checklistItem(
                  title: isBangla ? 'ব্যাংক হিসাব ও সেটেলমেন্ট' : 'Settlement Bank Account',
                  subtitle: isBangla ? 'সিটি ব্যাংক পিএলসি • গুলশান শাখা' : 'City Bank PLC • Gulshan Branch',
                  isCompleted: true,
                  palette: palette,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Verified Institutional Badge
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: AppRadius.borderZero,
              border: Border.all(color: palette.ruleStrong, width: 1.0),
            ),
            child: Row(
              children: [
                SealWidget(size: 42, isBangla: isBangla),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isBangla ? 'কেওয়াইসি সম্পূর্ণ অনুমোদিত' : 'Full Regulatory Clearance',
                        style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.pine,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isBangla
                            ? 'আপনার পরিচিতি সাভার মৌজা প্লট ৪১৮ এর জন্য কার্যকর।'
                            : 'Cleared for ownership deeds and dividend disbursements on Plot 418.',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkSecondary,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          AppButton(
            label: isBangla ? 'এনআইডি পুনরায় স্ক্যান করুন' : 'Re-scan / Update NID Document',
            variant: AppButtonVariant.primary,
            isBangla: isBangla,
            onPressed: () {
              HapticFeedback.selectionClick();
              setState(() => _step = 1);
            },
          ),
          const SizedBox(height: 10),
          AppButton(
            label: isBangla ? 'নমিনি ও ব্যাংক বিবরণী সম্পাদনা' : 'Update Nominee & Settlement Bank',
            variant: AppButtonVariant.secondary,
            isBangla: isBangla,
            onPressed: () {
              HapticFeedback.selectionClick();
              setState(() => _step = 2);
            },
          ),
        ],
      );
    } else if (_step == 1) {
      // Step 1: Hairline NID Camera Capture Frame with Edge Guides (§10)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MatraRuleWidget(width: 32, color: palette.pine),
          const SizedBox(height: 8),
          Text(
            isBangla ? 'জাতীয় পরিচয়পত্র স্ক্যান' : 'Smart NID Document Capture',
            style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isBangla
                ? 'এনআইডি কার্ডের সামনের অংশ ফ্রেমের ভেতরে সোজাভাবে রাখুন।'
                : 'Position the front of your Smart NID card within the boundary guide.',
            style: AppTypography.body(isDark: isDark, isBangla: isBangla).copyWith(
              color: palette.inkSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),

          // Hairline Framing Box with Edge Guides
          Container(
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              border: Border.all(color: palette.ruleStrong, width: 1.0),
            ),
            child: Stack(
              children: [
                _edgeGuide(Alignment.topLeft, palette),
                _edgeGuide(Alignment.topRight, palette),
                _edgeGuide(Alignment.bottomLeft, palette),
                _edgeGuide(Alignment.bottomRight, palette),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.credit_card_rounded, size: 40, color: palette.inkTertiary),
                      const SizedBox(height: 8),
                      Text(
                        isBangla ? 'কার্ড ফ্রেমের মধ্যে রাখুন' : 'Align Smart NID within frame',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // NID Number Field
          Text(
            isBangla ? 'এনআইডি নম্বর (স্বয়ংক্রিয় সনাক্তকৃত)' : 'NID Number (Auto-Detected)',
            style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 12),
          ),
          const SizedBox(height: 6),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: AppRadius.borderControl,
              border: Border.all(color: palette.ruleStrong, width: 1.0),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: _nidController,
              style: AppTypography.bodyStrong(isDark: isDark),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true),
            ),
          ),
          const SizedBox(height: 24),

          AppButton(
            label: isBangla ? 'যাচাই সম্পন্ন করুন' : 'Submit Document for Verification',
            variant: AppButtonVariant.primary,
            isBangla: isBangla,
            onPressed: () {
              HapticFeedback.selectionClick();
              setState(() => _step = 0);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBangla ? 'নথি সফলভাবে হালনাগাদ হয়েছে' : 'NID document verified successfully'),
                  backgroundColor: palette.pine,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          AppButton(
            label: isBangla ? 'পূর্ববর্তী' : 'Back',
            variant: AppButtonVariant.quiet,
            isBangla: isBangla,
            onPressed: () => setState(() => _step = 0),
          ),
        ],
      );
    } else if (_step == 2) {
      // Step 2: Nominee & Settlement Bank
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MatraRuleWidget(width: 32, color: palette.pine),
          const SizedBox(height: 8),
          Text(
            isBangla ? 'মনোনীত ব্যক্তি (নমিনি) ও ব্যাংক' : 'Nominee & Settlement Bank',
            style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            isBangla ? 'নমিনির পূর্ণ নাম' : 'Nominee Full Name',
            style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 12),
          ),
          const SizedBox(height: 6),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: AppRadius.borderControl,
              border: Border.all(color: palette.ruleStrong, width: 1.0),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: _nomineeController,
              style: AppTypography.bodyStrong(isDark: isDark),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true),
            ),
          ),
          const SizedBox(height: 14),

          Text(
            isBangla ? 'সম্পর্ক' : 'Relationship',
            style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 12),
          ),
          const SizedBox(height: 6),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: AppRadius.borderControl,
              border: Border.all(color: palette.ruleStrong, width: 1.0),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: _nomineeRelationController,
              style: AppTypography.bodyStrong(isDark: isDark),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true),
            ),
          ),
          const SizedBox(height: 24),

          AppButton(
            label: isBangla ? 'তথ্য সংরক্ষণ করুন' : 'Save Details',
            variant: AppButtonVariant.primary,
            isBangla: isBangla,
            onPressed: () {
              HapticFeedback.selectionClick();
              setState(() => _step = 0);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBangla ? 'নমিনি তথ্য হালনাগাদ হয়েছে' : 'Nominee details updated successfully'),
                  backgroundColor: palette.pine,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          AppButton(
            label: isBangla ? 'পূর্ববর্তী' : 'Back',
            variant: AppButtonVariant.quiet,
            isBangla: isBangla,
            onPressed: () => setState(() => _step = 0),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _checklistItem({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required AppPalette palette,
    required bool isDark,
    required bool isBangla,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                    color: palette.inkSecondary,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (isCompleted)
            SealWidget(size: 24, isBangla: isBangla)
          else
            Text(
              isBangla ? 'অসম্পূর্ণ' : 'Pending',
              style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                color: palette.amberInk,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _edgeGuide(Alignment alignment, AppPalette palette) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          border: Border(
            top: alignment == Alignment.topLeft || alignment == Alignment.topRight
                ? BorderSide(color: palette.pine, width: 2.0)
                : BorderSide.none,
            bottom: alignment == Alignment.bottomLeft || alignment == Alignment.bottomRight
                ? BorderSide(color: palette.pine, width: 2.0)
                : BorderSide.none,
            left: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft
                ? BorderSide(color: palette.pine, width: 2.0)
                : BorderSide.none,
            right: alignment == Alignment.topRight || alignment == Alignment.bottomRight
                ? BorderSide(color: palette.pine, width: 2.0)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
