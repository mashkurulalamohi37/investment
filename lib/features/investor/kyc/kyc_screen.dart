import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/status_chip.dart';
import 'package:swapnojatri/core/widgets/investment_stepper.dart';
import 'package:swapnojatri/data/models/kyc_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class KycScreen extends StatefulWidget {
  final AppState state;

  const KycScreen({
    super.key,
    required this.state,
  });

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  int _currentStep = 0;
  bool _isSubmitting = false;

  final TextEditingController _nameController = TextEditingController(text: 'Ohiur Rahman Ohi');
  final TextEditingController _fatherController = TextEditingController(text: 'Motiur Rahman');
  final TextEditingController _motherController = TextEditingController(text: 'Salma Khatun');
  final TextEditingController _nidController = TextEditingController(text: '19922692019000452');
  final TextEditingController _dobController = TextEditingController(text: '14 May 1992');
  final TextEditingController _presentAddressController = TextEditingController(text: 'House 42, Road 11, Banani, Dhaka-1213');
  final TextEditingController _permanentAddressController = TextEditingController(text: 'Village: Uttarpara, P.O: Savar, Dhaka');
  final TextEditingController _bankNameController = TextEditingController(text: 'City Bank PLC');
  final TextEditingController _bankAccController = TextEditingController(text: '1102938475001');
  final TextEditingController _routingController = TextEditingController(text: '225261890');
  final TextEditingController _nomineeNameController = TextEditingController(text: 'Nusrat Jahan');
  final TextEditingController _nomineeRelationController = TextEditingController(text: 'Spouse (স্ত্রী)');
  final TextEditingController _nomineePhoneController = TextEditingController(text: '+880 1823-456789');

  final List<String> _stepsEn = ['Personal', 'Identity/NID', 'Bank & Nominee', 'Submit'];
  final List<String> _stepsBn = ['ব্যক্তিগত তথ্য', 'জাতীয় পরিচয়পত্র', 'ব্যাংক ও নমিনি', 'যাচাই জমা'];

  @override
  void dispose() {
    _nameController.dispose();
    _fatherController.dispose();
    _motherController.dispose();
    _nidController.dispose();
    _dobController.dispose();
    _presentAddressController.dispose();
    _permanentAddressController.dispose();
    _bankNameController.dispose();
    _bankAccController.dispose();
    _routingController.dispose();
    _nomineeNameController.dispose();
    _nomineeRelationController.dispose();
    _nomineePhoneController.dispose();
    super.dispose();
  }

  void _submitKyc() {
    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        widget.state.submitKyc(
          fullName: _nameController.text.trim(),
          fatherName: _fatherController.text.trim(),
          motherName: _motherController.text.trim(),
          nidNumber: _nidController.text.trim(),
          dateOfBirth: _dobController.text.trim(),
          presentAddress: _presentAddressController.text.trim(),
          permanentAddress: _permanentAddressController.text.trim(),
          bankName: _bankNameController.text.trim(),
          bankAccountNumber: _bankAccController.text.trim(),
          routingNumber: _routingController.text.trim(),
          nominee: NomineeModel(
            name: _nomineeNameController.text.trim(),
            relationship: _nomineeRelationController.text.trim(),
            phone: _nomineePhoneController.text.trim(),
            nidNumber: '19952692019000889',
          ),
        );
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.state.isBangla ? 'কেওয়াইসি সফলভাবে পর্যালোচনার জন্য জমা হয়েছে' : 'KYC submitted for compliance review',
            ),
            backgroundColor: AppColors.success,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final kyc = widget.state.kyc;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'গ্রাহক পরিচিতি (কেওয়াইসি)' : 'Investor KYC Verification',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KYC Status Header Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (kyc.status == KycStatus.verified ? AppColors.success : AppColors.warning)
                          .withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      kyc.status == KycStatus.verified ? Icons.verified_user_rounded : Icons.pending_actions_rounded,
                      color: kyc.status == KycStatus.verified ? AppColors.success : AppColors.warningDark,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isBangla ? 'কেওয়াইসি স্ট্যাটাস' : 'KYC Status',
                              style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                            ),
                            StatusChip.kyc(kyc.status, isBangla: isBangla),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          kyc.status == KycStatus.verified
                              ? (isBangla
                                  ? 'আপনার অ্যাকাউন্ট সম্পূর্ণ যাচাইকৃত। আপনি ল্যান্ডভেস্ট প্রকল্পে সর্বোচ্চ ৪টি শেয়ার সাবস্ক্রাইব করতে পারেন।'
                                  : 'Fully verified for all LandVest investments and legal share deeds.')
                              : (isBangla ? 'যাচাইয়ের জন্য প্রয়োজনীয় তথ্য পূরণ করুন' : 'Complete required fields for review'),
                          style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Wizard Stepper
            InvestmentStepper(
              currentStep: _currentStep,
              steps: isBangla ? _stepsBn : _stepsEn,
              isBangla: isBangla,
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Step Content
            _buildStepForm(isDark, isBangla),
            const SizedBox(height: 24),

            // Action Buttons
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
                        ? (isBangla ? 'কেওয়াইসি জমা দিন' : 'Submit for Verification')
                        : (isBangla ? 'পরবর্তী ধাপ' : 'Next Step'),
                    onPressed: () {
                      if (_currentStep == 3) {
                        _submitKyc();
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

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStepForm(bool isDark, bool isBangla) {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _formField(isBangla ? 'পূর্ণ নাম (জাতীয় পরিচয়পত্র অনুযায়ী)' : 'Full Name (As on NID)', _nameController, isDark),
            _formField(isBangla ? 'পিতার নাম' : "Father's Name", _fatherController, isDark),
            _formField(isBangla ? 'মাতার নাম' : "Mother's Name", _motherController, isDark),
            _formField(isBangla ? 'জন্ম তারিখ' : 'Date of Birth', _dobController, isDark),
            _formField(isBangla ? 'বর্তমান ঠিকানা' : 'Present Address', _presentAddressController, isDark),
            _formField(isBangla ? 'স্থায়ী ঠিকানা' : 'Permanent Address', _permanentAddressController, isDark),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _formField(isBangla ? 'জাতীয় পরিচয়পত্র নম্বর (NID / Smart Card)' : 'NID / Smart Card Number', _nidController, isDark),
            const SizedBox(height: 12),
            Text(isBangla ? 'পরিচয়পত্রের ছবি স্ক্যান' : 'NID Document Upload', style: AppTypography.caption(isDark: isDark)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _docUploadPlaceholder(isBangla ? 'এনআইডি সম্মুখ ভাগ' : 'NID Front Side', isDark),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _docUploadPlaceholder(isBangla ? 'এনআইডি বিপরীত ভাগ' : 'NID Back Side', isDark),
                ),
              ],
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isBangla ? 'ব্যাংক হিসাব তথ্য (লভ্যাংশ জমার জন্য)' : 'Bank Account (For Dividend Payouts)', style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla)),
            const SizedBox(height: 12),
            _formField(isBangla ? 'ব্যাংকের নাম' : 'Bank Name', _bankNameController, isDark),
            _formField(isBangla ? 'হিসাব নম্বর (A/C No)' : 'Account Number', _bankAccController, isDark),
            _formField(isBangla ? 'রাউটিং নম্বর' : 'Routing Number', _routingController, isDark),
            const Divider(height: 24),
            Text(isBangla ? 'মনোনীত ব্যক্তি (নমিনি) তথ্য' : 'Nominee Information', style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla)),
            const SizedBox(height: 12),
            _formField(isBangla ? 'নমিনির নাম' : 'Nominee Full Name', _nomineeNameController, isDark),
            _formField(isBangla ? 'সম্পর্ক' : 'Relationship', _nomineeRelationController, isDark),
            _formField(isBangla ? 'নমিনির মোবাইল নম্বর' : 'Nominee Phone', _nomineePhoneController, isDark),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isBangla ? 'কেওয়াইসি তথ্যাবলী চূড়ান্ত যাচাই' : 'Review & Confirm Submission', style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBg,
                borderRadius: AppRadius.borderMd,
              ),
              child: Column(
                children: [
                  _reviewRow(isBangla ? 'বিনিয়োগকারী' : 'Investor', _nameController.text, isDark),
                  _reviewRow(isBangla ? 'এনআইডি' : 'NID', _nidController.text, isDark),
                  _reviewRow(isBangla ? 'ব্যাংক' : 'Bank', '${_bankNameController.text} (${_bankAccController.text})', isDark),
                  _reviewRow(isBangla ? 'নমিনি' : 'Nominee', '${_nomineeNameController.text} (${_nomineeRelationController.text})', isDark),
                ],
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _formField(String label, TextEditingController controller, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.caption(isDark: isDark).copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
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

  Widget _docUploadPlaceholder(String label, bool isDark) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: AppRadius.borderMd,
        border: Border.all(
          color: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.4),
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.file_upload_outlined, color: AppColors.success, size: 24),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.caption(isDark: isDark).copyWith(fontSize: 11)),
            Text('NID_Scan.jpg (Verified)', style: AppTypography.caption().copyWith(fontSize: 9.5, color: AppColors.successDark)),
          ],
        ),
      ),
    );
  }

  Widget _reviewRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.caption(isDark: isDark)),
          Flexible(
            child: Text(
              value,
              style: AppTypography.headingSmall(isDark: isDark).copyWith(fontSize: 12.5, fontWeight: FontWeight.w700),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
