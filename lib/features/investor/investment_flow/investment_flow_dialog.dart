import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/investment_flow/bank_transfer_upload_sheet.dart';
import 'package:swapnojatri/features/investor/investment_flow/eps_checkout_sheet.dart';

class InvestmentFlowDialog extends StatefulWidget {
  final ProjectModel project;
  final AppState state;

  const InvestmentFlowDialog({
    super.key,
    required this.project,
    required this.state,
  });

  static Future<void> show({
    required BuildContext context,
    required ProjectModel project,
    required AppState state,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InvestmentFlowDialog(project: project, state: state),
    );
  }

  @override
  State<InvestmentFlowDialog> createState() => _InvestmentFlowDialogState();
}

class _InvestmentFlowDialogState extends State<InvestmentFlowDialog> {
  int _step = 1; // Step 1: Buy Share Stepper, Step 2: Payment Method Choice
  int _shareCount = 3;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;
    final project = widget.project;
    final availableShares = project.totalShares - project.allocatedShares;

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: palette.ruleStrong,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 18),

          if (_step == 1) ...[
            // ==========================================
            // SCREEN 8: Invest / Buy Share Stepper
            // ==========================================
            Text(
              isBangla ? '${project.name} এ বিনিয়োগ করুন' : 'Invest in ${project.name}',
              style: GoogleFonts.hindSiliguri(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: palette.ink,
              ),
            ),
            Text(
              project.location,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: palette.inkSecondary,
              ),
            ),
            const SizedBox(height: 20),

            // Share Price Info Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: palette.rule, width: 1.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'শেয়ার মূল্য (প্রতি শেয়ার)' : 'Share Price',
                    style: GoogleFonts.hindSiliguri(fontSize: 13, color: palette.inkSecondary),
                  ),
                  Text(
                    '৳ 25,500',
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: palette.ink),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stepper: Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepperButton(
                  icon: Icons.remove,
                  onTap: _shareCount > project.minShares
                      ? () => setState(() => _shareCount--)
                      : null,
                  palette: palette,
                ),
                const SizedBox(width: 24),
                Column(
                  children: [
                    Text(
                      '$_shareCount',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: palette.ink,
                      ),
                    ),
                    Text(
                      isBangla ? 'টি শেয়ার' : 'Shares',
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 12,
                        color: palette.inkSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                _buildStepperButton(
                  icon: Icons.add,
                  onTap: _shareCount < project.maxShares && _shareCount < availableShares
                      ? () => setState(() => _shareCount++)
                      : null,
                  palette: palette,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Investment Breakdown Details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: palette.rule, width: 1.0),
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    isBangla ? 'মোট বিনিয়োগ' : 'Total Investment',
                    '৳ ${(_shareCount * project.sharePrice).toInt()}',
                    palette,
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    isBangla ? 'প্রত্যাশিত বার্ষিক মুনাফা' : 'Projected Annual ROI',
                    '18.5% ~ 22.0%',
                    palette,
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    isBangla ? 'সর্বোচ্চ সীমা' : 'Max Allowed',
                    '${project.maxShares} ${isBangla ? 'টি শেয়ার' : 'Shares'}',
                    palette,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Next Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => setState(() => _step = 2),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  isBangla ? 'পেমেন্ট মাধ্যমে এগিয়ে যান' : 'Proceed to Payment',
                  style: GoogleFonts.hindSiliguri(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ] else ...[
            // ==========================================
            // SCREEN 9: Payment Gateway & Method Selection
            // ==========================================
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 20),
                  onPressed: () => setState(() => _step = 1),
                ),
                Expanded(
                  child: Text(
                    isBangla ? 'পেমেন্ট মাধ্যম বেছে নিন' : 'Choose Payment Option',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: palette.ink,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Project Breakdown Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: palette.rule, width: 1.0),
              ),
              child: Column(
                children: [
                  _buildSummaryRow(isBangla ? 'প্রকল্প' : 'Project', project.name, palette),
                  const SizedBox(height: 6),
                  _buildSummaryRow(isBangla ? 'শেয়ার সংখ্যা' : 'Shares', '$_shareCount টি', palette),
                  const SizedBox(height: 6),
                  _buildSummaryRow(
                    isBangla ? 'মোট প্রদেয়' : 'Total Payable',
                    '৳ ${(_shareCount * project.sharePrice).toInt()}',
                    palette,
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Option 1: EPS Payment Gateway
            _buildGatewayMethodCard(
              title: 'EPS Payment Gateway',
              badge: isBangla ? 'ইনস্ট্যান্ট বরাদ্দ' : 'Instant Allocation',
              badgeColor: const Color(0xFF00C853),
              description: isBangla
                  ? 'bKash, Nagad, Rocket, Visa/Mastercard এবং ইন্টারনেট ব্যাংকিং।'
                  : 'Pay with bKash, Nagad, Rocket, Cards & Net Banking.',
              icon: Icons.bolt_rounded,
              iconBgColor: const Color(0xFF0066FF),
              palette: palette,
              isBangla: isBangla,
              onTap: () async {
                final nav = Navigator.of(context);
                final scaffold = ScaffoldMessenger.of(context);
                nav.pop(); // close current sheet

                await EpsCheckoutSheet.show(
                  context: context,
                  project: project,
                  shareCount: _shareCount,
                  state: widget.state,
                  onPaymentSuccess: () {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(
                          isBangla
                              ? 'EPS গেটওয়ের মাধ্যমে পেমেন্ট সফলভাবে সম্পন্ন হয়েছে! শেয়ার বরাদ্দ নিশ্চিত।'
                              : 'Payment completed via EPS Gateway! Shares allocated.',
                        ),
                        backgroundColor: const Color(0xFF00C853),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 12),

            // Option 2: Manual Bank Transfer & Receipt Upload
            _buildGatewayMethodCard(
              title: isBangla ? 'ব্যাংক ট্রান্সফার ও রসিদ আপলোড' : 'Bank Deposit & Slip Upload',
              badge: isBangla ? 'ম্যানুয়াল ভেরিফিকেশন' : 'Manual Review',
              badgeColor: const Color(0xFFFF9800),
              description: isBangla
                  ? 'সিটি ব্যাংক / ব্র্যাক / ইসলামী ব্যাংক অ্যাকাউন্টে জমা দিয়ে স্লিপের ছবি আপলোড করুন।'
                  : 'Transfer to official bank account & upload deposit receipt photo.',
              icon: Icons.receipt_long_rounded,
              iconBgColor: const Color(0xFF7B1FA2),
              palette: palette,
              isBangla: isBangla,
              onTap: () async {
                final nav = Navigator.of(context);
                final scaffold = ScaffoldMessenger.of(context);
                nav.pop(); // close current sheet

                await BankTransferUploadSheet.show(
                  context: context,
                  project: project,
                  shareCount: _shareCount,
                  state: widget.state,
                  onSubmitSuccess: () {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(
                          isBangla
                              ? 'ব্যাংক জমার রসিদ সফলভাবে দাখিল হয়েছে! অ্যাডমিন যাচাইয়ের পর শেয়ার বরাদ্দ হবে।'
                              : 'Deposit slip submitted for admin verification!',
                        ),
                        backgroundColor: const Color(0xFF0066FF),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildGatewayMethodCard({
    required String title,
    required String badge,
    required Color badgeColor,
    required String description,
    required IconData icon,
    required Color iconBgColor,
    required AppPalette palette,
    required bool isBangla,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: palette.ruleStrong, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconBgColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: palette.ink,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          badge,
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: badgeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 11.5,
                      color: palette.inkSecondary,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.chevron_right_rounded, color: palette.inkTertiary, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperButton({
    required IconData icon,
    required VoidCallback? onTap,
    required AppPalette palette,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: onTap != null ? const Color(0xFF0066FF).withValues(alpha: 0.1) : palette.surfaceSunken,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: onTap != null ? const Color(0xFF0066FF).withValues(alpha: 0.3) : palette.rule,
          width: 1.0,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: onTap != null ? const Color(0xFF0066FF) : palette.inkTertiary),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, AppPalette palette, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.hindSiliguri(
            fontSize: 12.5,
            color: palette.inkSecondary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isBold ? 14 : 12.5,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? const Color(0xFF0066FF) : palette.ink,
          ),
        ),
      ],
    );
  }
}
