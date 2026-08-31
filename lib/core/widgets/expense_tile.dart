import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/models/expense_model.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel expense;
  final bool isBangla;
  final VoidCallback? onDocumentTap;
  final VoidCallback? onViewBillTap;

  const ExpenseTile({
    super.key,
    required this.expense,
    required this.isBangla,
    this.onDocumentTap,
    this.onViewBillTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: AppRadius.borderLg,
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Category badge & Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primarySubtle,
                  borderRadius: AppRadius.borderXs,
                  border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3), width: 0.8),
                ),
                child: Text(
                  expense.category,
                  style: AppTypography.caption().copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              Text(
                CurrencyFormatter.format(expense.amount, isBangla: isBangla),
                style: AppTypography.financialAmountSmall(
                  isDark: isDark,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Description & Payee
          Text(
            expense.description,
            style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.person_outline_rounded, size: 13, color: AppColors.lightTextMuted),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  expense.payee,
                  style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          const Divider(height: 1),
          const SizedBox(height: 8),

          // Bottom audit trail footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.verified_user_outlined, size: 12, color: AppColors.success),
                  const SizedBox(width: 4),
                  Text(
                    isBangla ? 'অনুমোদিত ভাউচার: ${expense.voucherNo}' : 'Approved Voucher: ${expense.voucherNo}',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                      fontSize: 10.5,
                      color: AppColors.successDark,
                    ),
                  ),
                ],
              ),
              if (expense.documentRef != null)
                GestureDetector(
                  onTap: onViewBillTap ?? onDocumentTap,
                  child: Row(
                    children: [
                      const Icon(Icons.receipt_long_outlined, size: 13, color: AppColors.accentGoldDark),
                      const SizedBox(width: 3),
                      Text(
                        isBangla ? 'রসিদ দেখুন' : 'View Bill',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          color: isDark ? AppColors.accentGoldLight : AppColors.accentGoldDark,
                          fontWeight: FontWeight.w700,
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
}
