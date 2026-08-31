import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/transaction_tile.dart';
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
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;

  final List<String> _filtersEn = ['All Ledger', 'Investments', 'Profit Payouts', 'Pending'];
  final List<String> _filtersBn = ['সকল লেনদেন', 'বিনিয়োগ জমা', 'লভ্যাংশ প্রাপ্তি', 'যাচাইাধীন'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showExportDialog(bool isBangla, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'আর্থিক স্টেটমেন্ট এক্সপোর্ট করুন' : 'Export Financial Statement',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 6),
            Text(
              isBangla
                  ? 'আপনার সকল বিনিয়োগ ও লভ্যাংশ লেনদেনের ভেরিফাইড স্টেটমেন্ট ডাউনলোড করুন'
                  : 'Download audited statement for your accounting and tax records',
              style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 20),

            ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.errorLight,
                child: Icon(Icons.picture_as_pdf_rounded, color: AppColors.error),
              ),
              title: Text(
                isBangla ? 'পিডিএফ স্টেটমেন্ট (PDF Report)' : 'Official PDF Statement',
                style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 14),
              ),
              subtitle: Text('Audit sealed with digital cryptographic signature', style: AppTypography.caption(isDark: isDark)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isBangla ? 'পিডিএফ স্টেটমেন্ট ডাউনলোড সম্পন্ন হয়েছে' : 'PDF Statement downloaded successfully'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.successLight,
                child: Icon(Icons.table_chart_rounded, color: AppColors.successDark),
              ),
              title: Text(
                isBangla ? 'সিএসভি ফাইল (Excel / CSV Ledger)' : 'CSV Spreadsheet Ledger',
                style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 14),
              ),
              subtitle: Text('Structured ledger for bookkeeping', style: AppTypography.caption(isDark: isDark)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isBangla ? 'সিএসভি এক্সপোর্ট সম্পন্ন হয়েছে' : 'CSV Ledger exported successfully'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final allTransactions = widget.state.transactions;

    // Filter logic
    final filtered = allTransactions.where((t) {
      if (_selectedFilterIndex == 1 && t.type != TransactionType.investment) return false;
      if (_selectedFilterIndex == 2 && t.type != TransactionType.profitDistribution) return false;
      if (_selectedFilterIndex == 3 && t.status != TransactionStatus.pending) return false;

      final query = _searchController.text.trim().toLowerCase();
      if (query.isNotEmpty) {
        return t.reference.toLowerCase().contains(query) ||
            t.description.toLowerCase().contains(query) ||
            t.projectName.toLowerCase().contains(query);
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'আর্থিক লেনদেন ও লেজার' : 'Financial Ledger',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => _showExportDialog(isBangla, isDark),
            icon: const Icon(Icons.file_download_outlined),
            tooltip: 'Export Statement',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: AppRadius.borderMd,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
                decoration: InputDecoration(
                  hintText: isBangla ? 'রেফারেন্স আইডি বা বিবরণ দিয়ে খুঁজুন...' : 'Search by reference ID or project...',
                  hintStyle: TextStyle(
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_filtersEn.length, (index) {
                  final isSelected = _selectedFilterIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        isBangla ? _filtersBn[index] : _filtersEn[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? (isDark ? AppColors.primaryDark : Colors.white)
                              : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextPrimary),
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (val) => setState(() => _selectedFilterIndex = index),
                      selectedColor: isDark ? AppColors.accentGold : AppColors.primary,
                      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.borderFull,
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Ledger Entries
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isBangla ? 'লেনদেন তালিকা (${filtered.length})' : 'Transactions (${filtered.length})',
                  style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                ),
                TextButton.icon(
                  onPressed: () => _showExportDialog(isBangla, isDark),
                  icon: const Icon(Icons.download_rounded, size: 16),
                  label: Text(
                    isBangla ? 'স্টেটমেন্ট' : 'Export',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            if (filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Text(
                    isBangla ? 'কোনো লেনদেন পাওয়া যায়নি' : 'No transactions found',
                    style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
                  ),
                ),
              )
            else
              ...filtered.map((txn) => Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TransactionTile(
                      transaction: txn,
                      isBangla: isBangla,
                    ),
                  )),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
