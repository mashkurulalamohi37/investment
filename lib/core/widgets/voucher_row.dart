import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
import 'package:swapnojatri/data/models/expense_model.dart';

class VoucherRow extends StatelessWidget {
  final ExpenseModel expense;
  final bool isBangla;
  final VoidCallback? onViewBillTap;
  final VoidCallback? onDocumentTap;

  const VoucherRow({
    super.key,
    required this.expense,
    this.isBangla = false,
    this.onViewBillTap,
    this.onDocumentTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Boxed Voucher No. in 1px rule rectangle at radius 2
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: AppRadius.borderChip,
              border: Border.all(color: palette.ruleStrong, width: 1.0),
            ),
            child: Text(
              expense.voucherNo,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: palette.inkSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Centre: Stacked Payee & Category / Purpose
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  expense.payee,
                  style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${expense.category} • ${expense.approvedBy}',
                  style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                    color: palette.inkTertiary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Right: Right-aligned Amount in AmountSmall + Hairline Bill link
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                CurrencyFormatter.format(expense.amount, isBangla: isBangla),
                style: AppTypography.amountSmall(isDark: isDark, isBangla: isBangla).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              InkWell(
                onTap: () {
                  final handler = onViewBillTap ?? onDocumentTap;
                  if (handler != null) {
                    handler();
                  } else {
                    _showVoucherModal(context, expense, palette, isDark, isBangla);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isBangla ? 'ভাউচার রসিদ' : 'View Bill',
                      style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                        color: palette.pine,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void _showVoucherModal(
    BuildContext context,
    ExpenseModel expense,
    AppPalette palette,
    bool isDark,
    bool isBangla,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'অনুমোদিত ভাউচার রসিদ' : 'Approved Expense Voucher',
                    style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SealWidget(size: 32, isBangla: isBangla),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              _modalRow('ভাউচার নং / Voucher No', expense.voucherNo, palette, isDark),
              const SizedBox(height: 10),
              _modalRow('প্রাপক / Payee', expense.payee, palette, isDark),
              const SizedBox(height: 10),
              _modalRow('বিবরণ / Purpose', expense.description, palette, isDark),
              const SizedBox(height: 10),
              _modalRow('অনুমোদনকারী / Auditor', expense.approvedBy, palette, isDark),
              const SizedBox(height: 10),
              _modalRow('অর্থের পরিমাণ / Amount', CurrencyFormatter.format(expense.amount, isBangla: isBangla), palette, isDark, isHighlight: true),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: palette.ruleStrong),
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.borderControl),
                  ),
                  child: Text(isBangla ? 'বন্ধ করুন' : 'Close', style: TextStyle(color: palette.ink)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _modalRow(String label, String value, AppPalette palette, bool isDark, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.caption(isDark: isDark)),
        Text(
          value,
          style: AppTypography.bodyStrong(isDark: isDark).copyWith(
            fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
            color: isHighlight ? palette.pine : palette.ink,
          ),
        ),
      ],
    );
  }
}

// Backward compatibility alias for ExpenseTile
typedef ExpenseTile = VoucherRow;
