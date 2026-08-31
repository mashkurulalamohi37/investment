import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/investment_stepper.dart';
import 'package:swapnojatri/data/models/project_model.dart';
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

  static Future<bool?> show(
    BuildContext context, {
    required ProjectModel project,
    required AppState state,
    int initialShares = 2,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InvestmentFlowDialog(
        project: project,
        state: state,
        initialShares: initialShares,
      ),
    );
  }

  @override
  State<InvestmentFlowDialog> createState() => _InvestmentFlowDialogState();
}

class _InvestmentFlowDialogState extends State<InvestmentFlowDialog> {
  int _currentStep = 0;
  late int _selectedShares;
  String _selectedPaymentMethod = 'City Bank PLC (EFTN / RTGS)';
  final TextEditingController _refController = TextEditingController(text: 'TXN-CBL-');
  bool _agreedToTerms = false;
  bool _isSubmitting = false;

  final List<String> _stepsEn = ['Shares', 'Review', 'Payment', 'Submit', 'Confirm'];
  final List<String> _stepsBn = ['শেয়ার', 'পর্যালোচনা', 'পেমেন্ট', 'জমা', 'নিশ্চিতকরণ'];

  @override
  void initState() {
    super.initState();
    _selectedShares = widget.initialShares.clamp(1, widget.project.maxShares);
  }

  @override
  void dispose() {
    _refController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_refController.text.trim().isEmpty || _refController.text.trim() == 'TXN-CBL-') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.state.isBangla ? 'অনুগ্রহ করে সঠিক ট্রানজেকশন রেফারেন্স লিখুন' : 'Please enter a valid payment reference',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        final success = widget.state.submitInvestmentRequest(
          shares: _selectedShares,
          paymentMethod: _selectedPaymentMethod,
          paymentReference: _refController.text.trim(),
        );

        if (success) {
          setState(() {
            _isSubmitting = false;
            _currentStep = 4; // Confirmation
          });
        } else {
          setState(() => _isSubmitting = false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final totalAmount = _selectedShares * widget.project.pricePerShare;

    return Container(
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
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle & Header
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkDivider : const Color(0xFFCBD5E1),
                borderRadius: AppRadius.borderFull,
              ),
            ),
          ),
          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBangla ? 'বিনিয়োগ সাবস্ক্রিপশন' : 'Investment Subscription',
                    style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                  ),
                  Text(
                    '${isBangla ? widget.project.nameBn : widget.project.name} (${widget.project.code})',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                      color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
                color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
              ),
            ],
          ),

          const SizedBox(height: 12),
          InvestmentStepper(
            currentStep: _currentStep,
            steps: isBangla ? _stepsBn : _stepsEn,
            isBangla: isBangla,
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Dynamic Step Content
          Expanded(
            child: SingleChildScrollView(
              child: _buildStepContent(isDark, isBangla, totalAmount),
            ),
          ),

          const SizedBox(height: 16),

          // Bottom Action Buttons
          if (_currentStep < 4) ...[
            Row(
              children: [
                if (_currentStep > 0) ...[
                  Expanded(
                    flex: 1,
                    child: AppButton(
                      text: isBangla ? 'পেছনে' : 'Back',
                      onPressed: () => setState(() => _currentStep--),
                      variant: ButtonVariant.outline,
                      isBangla: isBangla,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  flex: 2,
                  child: AppButton(
                    text: _currentStep == 3
                        ? (isBangla ? 'সাবস্ক্রিপশন জমা দিন' : 'Submit Investment')
                        : (isBangla ? 'পরবর্তী ধাপ' : 'Continue'),
                    onPressed: () {
                      if (_currentStep == 1 && !_agreedToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isBangla ? 'শর্তাবলী ও ডিসক্লেইমার গ্রহণ করুন' : 'Please accept terms & conditions'),
                            backgroundColor: AppColors.warningDark,
                          ),
                        );
                        return;
                      }
                      if (_currentStep == 3) {
                        _submit();
                      } else {
                        setState(() => _currentStep++);
                      }
                    },
                    isLoading: _isSubmitting,
                    variant: ButtonVariant.primary,
                    isBangla: isBangla,
                  ),
                ),
              ],
            ),
          ] else ...[
            AppButton(
              text: isBangla ? 'পোর্টফোলিওতে যান' : 'Go to Portfolio',
              onPressed: () => Navigator.pop(context, true),
              variant: ButtonVariant.primary,
              isBangla: isBangla,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepContent(bool isDark, bool isBangla, double totalAmount) {
    switch (_currentStep) {
      case 0:
        // Step 1: Select Shares
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'কতটি শেয়ার সাবস্ক্রাইব করতে চান?' : 'Select Number of Shares',
              style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 4),
            Text(
              isBangla ? 'নীতিমালা অনুযায়ী একজন বিনিয়োগকারী সর্বোচ্চ ৪টি শেয়ার নিতে পারবেন' : 'Platform rules limit: 1 to 4 shares per investor',
              style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 20),

            // Share Stepper Selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBg,
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isBangla ? 'নির্বাচিত শেয়ার' : 'Selected Shares',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isBangla ? '${CurrencyFormatter.toBanglaDigits(_selectedShares.toString())} টি শেয়ার' : '$_selectedShares Shares',
                        style: AppTypography.financialAmountMedium(isDark: isDark),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _selectedShares > 1
                            ? () => setState(() => _selectedShares--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline_rounded),
                        color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                        iconSize: 32,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.15),
                          borderRadius: AppRadius.borderSm,
                        ),
                        child: Text(
                          isBangla ? CurrencyFormatter.toBanglaDigits(_selectedShares.toString()) : '$_selectedShares',
                          style: AppTypography.headingMedium(isDark: isDark).copyWith(
                            fontWeight: FontWeight.w800,
                            color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _selectedShares < widget.project.maxShares
                            ? () => setState(() => _selectedShares++)
                            : null,
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                        iconSize: 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Real-time calculation summary card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: AppRadius.borderMd,
                border: Border.all(
                  color: AppColors.accentGold.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _summaryRow(
                    isBangla ? 'প্রতি শেয়ার মূল্য' : 'Unit Share Price',
                    CurrencyFormatter.format(widget.project.pricePerShare, isBangla: isBangla),
                    isDark,
                    isBangla,
                  ),
                  const SizedBox(height: 8),
                  _summaryRow(
                    isBangla ? 'শেয়ার সংখ্যা' : 'Shares Count',
                    '× $_selectedShares',
                    isDark,
                    isBangla,
                  ),
                  const SizedBox(height: 8),
                  _summaryRow(
                    isBangla ? 'প্ল্যাটফর্ম ও ভ্যাট ফি' : 'Platform Fee & Tax',
                    isBangla ? '৳ ০ (ফ্রি)' : '৳ 0 (Free)',
                    isDark,
                    isBangla,
                  ),
                  const Divider(height: 18),
                  _summaryRow(
                    isBangla ? 'সর্বমোট বিনিয়োগযোগ্য মূলধন' : 'Total Investment Amount',
                    CurrencyFormatter.format(totalAmount, isBangla: isBangla),
                    isDark,
                    isBangla,
                    isHighlight: true,
                  ),
                ],
              ),
            ),
          ],
        );

      case 1:
        // Step 2: Review & Risk Disclaimer
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'বিনিয়োগ বিবরণী পর্যালোচনা' : 'Review Investment Summary',
              style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBg,
                borderRadius: AppRadius.borderMd,
              ),
              child: Column(
                children: [
                  _summaryRow(isBangla ? 'প্রকল্প' : 'Project', widget.project.name, isDark, isBangla),
                  const SizedBox(height: 8),
                  _summaryRow(isBangla ? 'অবস্থান' : 'Location', widget.project.location, isDark, isBangla),
                  const SizedBox(height: 8),
                  _summaryRow(isBangla ? 'শেয়ার লট' : 'Shares', '$_selectedShares Shares', isDark, isBangla),
                  const SizedBox(height: 8),
                  _summaryRow(
                    isBangla ? 'মোট অর্থ' : 'Total Payable',
                    CurrencyFormatter.format(totalAmount, isBangla: isBangla),
                    isDark,
                    isBangla,
                    isHighlight: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Mandatory Risk Disclosure Box
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.warningLight.withValues(alpha: isDark ? 0.15 : 0.6),
                borderRadius: AppRadius.borderMd,
                border: Border.all(color: AppColors.warning.withValues(alpha: 0.4), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.shield_outlined, size: 16, color: AppColors.warningDark),
                      const SizedBox(width: 6),
                      Text(
                        isBangla ? 'আইনি ও আর্থিক নোটিশ' : 'Legal & Compliance Notice',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          color: AppColors.warningDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isBangla
                        ? 'এটি একটি প্রকল্পভিত্তিক জমি বিনিয়োগ। লভ্যাংশ অর্জিত প্রকৃত মুনাফার ওপর নির্ধারিত হবে। কোনো নিশ্চিত রিটার্ন প্রদান করা হয় না।'
                        : 'This is an asset-backed project investment. Returns depend on actual project profit realization. No returns are guaranteed.',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                      color: isDark ? AppColors.darkTextSecondary : const Color(0xFF78350F),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Checkbox
            CheckboxListTile(
              value: _agreedToTerms,
              onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(
                isBangla
                    ? 'আমি স্বপ্নযাত্রীর বিনিয়োগ নীতিমালা, শর্তাবলী ও ঝুঁকি সংক্রান্ত তথ্য পড়ে সম্মতি জানাচ্ছি।'
                    : 'I have read and agree to Swapnojatri Terms of Investment and Risk Disclosures.',
                style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
              ),
            ),
          ],
        );

      case 2:
        // Step 3: Payment Channel Selection
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'পেমেন্ট চ্যানেল নির্বাচন করুন' : 'Select Official Deposit Channel',
              style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 14),

            _paymentMethodOption(
              title: 'City Bank PLC (EFTN / NPSB / RTGS)',
              subtitle: isBangla ? 'অ্যাকাউন্ট: ১১০২৯৩৮৪৭৫০০১ (স্বপ্নযাত্রী ইনভেস্টমেন্ট)' : 'A/C: 1102938475001 (Swapnojatri Investment)',
              icon: Icons.account_balance_rounded,
              value: 'City Bank PLC (EFTN / RTGS)',
              isDark: isDark,
              isBangla: isBangla,
            ),
            const SizedBox(height: 10),
            _paymentMethodOption(
              title: 'BRAC Bank PLC',
              subtitle: isBangla ? 'অ্যাকাউন্ট: ১৫০১১০৯৮৭৬০০২ (গুলশান শাখা)' : 'A/C: 1501109876002 (Gulshan Branch)',
              icon: Icons.account_balance_rounded,
              value: 'BRAC Bank PLC',
              isDark: isDark,
              isBangla: isBangla,
            ),
            const SizedBox(height: 10),
            _paymentMethodOption(
              title: 'bKash Merchant Payment',
              subtitle: isBangla ? 'মার্চেন্ট নম্বর: ০১৭০০-০০০০০০ (কাউন্টার ০১)' : 'Merchant No: 01700-000000 (Counter 01)',
              icon: Icons.phone_android_rounded,
              value: 'bKash Merchant Payment',
              isDark: isDark,
              isBangla: isBangla,
            ),
          ],
        );

      case 3:
        // Step 4: Submit Payment Reference ID
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'পেমেন্ট রেফারেন্স প্রদান করুন' : 'Submit Payment Reference',
              style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 4),
            Text(
              isBangla ? 'ব্যাংক বা বিকাশ ট্রান্সফারের ট্রানজেকশন আইডি (Txn ID) লিখুন' : 'Enter Bank Deposit Slip Reference or MFS TrxID',
              style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBg,
                borderRadius: AppRadius.borderMd,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBangla ? 'প্রদেয় মোট অর্থ' : 'Payable Amount',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    CurrencyFormatter.format(totalAmount, isBangla: isBangla),
                    style: AppTypography.financialAmountMedium(isDark: isDark),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isBangla ? 'নির্বাচিত মাধ্যম' : 'Selected Channel',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _selectedPaymentMethod,
                    style: AppTypography.bodyMedium(isDark: isDark).copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            Text(
              isBangla ? 'ট্রানজেকশন রেফারেন্স / স্লিপ নম্বর *' : 'Transaction Reference / Slip No *',
              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _refController,
              style: AppTypography.headingSmall(isDark: isDark).copyWith(fontFamily: 'monospace'),
              decoration: InputDecoration(
                hintText: 'e.g. TXN-CBL-8920194',
                filled: true,
                fillColor: isDark ? AppColors.darkCard : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: AppRadius.borderMd,
                  borderSide: BorderSide(
                    color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ],
        );

      case 4:
        // Step 5: Confirmation Receipt with Celebratory Animation
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGold.withValues(alpha: 0.15),
                  ),
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.goldGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGold.withValues(alpha: 0.4),
                        blurRadius: 18,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.check_rounded, size: 38, color: AppColors.primaryDark),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              isBangla ? 'আবেদন সফলভাবে গৃহীত হয়েছে!' : 'Subscription Request Submitted!',
              style: AppTypography.headingLarge(isDark: isDark, isBangla: isBangla),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              isBangla
                  ? 'আপনার $_selectedShares টি শেয়ারের পেমেন্ট তথ্য অর্থ বিভাগ যাচাই করছে। যাচাই সম্পন্ন হলেই লট বরাদ্দ সনদপত্র তৈরি হবে।'
                  : 'Your subscription for $_selectedShares shares is under financial review. Lot allocation will be completed shortly.',
              style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBg,
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _summaryRow(isBangla ? 'প্রকল্প' : 'Project', widget.project.name, isDark, isBangla),
                  const SizedBox(height: 8),
                  _summaryRow(isBangla ? 'শেয়ার সংখ্যা' : 'Shares', '$_selectedShares Shares', isDark, isBangla),
                  const SizedBox(height: 8),
                  _summaryRow(
                    isBangla ? 'মোট অর্থ' : 'Total Amount',
                    CurrencyFormatter.format(totalAmount, isBangla: isBangla),
                    isDark,
                    isBangla,
                    isHighlight: true,
                  ),
                  const SizedBox(height: 8),
                  _summaryRow(isBangla ? 'রেফারেন্স আইডি' : 'Reference ID', _refController.text.trim(), isDark, isBangla),
                  const SizedBox(height: 8),
                  _summaryRow(isBangla ? 'বর্তমান অবস্থা' : 'Status', isBangla ? 'যাচাই প্রক্রিয়াধীন' : 'Pending Verification', isDark, isBangla),
                ],
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _summaryRow(String label, String value, bool isDark, bool isBangla, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
            fontSize: isHighlight ? 13 : 12,
          ),
        ),
        Text(
          value,
          style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w700,
            fontSize: isHighlight ? 15 : 13,
            color: isHighlight
                ? (isDark ? AppColors.accentGoldLight : AppColors.primary)
                : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
          ),
        ),
      ],
    );
  }

  Widget _paymentMethodOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required bool isDark,
    required bool isBangla,
  }) {
    final isSelected = _selectedPaymentMethod == value;

    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = value),
      borderRadius: AppRadius.borderMd,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.primaryDark : AppColors.primarySubtle)
              : (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: AppRadius.borderMd,
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColors.accentGold : AppColors.primary)
                : (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? (isDark ? AppColors.accentGoldLight : AppColors.primary) : AppColors.lightTextMuted,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: isSelected ? (isDark ? AppColors.accentGoldLight : AppColors.primary) : AppColors.lightTextMuted,
            ),
          ],
        ),
      ),
    );
  }
}
