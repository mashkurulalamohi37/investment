import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/expense_tile.dart';
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

  void _showAddExpenseModal(bool isDark, bool isBangla) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
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

            _inputField(isBangla ? 'খরচের খাত (Category)' : 'Category', _categoryController, isDark),
            _inputField(isBangla ? 'প্রাপক ব্যক্তি / প্রতিষ্ঠান (Payee)' : 'Payee Name', _payeeController, isDark),
            _inputField(isBangla ? 'টাকার পরিমাণ (Amount BDT)' : 'Amount (BDT)', _amountController, isDark, keyboardType: TextInputType.number),
            _inputField(isBangla ? 'কাজের বিবরণ (Description)' : 'Description', _descController, isDark),

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
                    backgroundColor: AppColors.success,
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

  Widget _inputField(String label, TextEditingController controller, bool isDark, {TextInputType keyboardType = TextInputType.text}) {
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
              fillColor: isDark ? AppColors.darkCard : Colors.white,
              border: OutlineInputBorder(
                borderRadius: AppRadius.borderMd,
                borderSide: BorderSide(color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final expenses = widget.state.expenses;
    final balance = widget.state.projectRemainingBalance;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'তহবিল ব্যবহার ও খরচ অনুমোদন' : 'Expense & Fund Ledger',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
        actions: [
          IconButton(
            onPressed: () => _showAddExpenseModal(isDark, isBangla),
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
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
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
                        style: AppTypography.financialAmountMedium(isDark: isDark, color: AppColors.success),
                      ),
                    ],
                  ),
                  AppButton(
                    label: isBangla ? '+ খরচ যুক্ত করুন' : '+ Add Voucher',
                    onPressed: () => _showAddExpenseModal(isDark, isBangla),
                    variant: AppButtonVariant.primary,
                    height: 38,
                    isFullWidth: false,
                    isBangla: isBangla,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text(
              isBangla ? 'অনুমোদিত ভাউচার তালিকা (${expenses.length})' : 'Approved Expense Vouchers (${expenses.length})',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            ...expenses.map((expense) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpenseTile(
                    expense: expense,
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
