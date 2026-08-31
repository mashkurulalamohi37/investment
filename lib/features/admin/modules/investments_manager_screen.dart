import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/status_chip.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/data/models/investment_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AdminInvestmentsManagerScreen extends StatelessWidget {
  final AppState state;

  const AdminInvestmentsManagerScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final investments = state.investments;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'বিনিয়োগ যাচাই ও শেয়ার লট বরাদ্দ' : 'Investments & Share Allocation',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: palette.pineTint,
                borderRadius: AppRadius.borderCard,
                border: Border.all(
                  color: palette.pine.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.admin_panel_settings_rounded, color: palette.pine, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBangla ? 'পারমাণবিক শেয়ার বরাদ্দ কনসোল' : 'Atomic Share Allocation Engine',
                          style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          isBangla
                              ? 'পেমেন্ট রেফারেন্স যাচাই করার সাথে সাথে স্বয়ংক্রিয়ভাবে পরবর্তী ধারাবাহিক লট নম্বর বরাদ্দ হবে।'
                              : 'Verifying payment assigns next sequential lot numbers without duplicates.',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text(
              isBangla ? 'আবেদন তালিকা (${investments.length})' : 'Investment Applications (${investments.length})',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            ...investments.map((inv) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inv.investmentNo,
                                style: AppTypography.headingSmall(isDark: isDark).copyWith(
                                  fontFamily: 'monospace',
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                '${inv.projectName} • ${CurrencyFormatter.formatDate(inv.createdAt, isBangla: isBangla)}',
                                style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                              ),
                            ],
                          ),
                          StatusChip.investment(inv.status, isBangla: isBangla),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Divider(color: palette.rule, height: 1),
                      const SizedBox(height: 10),

                      _infoRow(isBangla ? 'আবেদনকৃত শেয়ার' : 'Shares', '${inv.shares} Shares (@ ৳${inv.unitPrice.toInt()})', palette, isDark),
                      _infoRow(isBangla ? 'মোট অর্থ' : 'Total Amount', CurrencyFormatter.format(inv.grossAmount, isBangla: isBangla), palette, isDark),
                      _infoRow(isBangla ? 'পেমেন্ট চ্যানেল' : 'Payment Method', inv.paymentMethod ?? 'Bank Transfer', palette, isDark),
                      _infoRow(isBangla ? 'ট্রানজেকশন রেফারেন্স' : 'Transaction Ref', inv.paymentReference ?? 'N/A', palette, isDark),

                      if (inv.allocatedLotNumbers.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _infoRow(isBangla ? 'বরাদ্দকৃত লট' : 'Allocated Lots', inv.allocatedLotNumbers.join(', '), palette, isDark),
                      ],

                      if (inv.status == InvestmentStatus.pending) ...[
                        const SizedBox(height: 14),
                        AppButton(
                          label: isBangla ? 'পেমেন্ট যাচাই ও শেয়ার বরাদ্দ করুন' : 'Verify Payment & Allocate Lots',
                          onPressed: () {
                            state.adminVerifyAndAllocateShare(inv.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isBangla
                                      ? 'পেমেন্ট সফলভাবে যাচাই হয়েছে এবং শেয়ার লট বরাদ্দ সম্পন্ন হয়েছে!'
                                      : 'Payment verified and share lots allocated atomically!',
                                ),
                                backgroundColor: palette.pine,
                              ),
                            );
                          },
                          icon: Icons.task_alt_rounded,
                          variant: AppButtonVariant.primary,
                          isBangla: isBangla,
                        ),
                      ],
                    ],
                  ),
                )),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, AppPalette palette, bool isDark) {
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
