import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/widgets/brand_icons.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

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
  int _step = 1; // Step 1: Buy Share Stepper, Step 2: Payment Confirmation
  int _shareCount = 3;
  String _selectedPaymentMethod = 'bKash';
  bool _isProcessing = false;

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

            // Stepper Row
            Text(
              isBangla ? 'কত শেয়ার নিতে চান?' : 'Select number of shares',
              style: GoogleFonts.hindSiliguri(fontSize: 14, fontWeight: FontWeight.w600, color: palette.ink),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepperButton(
                  icon: Icons.remove,
                  onTap: _shareCount > 1
                      ? () {
                          HapticFeedback.selectionClick();
                          setState(() => _shareCount--);
                        }
                      : null,
                  palette: palette,
                ),
                Container(
                  width: 72,
                  alignment: Alignment.center,
                  child: Text(
                    '$_shareCount',
                    style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700, color: palette.ink),
                  ),
                ),
                _buildStepperButton(
                  icon: Icons.add,
                  onTap: _shareCount < availableShares
                      ? () {
                          HapticFeedback.selectionClick();
                          setState(() => _shareCount++);
                        }
                      : null,
                  palette: palette,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isBangla ? 'উপলব্ধ শেয়ার: $availableShares' : 'Available Shares: $availableShares',
              style: GoogleFonts.hindSiliguri(fontSize: 12, color: palette.inkSecondary),
            ),
            const SizedBox(height: 24),

            // Total Amount Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF0066FF).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF0066FF).withValues(alpha: 0.3), width: 1.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'মোট পরিমাণ' : 'Total Amount',
                    style: GoogleFonts.hindSiliguri(fontSize: 14, fontWeight: FontWeight.w600, color: palette.ink),
                  ),
                  Text(
                    '৳ ${(_shareCount * project.sharePrice).toInt()}',
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF0066FF)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

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
                  isBangla ? 'পরবর্তী' : 'Next',
                  style: GoogleFonts.hindSiliguri(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ] else ...[
            // ==========================================
            // SCREEN 9: Payment Confirmation Modal
            // ==========================================
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0066FF).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, size: 48, color: Color(0xFF0066FF)),
            ),
            const SizedBox(height: 12),

            Text(
              isBangla ? 'বিনিয়োগের অনুরোধ সফল হয়েছে!' : 'Investment Request Submitted!',
              style: GoogleFonts.hindSiliguri(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: palette.ink,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isBangla ? 'আপনার পেমেন্ট সম্পন্ন করে বিনিয়োগ নিশ্চিত করুন।' : 'Complete your payment to confirm investment.',
              textAlign: TextAlign.center,
              style: GoogleFonts.hindSiliguri(fontSize: 12.5, color: palette.inkSecondary),
            ),
            const SizedBox(height: 18),

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
                  _buildSummaryRow(isBangla ? 'শেয়ার' : 'Shares', '$_shareCount', palette),
                  const SizedBox(height: 6),
                  _buildSummaryRow(
                    isBangla ? 'মোট পরিমাণ' : 'Total Amount',
                    '৳ ${(_shareCount * project.sharePrice).toInt()}',
                    palette,
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Payment Methods
            Text(
              isBangla ? 'পেমেন্ট মাধ্যম নির্বাচন করুন' : 'Select Payment Method',
              style: GoogleFonts.hindSiliguri(fontSize: 13, fontWeight: FontWeight.w600, color: palette.ink),
            ),
            const SizedBox(height: 10),

            _buildPaymentOption(
              title: 'bKash',
              subtitle: '01812-345678 (মার্চেন্ট)',
              logoWidget: const BkashLogoWidget(size: 32),
              palette: palette,
            ),
            const SizedBox(height: 8),
            _buildPaymentOption(
              title: 'Nagad',
              subtitle: '01812-345678 (মার্চেন্ট)',
              logoWidget: const NagadLogoWidget(size: 32),
              palette: palette,
            ),
            const SizedBox(height: 8),
            _buildPaymentOption(
              title: 'Rocket',
              subtitle: '01812-345678-7 (ডিবিবিএল রকেট)',
              logoWidget: const RocketLogoWidget(size: 32),
              palette: palette,
            ),
            const SizedBox(height: 8),
            _buildPaymentOption(
              title: 'Bank Wire',
              subtitle: 'BRAC Bank / Islamic Bank A/C',
              logoWidget: const BankTransferLogoWidget(size: 32),
              palette: palette,
            ),
            const SizedBox(height: 14),

            Text(
              isBangla
                  ? 'পেমেন্ট সম্পন্ন করে নিচের বাটনে ক্লিক করুন।'
                  : 'After making payment, click below to confirm.',
              textAlign: TextAlign.center,
              style: GoogleFonts.hindSiliguri(fontSize: 11, color: palette.inkTertiary),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isProcessing
                    ? null
                    : () async {
                        final navigator = Navigator.of(context);
                        final messenger = ScaffoldMessenger.of(context);
                        setState(() => _isProcessing = true);
                        await Future.delayed(const Duration(milliseconds: 600));
                        widget.state.investInProject(project.id, _shareCount, _selectedPaymentMethod);
                        if (!mounted) return;
                        navigator.pop();
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text(
                              isBangla
                                  ? '$_selectedPaymentMethod এর মাধ্যমে পেমেন্ট সফলভাবে জমা হয়েছে!'
                                  : 'Payment submitted via $_selectedPaymentMethod!',
                            ),
                            backgroundColor: const Color(0xFF00C853),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isProcessing
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(
                        isBangla ? 'আমি পেমেন্ট করেছি' : 'I Have Completed Payment',
                        style: GoogleFonts.hindSiliguri(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
              ),
            ),
          ],
        ],
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

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required Widget logoWidget,
    required AppPalette palette,
  }) {
    final isSelected = _selectedPaymentMethod == title;
    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = title),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF0066FF) : palette.ruleStrong,
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                logoWidget,
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w700, color: palette.ink),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              size: 20,
              color: isSelected ? const Color(0xFF0066FF) : palette.inkTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
