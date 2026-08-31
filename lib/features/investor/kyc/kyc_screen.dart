import 'package:flutter/material.dart';
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
    _nomineeController.dispose();
    _nomineeRelationController.dispose();
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
      // Step 0: Ruled Checklist with Seals for Completed Items (§10)
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
                  title: isBangla ? 'ব্যাংক হিসাব বিবরণী' : 'Bank Account Information',
                  subtitle: isBangla ? 'সিটি ব্যাংক হিসাব • ০১৭১২৩৪৫৬৭৮' : 'City Bank A/C • 110-348-99201',
                  isCompleted: true,
                  palette: palette,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
                _checklistItem(
                  title: isBangla ? 'নমিনী ঘোষণা ও এনআইডি' : 'Nominee Declaration',
                  subtitle: isBangla ? 'ফাতেমা বেগম (স্ত্রী)' : 'Fatema Begum (Spouse)',
                  isCompleted: true,
                  palette: palette,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
                _checklistItem(
                  title: isBangla ? 'আবাসিক ঠিকানা প্রত্যয়ন' : 'Residential Utility Verification',
                  subtitle: isBangla ? 'যাচাইয়ের জন্য নথি আপলোড করুন' : 'Pending Document Upload',
                  isCompleted: false,
                  palette: palette,
                  isDark: isDark,
                  isBangla: isBangla,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          AppButton(
            label: isBangla ? 'নতুন নথি আপলোড করুন' : 'Upload Verification Document',
            variant: AppButtonVariant.primary,
            isBangla: isBangla,
            onPressed: () => setState(() => _step = 1),
          ),
        ],
      );
    } else if (_step == 1) {
      // Step 1: Hairline Capture Frame with Edge Guides (§10)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBangla ? 'এনআইডি কার্ড স্ক্যান ফ্রেম' : 'National ID Document Capture',
            style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isBangla ? 'কার্ডের চারটি কোণ ফ্রেমের সীমানার ভেতরে রাখুন।' : 'Align all four corners of your card inside the frame.',
            style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(color: palette.inkSecondary),
          ),
          const SizedBox(height: 24),

          // Hairline Capture Frame with Edge Guides
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              border: Border.all(color: palette.ruleStrong, width: 1.0),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt_outlined, size: 28, color: palette.inkTertiary),
                      const SizedBox(height: 6),
                      Text(
                        isBangla ? 'এনআইডি ফ্রন্ট সাইড' : 'Front of National ID',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(color: palette.inkSecondary),
                      ),
                    ],
                  ),
                ),
                // 4 Edge Guides
                _edgeGuide(Alignment.topLeft, palette),
                _edgeGuide(Alignment.topRight, palette),
                _edgeGuide(Alignment.bottomLeft, palette),
                _edgeGuide(Alignment.bottomRight, palette),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            isBangla ? 'এনআইডি নম্বর' : 'NID Number',
            style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla),
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
              setState(() => _step = 0);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBangla ? 'নথি পর্যালোচনার জন্য জমা হয়েছে' : 'Document submitted for compliance review'),
                  backgroundColor: palette.pine,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          AppButton(
            label: isBangla ? 'বাতিল করুন' : 'Cancel',
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
