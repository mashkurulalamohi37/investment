import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/ledger_row.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
import 'package:swapnojatri/data/models/transaction_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class TransactionsScreen extends StatefulWidget {
  final AppState state;

  const TransactionsScreen({
    super.key,
    required this.state,
  });

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  int _selectedFilter = 0;

  final List<String> _filtersEn = ['All Ledger', 'Investments', 'Dividends', 'Pending'];
  final List<String> _filtersBn = ['সকল লেজার', 'বিনিয়োগ জমা', 'লভ্যাংশ প্রাপ্তি', 'যাচাইাধীন'];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final transactions = widget.state.transactions;
    final filterLabels = isBangla ? _filtersBn : _filtersEn;

    final filtered = transactions.where((t) {
      if (_selectedFilter == 1) return t.type == TransactionType.sharePurchase;
      if (_selectedFilter == 2) return t.type == TransactionType.dividend;
      if (_selectedFilter == 3) return t.status == TransactionStatus.pending;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'আর্থিক লেনদেন ও লেজার' : 'Transactions & Ledger Book',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showExportSheet(context, palette, isDark, isBangla),
            icon: const Icon(Icons.download_rounded, size: 20),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Hairline Filter Row with Matra Underline on Active One
            Container(
              decoration: BoxDecoration(
                color: palette.surface,
                border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(filterLabels.length, (idx) {
                    final isSelected = _selectedFilter == idx;
                    return InkWell(
                      onTap: () => setState(() => _selectedFilter = idx),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected ? palette.pine : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          filterLabels[idx],
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                            color: isSelected ? palette.pine : palette.inkSecondary,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Ruled Ledger Rows List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: filtered.length,
                itemBuilder: (context, idx) {
                  return LedgerRow(
                    transaction: filtered[idx],
                    isBangla: isBangla,
                    onTap: () => _showTxnDetailModal(context, filtered[idx], palette, isDark, isBangla),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTxnDetailModal(BuildContext context, TransactionModel txn, AppPalette palette, bool isDark, bool isBangla) {
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'লেনদেনের বিস্তারিত রসিদ' : 'Transaction Receipt',
                    style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(fontWeight: FontWeight.w600),
                  ),
                  SealWidget(size: 28, isBangla: isBangla),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              _modalDetailRow('রেফারেন্স / Ref ID', txn.referenceId, palette, isDark),
              const SizedBox(height: 10),
              _modalDetailRow('শিরোনাম / Title', txn.title, palette, isDark),
              const SizedBox(height: 10),
              _modalDetailRow('মাধ্যম / Payment Channel', txn.paymentMethod ?? 'City Bank Escrow', palette, isDark),
              const SizedBox(height: 10),
              _modalDetailRow('পরিমাণ / Amount', '৳ ${txn.amount.toStringAsFixed(0)}', palette, isDark, isHighlight: true),
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

  void _showExportSheet(BuildContext context, AppPalette palette, bool isDark, bool isBangla) {
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isBangla ? 'অফিসিয়াল লেজার স্টেটমেন্ট ডাউনলোড' : 'Download Official Ledger Statement',
                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.picture_as_pdf_rounded, color: palette.pine),
                title: Text(isBangla ? 'অডিট সিলমোহরযুক্ত পিডিএফ রিপোর্ট' : 'Audited PDF Statement', style: AppTypography.bodyStrong(isDark: isDark)),
                subtitle: Text('Cryptographically signed with SHA-256 seal', style: AppTypography.caption(isDark: isDark)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(isBangla ? 'পিডিএফ ডাউনলোড সম্পন্ন' : 'PDF Statement downloaded'), backgroundColor: palette.pine),
                  );
                },
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.table_chart_rounded, color: palette.pine),
                title: Text(isBangla ? 'সিএসভি স্প্রেডশিট লেজার (Excel/CSV)' : 'CSV Spreadsheet Ledger', style: AppTypography.bodyStrong(isDark: isDark)),
                subtitle: Text('Raw ledger data for accounting software', style: AppTypography.caption(isDark: isDark)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(isBangla ? 'সিএসভি ডাউনলোড সম্পন্ন' : 'CSV Ledger exported'), backgroundColor: palette.pine),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _modalDetailRow(String label, String value, AppPalette palette, bool isDark, {bool isHighlight = false}) {
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
