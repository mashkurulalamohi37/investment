import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/status_chip.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/data/models/kyc_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AdminKycApprovalsScreen extends StatelessWidget {
  final AppState state;

  const AdminKycApprovalsScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final kyc = state.kyc;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          isBangla ? 'কেওয়াইসি ও বিনিয়োগকারী অনুমোদন' : 'KYC Compliance Queue',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => state.toggleLanguage(),
            child: Text(
              isBangla ? 'EN' : 'বাং',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: palette.pine,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: AppRadius.borderCard,
                border: Border.all(
                  color: palette.rule,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        kyc.fullName,
                        style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla).copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      StatusChip.kyc(kyc.status, isBangla: isBangla),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: palette.rule, height: 1),
                  const SizedBox(height: 10),

                  _row(isBangla ? 'এনআইডি নম্বর' : 'NID Number', kyc.nidNumber, palette, isDark),
                  _row(isBangla ? 'পিতার নাম' : "Father's Name", kyc.fatherName, palette, isDark),
                  _row(isBangla ? 'মাতার নাম' : "Mother's Name", kyc.motherName, palette, isDark),
                  _row(isBangla ? 'বর্তমান ঠিকানা' : 'Address', kyc.presentAddress, palette, isDark),
                  _row(isBangla ? 'ব্যাংক হিসাব' : 'Bank A/C', '${kyc.bankName} (${kyc.bankAccountNumber})', palette, isDark),

                  if (kyc.nominee != null) ...[
                    const SizedBox(height: 8),
                    _row(
                      isBangla ? 'নমিনি' : 'Nominee',
                      '${kyc.nominee!.name} (${kyc.nominee!.relationship})',
                      palette,
                      isDark,
                    ),
                  ],

                  if (kyc.status != KycStatus.verified) ...[
                    const SizedBox(height: 16),
                    AppButton(
                      label: isBangla ? 'কেওয়াইসি অনুমোদন করুন (Verify Investor)' : 'Approve & Verify Investor',
                      onPressed: () {
                        state.adminApproveKyc();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isBangla ? 'কেওয়াইসি সফলভাবে অনুমোদিত হয়েছে!' : 'KYC verified successfully!',
                            ),
                            backgroundColor: palette.pine,
                          ),
                        );
                      },
                      icon: Icons.verified_user_rounded,
                      variant: AppButtonVariant.primary,
                      isBangla: isBangla,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, AppPalette palette, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              color: palette.inkSecondary,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: palette.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
