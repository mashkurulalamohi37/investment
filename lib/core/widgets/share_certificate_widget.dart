import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/guilloche_painter.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';

class ShareCertificateWidget extends StatelessWidget {
  final String investorName;
  final String lotNumbers;
  final int shareCount;
  final double totalValue;
  final String certificateNo;
  final DateTime issueDate;
  final bool isBangla;

  const ShareCertificateWidget({
    super.key,
    required this.investorName,
    required this.lotNumbers,
    required this.shareCount,
    required this.totalValue,
    this.certificateNo = 'LV100-CERT-0042',
    required this.issueDate,
    this.isBangla = false,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'মালিকানা সনদপত্র' : 'Ownership Certificate',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBangla ? 'সনদপত্র পিডিএফ প্রস্তুত হচ্ছে...' : 'Generating official PDF certificate...'),
                  backgroundColor: palette.pine,
                ),
              );
            },
            icon: const Icon(Icons.download_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // The Certificate Paper Container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderZero,
                  border: Border.all(color: palette.ruleStrong, width: 1.0),
                ),
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: palette.brass, width: 1.0),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: palette.brass.withValues(alpha: 0.6), width: 0.6),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        // Centered Guilloche Rosette Watermark
                        Positioned.fill(
                          child: Center(
                            child: GuillocheWidget(size: 220, color: palette.brass),
                          ),
                        ),

                        // Certificate Content Layout
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Top Boxed Serial Number
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'SWAPNOJATRI / LV100',
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 9.5,
                                    color: palette.inkTertiary,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: palette.surfaceSunken,
                                    borderRadius: AppRadius.borderChip,
                                    border: Border.all(color: palette.brass, width: 0.8),
                                  ),
                                  child: Text(
                                    'SERIAL: $certificateNo',
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 9.5,
                                      color: palette.brass,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Header Titles
                            Text(
                              isBangla ? 'স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম' : 'SWAPNOJATRI INVESTMENT PLATFORM',
                              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w600,
                                color: palette.inkSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              isBangla ? 'অংশীদারি ভূমি মালিকানা সনদপত্র' : 'CERTIFICATE OF LAND OWNERSHIP',
                              style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: palette.pine,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Container(width: 48, height: 1.5, color: palette.brass),
                            const SizedBox(height: 20),

                            // Certification Statement
                            Text(
                              isBangla
                                  ? 'এতদ্বারা প্রত্যয়ন করা যাইতেছে যে, নিম্নবর্ণিত বিনিয়োগকারী ল্যান্ডভেস্ট ১০০ প্রকল্পের অধীনে সাভার মৌজাস্থ প্লট নং ৪১৮-এর নিম্নোক্ত চিহ্নিত অংশসমূহের বৈধ স্বত্বাধিকারী।'
                                  : 'This is to certify that the undermentioned investor holds recognized fractional ownership in Plot #418, Savar Mouza under the LandVest 100 Project.',
                              style: AppTypography.body(isDark: isDark, isBangla: isBangla).copyWith(
                                fontSize: 13,
                                height: 1.6,
                                color: palette.inkSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),

                            // Holder Name in TitleLarge Serif
                            Text(
                              isBangla ? 'সনদ প্রাপক / Holder Name' : 'REGISTERED OWNER',
                              style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                                color: palette.inkTertiary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              investorName,
                              style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: palette.ink,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Ruled Data Grid
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: palette.surfaceSunken,
                                borderRadius: AppRadius.borderZero,
                                border: Border.all(color: palette.ruleStrong, width: 0.8),
                              ),
                              child: Column(
                                children: [
                                  _certDataRow(isBangla ? 'চিহ্নিত লট নং' : 'Allocated Lots', lotNumbers, palette, isDark),
                                  const Divider(height: 12),
                                  _certDataRow(
                                    isBangla ? 'মোট শেয়ার অংশ' : 'Total Shares',
                                    isBangla ? '${CurrencyFormatter.toBanglaDigits(shareCount.toString())} টি অংশ (১০০টির মধ্যে)' : '$shareCount of 100 Shares',
                                    palette,
                                    isDark,
                                  ),
                                  const Divider(height: 12),
                                  _certDataRow(
                                    isBangla ? 'মূলধনী মূল্য' : 'Capital Value',
                                    CurrencyFormatter.format(totalValue, isBangla: isBangla),
                                    palette,
                                    isDark,
                                    isBold: true,
                                  ),
                                  const Divider(height: 12),
                                  _certDataRow(
                                    isBangla ? 'সাব-রেজিস্ট্রি দলিল' : 'Title Deed',
                                    '#4982/2026 (Savar Sub-Registry)',
                                    palette,
                                    isDark,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 36),

                            // Bottom Signatures & Overlapping Seal
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left: Registrar Signature line
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(width: 100, height: 1, color: palette.inkTertiary),
                                        const SizedBox(height: 4),
                                        Text('রেজিস্ট্রার / Registrar', style: AppTypography.micro(isDark: isDark, isBangla: isBangla)),
                                      ],
                                    ),
                                    // Right: Managing Director Signature line
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(width: 100, height: 1, color: palette.inkTertiary),
                                        const SizedBox(height: 4),
                                        Text('ব্যবস্থাপনা পরিচালক / MD', style: AppTypography.micro(isDark: isDark, isBangla: isBangla)),
                                      ],
                                    ),
                                  ],
                                ),

                                // Overlapping -7° Brass Seal
                                Positioned(
                                  left: 20,
                                  bottom: -10,
                                  child: Transform.rotate(
                                    angle: -7.0 * (math.pi / 180.0),
                                    child: SealWidget(size: 72, isBangla: isBangla),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Export Button
              AppButton(
                label: isBangla ? 'অফিসিয়াল সনদ ডাউনলোড (PDF)' : 'Download Official Certificate (PDF)',
                variant: AppButtonVariant.secondary,
                isBangla: isBangla,
                icon: Icons.download_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isBangla ? 'সনদপত্র ডাউনলোড সম্পন্ন হয়েছে' : 'Official Certificate downloaded to device'),
                      backgroundColor: palette.pine,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _certDataRow(String label, String value, AppPalette palette, bool isDark, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 105),
          child: Text(
            label,
            style: AppTypography.caption(isDark: isDark).copyWith(
              color: palette.inkSecondary,
              fontSize: 11,
              height: 1.3,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTypography.bodyStrong(isDark: isDark).copyWith(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              fontSize: 11.5,
              color: palette.ink,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
