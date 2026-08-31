import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/models/transaction_model.dart';
import 'package:intl/intl.dart';

class LedgerRow extends StatelessWidget {
  final TransactionModel transaction;
  final bool isBangla;
  final VoidCallback? onTap;

  const LedgerRow({
    super.key,
    required this.transaction,
    this.isBangla = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isCredit = transaction.type == TransactionType.dividend ||
        transaction.type == TransactionType.profitDistribution ||
        transaction.type == TransactionType.refund;

    final dateDayMonth = DateFormat('dd MMM').format(transaction.timestamp);
    final dateYear = DateFormat('yyyy').format(transaction.timestamp);

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 64),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: palette.surface,
          border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
        ),
        child: Row(
          children: [
            // Left Margin Date Column
            SizedBox(
              width: 48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isBangla ? CurrencyFormatter.toBanglaDigits(dateDayMonth) : dateDayMonth,
                    style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                      color: palette.inkSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    isBangla ? CurrencyFormatter.toBanglaDigits(dateYear) : dateYear,
                    style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                      color: palette.inkTertiary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // 2px Vertical Indicator Bar
            Container(
              width: 2.0,
              height: 22,
              color: isCredit ? palette.jade : palette.inkTertiary,
            ),
            const SizedBox(width: 12),

            // Column 1: Description & Ref ID
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transaction.title,
                    style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${transaction.referenceId} • ${transaction.paymentMethod ?? 'Direct Deposit'}',
                    style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                      color: palette.inkTertiary,
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Column 2: Signed Amount & Status (Aligned Decimal Axis)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${isCredit ? '+' : '−'} ${CurrencyFormatter.format(transaction.amount, isBangla: isBangla, includeSymbol: true)}',
                  style: AppTypography.amountSmall(isDark: isDark, isBangla: isBangla).copyWith(
                    color: isCredit ? palette.jade : palette.ink,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _statusLabel(transaction.status, isBangla),
                  style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                    color: _statusColor(transaction.status, palette),
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(TransactionStatus status, bool isBangla) {
    switch (status) {
      case TransactionStatus.completed:
        return isBangla ? 'সম্পন্ন' : 'Completed';
      case TransactionStatus.pending:
        return isBangla ? 'যাচাই অপেক্ষমাণ' : 'Pending';
      case TransactionStatus.failed:
        return isBangla ? 'ব্যর্থ' : 'Failed';
      case TransactionStatus.refunded:
        return isBangla ? 'ফেরত' : 'Refunded';
      case TransactionStatus.reversed:
        return isBangla ? 'বাতিল' : 'Reversed';
    }
  }

  Color _statusColor(TransactionStatus status, AppPalette palette) {
    switch (status) {
      case TransactionStatus.completed:
        return palette.jade;
      case TransactionStatus.pending:
        return palette.amberInk;
      case TransactionStatus.failed:
        return palette.vermilion;
      case TransactionStatus.refunded:
      case TransactionStatus.reversed:
        return palette.slate;
    }
  }
}

// Backward compatibility alias for TransactionTile
typedef TransactionTile = LedgerRow;
