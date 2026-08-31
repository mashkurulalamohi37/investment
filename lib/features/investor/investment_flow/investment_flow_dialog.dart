import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/amount_text.dart';
import 'package:swapnojatri/core/widgets/seal_success_sheet.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/models/investment_model.dart';
import 'package:swapnojatri/data/models/transaction_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class InvestmentFlowDialog extends StatefulWidget {
  final ProjectModel project;
  final AppState state;
  final int initialShares;

  const InvestmentFlowDialog({
    super.key,
    required this.project,
    required this.state,
    this.initialShares = 2,
  });

  @override
  State<InvestmentFlowDialog> createState() => _InvestmentFlowDialogState();
}

class _InvestmentFlowDialogState extends State<InvestmentFlowDialog> {
  int _currentStep = 0;
  late int _sharesCount;
  bool _acceptedTerms = false;
  String _selectedPaymentMethod = 'City Bank PLC (Escrow)';
  final TextEditingController _trxIdController = TextEditingController(text: 'TRX882910394');
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _sharesCount = widget.initialShares.clamp(1, 4);
  }

  @override
  void dispose() {
    _trxIdController.dispose();
    super.dispose();
  }

  double get _totalAmount => _sharesCount * widget.project.pricePerShare;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    } else {
      _submitInvestment();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _submitInvestment() {
    setState(() => _isSubmitting = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      final newInvestment = InvestmentModel(
        id: 'inv-${DateTime.now().millisecondsSinceEpoch}',
        projectId: widget.project.id,
        projectTitle: widget.project.title,
        projectTitleBn: widget.project.titleBn,
        investorId: widget.state.currentUser.id,
        investorName: widget.state.currentUser.name,
        sharesCount: _sharesCount,
        pricePerShare: widget.project.pricePerShare,
        totalAmount: _totalAmount,
        assignedLots: [],
        status: InvestmentStatus.pendingPaymentVerification,
        paymentMethod: _selectedPaymentMethod,
        transactionRef: _trxIdController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final newTxn = TransactionModel(
        id: 'txn-${DateTime.now().millisecondsSinceEpoch}',
        investmentId: newInvestment.id,
        userId: widget.state.currentUser.id,
        type: TransactionType.sharePurchase,
        status: TransactionStatus.pending,
        amount: _totalAmount,
        title: 'LandVest 100 Share Purchase ($_sharesCount shares)',
        referenceId: _trxIdController.text.trim(),
        paymentMethod: _selectedPaymentMethod,
        createdAt: DateTime.now(),
      );

      widget.state.submitInvestment(newInvestment, newTxn);

      Navigator.pop(context); // Close current dialog

      // Show SealSuccessSheet (§10 & §9.11)
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SealSuccessSheet(
          lotNumber: 'LOT-075..${(74 + _sharesCount).toString().padLeft(3, '0')}',
          amount: CurrencyFormatter.format(_totalAmount, isBangla: widget.state.isBangla),
          escrowBank: _selectedPaymentMethod,
          isBangla: widget.state.isBangla,
          onViewCertificate: () => Navigator.pop(context),
          onBackToPortfolio: () => Navigator.pop(context),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderSheet,
      ),
      child: Column(
        children: [
          // 1. Drag Handle & Segmented Progress Rule at Top (§10)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: palette.ruleStrong,
                      borderRadius: AppRadius.borderFull,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 4-Segment Progress Rule
                Row(
                  children: List.generate(4, (index) {
                    final isActive = index <= _currentStep;
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: index < 3 ? 6.0 : 0.0),
                        height: 2.5,
                        color: isActive ? palette.pine : palette.rule,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // 2. Step Content (One Decision Per Step)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildStepContent(palette, isDark, isBangla),
            ),
          ),

          // 3. Bottom Action Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: palette.surface,
              border: Border(top: BorderSide(color: palette.rule, width: 1.0)),
            ),
            child: Row(
              children: [
                if (_currentStep > 0) ...[
                  Expanded(
                    flex: 1,
                    child: AppButton(
                      label: isBangla ? 'পূর্ববর্তী' : 'Back',
                      variant: AppButtonVariant.secondary,
                      isBangla: isBangla,
                      onPressed: _prevStep,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  flex: 2,
                  child: AppButton(
                    label: _currentStep == 3
                        ? (isBangla ? 'পেমেন্ট জমা নিশ্চিত করুন' : 'Confirm & Submit')
                        : (isBangla ? 'পরবর্তী ধাপে যান' : 'Continue'),
                    variant: AppButtonVariant.primary,
                    isLoading: _isSubmitting,
                    isBangla: isBangla,
                    onPressed: (_currentStep == 1 && !_acceptedTerms) ? null : _nextStep,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(AppPalette palette, bool isDark, bool isBangla) {
    switch (_currentStep) {
      case 0:
        return _buildStep1Shares(palette, isDark, isBangla);
      case 1:
        return _buildStep2Terms(palette, isDark, isBangla);
      case 2:
        return _buildStep3PaymentMethod(palette, isDark, isBangla);
      case 3:
        return _buildStep4BankDetails(palette, isDark, isBangla);
      default:
        return const SizedBox.shrink();
    }
  }

  // STEP 1: Ruled Stepper (− 2 +) at Radius 6 with Live Total in AmountLarge
  Widget _buildStep1Shares(AppPalette palette, bool isDark, bool isBangla) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isBangla ? 'শেয়ার অংশ নির্বাচন' : 'Select Number of Shares',
          style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isBangla
              ? 'ব্যক্তিগত সর্বোচ্চ বিনিয়োগ সীমা: ১ থেকে ৪টি শেয়ার'
              : 'Individual investor quota limit: 1 to 4 shares',
          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
            color: palette.inkSecondary,
          ),
        ),
        const SizedBox(height: 32),

        // Ruled Stepper Container (− 2 +)
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: AppRadius.borderControl,
              border: Border.all(color: palette.ruleStrong, width: 1.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: _sharesCount > 1
                      ? () {
                          HapticFeedback.selectionClick();
                          setState(() => _sharesCount--);
                        }
                      : null,
                  icon: const Icon(Icons.remove_rounded, size: 20),
                  color: palette.ink,
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 60),
                  child: Text(
                    isBangla ? CurrencyFormatter.toBanglaDigits(_sharesCount.toString()) : '$_sharesCount',
                    style: AppTypography.amountLarge(isDark: isDark, isBangla: isBangla).copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: _sharesCount < 4
                      ? () {
                          HapticFeedback.selectionClick();
                          setState(() => _sharesCount++);
                        }
                      : null,
                  icon: const Icon(Icons.add_rounded, size: 20),
                  color: palette.ink,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Live Total in AmountLarge
        Center(
          child: Column(
            children: [
              Text(
                isBangla ? 'মোট প্রদেয় মূলধন' : 'Total Investment Capital',
                style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                  color: palette.inkSecondary,
                ),
              ),
              const SizedBox(height: 4),
              AmountText(
                amount: _totalAmount,
                isBangla: isBangla,
                style: AppTypography.amountLarge(isDark: isDark, isBangla: isBangla).copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: palette.pine,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isBangla
                    ? 'প্রতি অংশ ৳ ২৫,৫০০ • অংশীদারি মালিকানা $_sharesCount%'
                    : '৳ 25,500 per share • $_sharesCount% Project Ownership',
                style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                  color: palette.inkTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STEP 2: Plain Risk Disclosures
  Widget _buildStep2Terms(AppPalette palette, bool isDark, bool isBangla) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isBangla ? 'ঝুঁকি ও আইনি ঘোষণা' : 'Risk & Escrow Disclosures',
          style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isBangla ? 'অর্থ স্থানান্তর করার পূর্বে শর্তাবলী মনোযোগ দিয়ে পড়ুন' : 'Review legal custody rules before proceeding',
          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
            color: palette.inkSecondary,
          ),
        ),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: palette.surfaceSunken,
            borderRadius: AppRadius.borderZero,
            border: Border.all(color: palette.ruleStrong, width: 1.0),
          ),
          child: Text(
            isBangla
                ? '• ভূমির বাজারমূল্য হ্রাস বা বৃদ্ধি পেতে পারে। এটি নিশ্চিত আয়ের স্কিম নয়।\n\n• অর্থ সিটি ব্যাংক পিএলসি এসক্রো হিসাবে সংরক্ষিত থাকে এবং কেবল অডিটকৃত খরচের জন্য ব্যয় করা যায়।\n\n• পেমেন্ট নিশ্চিতকরণ সাপেক্ষে ক্রমানুসারে নির্দিষ্ট লট বরাদ্দ করা হবে।'
                : '• Land value can fluctuate. Returns are asset-backed and not guaranteed.\n\n• Funds are held in escrow at City Bank PLC and disbursed strictly against audited vouchers.\n\n• Share lots are sequentially allocated upon verification of payment slip.',
            style: AppTypography.body(isDark: isDark, isBangla: isBangla).copyWith(
              color: palette.inkSecondary,
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 20),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: _acceptedTerms,
              activeColor: palette.pine,
              onChanged: (val) => setState(() => _acceptedTerms = val ?? false),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
                child: Text(
                  isBangla
                      ? 'আমি এসক্রো শর্তাবলী এবং ঝুঁকি নীতিমালা পড়ে সম্মতি জ্ঞাপন করছি।'
                      : 'I understand the escrow terms and acknowledge the risk disclosures.',
                  style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                    color: palette.ink,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // STEP 3: Payment Channel Selection
  Widget _buildStep3PaymentMethod(AppPalette palette, bool isDark, bool isBangla) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isBangla ? 'এসক্রো ডিপোজিট মাধ্যম' : 'Select Escrow Deposit Channel',
          style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        _paymentOption('City Bank PLC (Escrow)', isBangla ? 'সিটি ব্যাংক এসক্রো হিসাব (গুলশান)' : 'City Bank Escrow (Gulshan Branch)', palette, isDark),
        const SizedBox(height: 10),
        _paymentOption('BRAC Bank PLC', isBangla ? 'ব্র্যাক ব্যাংক হিসাব (প্রধান শাখা)' : 'BRAC Bank (Principal Branch)', palette, isDark),
        const SizedBox(height: 10),
        _paymentOption('bKash Merchant Escrow', isBangla ? 'বিকাশ মার্চেন্ট গেটওয়ে' : 'bKash Merchant Gateway', palette, isDark),
      ],
    );
  }

  Widget _paymentOption(String value, String subtitle, AppPalette palette, bool isDark) {
    final isSelected = _selectedPaymentMethod == value;
    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = value),
      borderRadius: AppRadius.borderControl,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? palette.pineTint : palette.surface,
          borderRadius: AppRadius.borderControl,
          border: Border.all(
            color: isSelected ? palette.pine : palette.rule,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 18,
              color: isSelected ? palette.pine : palette.inkTertiary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: AppTypography.bodyStrong(isDark: isDark).copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.micro(isDark: isDark).copyWith(color: palette.inkSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // STEP 4: Exact Bank Details in Sunken Well with Copy Affordance Per Line (§10)
  Widget _buildStep4BankDetails(AppPalette palette, bool isDark, bool isBangla) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isBangla ? 'এসক্রো ব্যাংক তথ্য ও লেনদেন আইডি' : 'Escrow Bank Details & Transaction ID',
          style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // Sunken Bank Well
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: palette.surfaceSunken,
            borderRadius: AppRadius.borderZero,
            border: Border.all(color: palette.ruleStrong, width: 1.0),
          ),
          child: Column(
            children: [
              _copyableBankRow(isBangla ? 'ব্যাংক নাম' : 'Bank', 'City Bank PLC', palette, isDark, isBangla),
              const Divider(height: 16),
              _copyableBankRow(isBangla ? 'শাখা' : 'Branch', 'Gulshan Corporate Branch', palette, isDark, isBangla),
              const Divider(height: 16),
              _copyableBankRow(isBangla ? 'হিসাব নাম' : 'A/C Name', 'Swapnojatri LandVest Escrow', palette, isDark, isBangla),
              const Divider(height: 16),
              _copyableBankRow(isBangla ? 'হিসাব নং' : 'A/C Number', '110-348-99201', palette, isDark, isBangla, isBold: true),
              const Divider(height: 16),
              _copyableBankRow(isBangla ? 'রাউটিং নং' : 'Routing No', '225261890', palette, isDark, isBangla),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Trx ID Input Field
        Text(
          isBangla ? 'ব্যাংক ডিপোজিট রেফারেন্স / লেনদেন আইডি' : 'Bank Deposit Slip Reference / Trx ID',
          style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 12.5),
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: AppRadius.borderControl,
            border: Border.all(color: palette.ruleStrong, width: 1.0),
          ),
          alignment: Alignment.center,
          child: TextField(
            controller: _trxIdController,
            style: AppTypography.bodyStrong(isDark: isDark).copyWith(letterSpacing: 0.5),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'e.g. TRX99281726',
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _copyableBankRow(String label, String value, AppPalette palette, bool isDark, bool isBangla, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.caption(isDark: isDark).copyWith(color: palette.inkSecondary, fontSize: 11.5)),
        Row(
          children: [
            Text(
              value,
              style: AppTypography.bodyStrong(isDark: isDark).copyWith(
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
                fontSize: 12.5,
              ),
            ),
            const SizedBox(width: 6),
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
                HapticFeedback.selectionClick();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isBangla ? '$label কপি হয়েছে' : '$label copied'),
                    duration: const Duration(seconds: 1),
                    backgroundColor: palette.pine,
                  ),
                );
              },
              child: Icon(Icons.copy_rounded, size: 13, color: palette.inkTertiary),
            ),
          ],
        ),
      ],
    );
  }
}
