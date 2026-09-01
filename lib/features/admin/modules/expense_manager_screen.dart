import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/voucher_row.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AdminExpenseManagerScreen extends StatefulWidget {
  final AppState state;

  const AdminExpenseManagerScreen({
    super.key,
    required this.state,
  });

  @override
  State<AdminExpenseManagerScreen> createState() => _AdminExpenseManagerScreenState();
}

class _AdminExpenseManagerScreenState extends State<AdminExpenseManagerScreen> {
  final TextEditingController _categoryController = TextEditingController(text: 'Legal & Title Search');
  final TextEditingController _payeeController = TextEditingController(text: 'Supreme Court Advocate Chamber');
  final TextEditingController _amountController = TextEditingController(text: '35000');
  final TextEditingController _descController = TextEditingController(text: 'Additional mutation vetting & mouza survey');

  void _showAddExpenseModal(AppPalette palette, bool isDark, bool isBangla) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: AppRadius.borderSheet,
        ),
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'নতুন প্রকল্প খরচ ভাউচার তৈরি' : 'Create Fund Expense Voucher',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 16),

            _inputField(isBangla ? 'খরচের খাত (Category)' : 'Category', _categoryController, palette, isDark),
            _inputField(isBangla ? 'প্রাপক ব্যক্তি / প্রতিষ্ঠান (Payee)' : 'Payee Name', _payeeController, palette, isDark),
            _inputField(isBangla ? 'টাকার পরিমাণ (Amount BDT)' : 'Amount (BDT)', _amountController, palette, isDark, keyboardType: TextInputType.number),
            _inputField(isBangla ? 'কাজের বিবরণ (Description)' : 'Description', _descController, palette, isDark),

            const SizedBox(height: 20),
            AppButton(
              label: isBangla ? 'ভাউচার অনুমোদন ও পোস্ট করুন' : 'Approve & Post to Ledger',
              onPressed: () {
                final amount = double.tryParse(_amountController.text) ?? 0.0;
                if (amount <= 0) return;

                widget.state.adminAddExpense(
                  category: _categoryController.text.trim(),
                  description: _descController.text.trim(),
                  payee: _payeeController.text.trim(),
                  amount: amount,
                );

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isBangla
                          ? 'খরচের ভাউচার অনুমোদিত হয়ে তহবিলে পোস্ট হয়েছে!'
                          : 'Expense voucher approved and posted to live ledger!',
                    ),
                    backgroundColor: palette.pine,
                  ),
                );
              },
              variant: AppButtonVariant.primary,
              isBangla: isBangla,
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller, AppPalette palette, bool isDark, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.caption(isDark: isDark).copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppTypography.bodyMedium(isDark: isDark),
            decoration: InputDecoration(
              filled: true,
              fillColor: palette.surfaceSunken,
              border: OutlineInputBorder(
                borderRadius: AppRadius.borderControl,
                borderSide: BorderSide(color: palette.rule),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.borderControl,
                borderSide: BorderSide(color: palette.rule),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.borderControl,
                borderSide: BorderSide(color: palette.pine, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final expenses = widget.state.expenses;
    final balance = widget.state.projectRemainingBalance;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          isBangla ? 'তহবিল ব্যবহার ও খরচ অনুমোদন' : 'Expense & Treasury Ledger',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => widget.state.toggleLanguage(),
            child: Text(
              isBangla ? 'EN' : 'বাং',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: palette.pine,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _showAddExpenseModal(palette, isDark, isBangla),
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: 'Add Expense Voucher',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project balance strip
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: AppRadius.borderCard,
                border: Border.all(
                  color: palette.rule,
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isBangla ? 'বর্তমান অবশিষ্ট তহবিল স্থিতি' : 'Remaining Project Balance',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                      ),
                      Text(
                        CurrencyFormatter.format(balance, isBangla: isBangla),
                        style: AppTypography.financialAmountMedium(isDark: isDark, color: palette.pine),
                      ),
                    ],
                  ),
                  AppButton(
                    label: isBangla ? '+ খরচ যুক্ত করুন' : '+ Add Voucher',
                    onPressed: () => _showAddExpenseModal(palette, isDark, isBangla),
                    variant: AppButtonVariant.primary,
                    height: 38,
                    isFullWidth: false,
                    isBangla: isBangla,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(
              isBangla ? 'অনুমোদিত ভাউচার তালিকা (${expenses.length})' : 'Approved Expense Vouchers (${expenses.length})',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            ...expenses.map((exp) => VoucherRow(
                  expense: exp,
                  isBangla: isBangla,
                )),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
