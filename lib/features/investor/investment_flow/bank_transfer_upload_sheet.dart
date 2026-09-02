import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class BankTransferUploadSheet extends StatefulWidget {
  final ProjectModel project;
  final int shareCount;
  final AppState state;
  final VoidCallback onSubmitSuccess;

  const BankTransferUploadSheet({
    super.key,
    required this.project,
    required this.shareCount,
    required this.state,
    required this.onSubmitSuccess,
  });

  static Future<bool?> show({
    required BuildContext context,
    required ProjectModel project,
    required int shareCount,
    required AppState state,
    required VoidCallback onSubmitSuccess,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BankTransferUploadSheet(
        project: project,
        shareCount: shareCount,
        state: state,
        onSubmitSuccess: onSubmitSuccess,
      ),
    );
  }

  @override
  State<BankTransferUploadSheet> createState() => _BankTransferUploadSheetState();
}

class _BankTransferUploadSheetState extends State<BankTransferUploadSheet> {
  final TextEditingController _txnRefController = TextEditingController();
  final TextEditingController _depositorController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();

  String _selectedDepositBank = 'City Bank PLC';
  String? _attachedReceiptPath;
  bool _isSubmitting = false;

  final List<String> _bankOptions = [
    'City Bank PLC',
    'BRAC Bank PLC',
    'Islami Bank Bangladesh PLC',
    'Dutch Bangla Bank PLC',
  ];

  @override
  void initState() {
    super.initState();
    _depositorController.text = widget.state.currentUser.name;
    _branchController.text = 'Gulshan Branch';
    // Generate a default realistic reference suggestion
    _txnRefController.text = 'DEP-CB-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
    // Default simulated sample slip
    _attachedReceiptPath = 'bank_deposit_slip_sample.jpg';
  }

  @override
  void dispose() {
    _txnRefController.dispose();
    _depositorController.dispose();
    _branchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;
    final totalAmount = widget.shareCount * widget.project.sharePrice;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.92,
      ),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: palette.canvas,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border(bottom: BorderSide(color: palette.rule, width: 1)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0066FF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.account_balance_rounded, color: Color(0xFF0066FF), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBangla ? 'ব্যাংক ট্রান্সফার ও রসিদ আপলোড' : 'Bank Deposit & Receipt Upload',
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: palette.ink,
                          ),
                        ),
                        Text(
                          isBangla ? 'সরাসরি ব্যাংক হিসাবে ফান্ড জমা দিন' : 'Direct deposit to company bank A/C',
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 11,
                            color: palette.inkSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, size: 20, color: palette.inkTertiary),
                    onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Swapnojatri Official Bank Account Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: palette.surfaceSunken,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: palette.ruleStrong, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isBangla ? 'অফিসিয়াল ব্যাংক অ্যাকাউন্ট' : 'Official Bank Account',
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0066FF),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00C853).withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'ভেরিফাইড অ্যাকাউন্ট',
                                  style: GoogleFonts.hindSiliguri(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF00C853),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildBankInfoRow('ব্যাংকের নাম', 'সিটি ব্যাংক পিএলসি (The City Bank PLC)', palette),
                          _buildBankInfoRow('অ্যাকাউন্টের নাম', 'SWAPNOJATRI AGRO & LAND PROJECTS LTD', palette),
                          _buildCopyableRow('অ্যাকাউন্ট নম্বর', '1402-9988-7710-1', palette),
                          _buildCopyableRow('রাউটিং নম্বর', '225275357', palette),
                          _buildBankInfoRow('শাখা', 'গুলশান কর্পোরেট শাখা, ঢাকা', palette),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Amount Due
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0066FF).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF0066FF).withValues(alpha: 0.15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isBangla
                                ? 'জমার পরিমাণ (${widget.shareCount}টি শেয়ার):'
                                : 'Deposit Amount (${widget.shareCount} Shares):',
                            style: GoogleFonts.hindSiliguri(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: palette.ink,
                            ),
                          ),
                          Text(
                            '৳ ${totalAmount.toInt()}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0066FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Receipt Upload Box
                    Text(
                      isBangla ? 'ব্যাংক জমার রসিদ / স্লিপের ছবি' : 'Bank Deposit Slip / Receipt Photo',
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: palette.ink,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _attachedReceiptPath != null ? const Color(0xFF00C853) : palette.ruleStrong,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          if (_attachedReceiptPath != null) ...[
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: palette.surfaceSunken,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: palette.rule),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.receipt_long_rounded, size: 40, color: Color(0xFF0066FF)),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Bank_Deposit_Slip_#${_txnRefController.text}.jpg',
                                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: palette.ink),
                                        ),
                                        Text(
                                          '1.4 MB • JPEG Image',
                                          style: GoogleFonts.poppins(fontSize: 10.5, color: palette.inkSecondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00C853),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.check, size: 12, color: Colors.white),
                                          const SizedBox(width: 4),
                                          Text(
                                            isBangla ? 'রসিদ যুক্ত হয়েছে' : 'Attached',
                                            style: GoogleFonts.hindSiliguri(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: _pickReceiptPhoto,
                                  icon: const Icon(Icons.refresh_rounded, size: 15),
                                  label: Text(
                                    isBangla ? 'ছবি পরিবর্তন করুন' : 'Change Photo',
                                    style: GoogleFonts.hindSiliguri(fontSize: 12, fontWeight: FontWeight.w600),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: palette.ink,
                                    side: BorderSide(color: palette.ruleStrong),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  ),
                                ),
                              ],
                            ),
                          ] else ...[
                            GestureDetector(
                              onTap: _pickReceiptPhoto,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0066FF).withValues(alpha: 0.08),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.cloud_upload_outlined, size: 32, color: Color(0xFF0066FF)),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    isBangla ? 'জমার রসিদের ছবি আপলোড করুন' : 'Upload Bank Deposit Slip Photo',
                                    style: GoogleFonts.hindSiliguri(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: palette.ink,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isBangla
                                        ? 'ক্যামেরা দিয়ে ছবি তুলুন বা গ্যালারি থেকে সিলেক্ট করুন (JPG/PNG)'
                                        : 'Take a photo or choose from gallery (JPG/PNG)',
                                    style: GoogleFonts.hindSiliguri(fontSize: 11, color: palette.inkSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Form Fields: Depositor & Txn Info
                    Text(
                      isBangla ? 'জমার বিবরণ ও রেফারেন্স' : 'Deposit Details & Reference',
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: palette.ink,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Depositor Name
                    TextField(
                      controller: _depositorController,
                      decoration: InputDecoration(
                        labelText: isBangla ? 'জমাদানকারীর নাম' : 'Depositor Name',
                        prefixIcon: const Icon(Icons.person_outline, size: 20),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Bank selection
                    DropdownButtonFormField<String>(
                      value: _selectedDepositBank,
                      decoration: InputDecoration(
                        labelText: isBangla ? 'প্রেরক ব্যাংক' : 'Sender Bank',
                        prefixIcon: const Icon(Icons.account_balance, size: 20),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      items: _bankOptions.map((bank) {
                        return DropdownMenuItem(value: bank, child: Text(bank, style: GoogleFonts.poppins(fontSize: 13)));
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedDepositBank = val ?? _selectedDepositBank),
                    ),
                    const SizedBox(height: 10),

                    // Transaction Ref / Slip No
                    TextField(
                      controller: _txnRefController,
                      decoration: InputDecoration(
                        labelText: isBangla ? 'ব্যাংক স্লিপ নং / ট্রানজেকশন আইডি' : 'Slip No / Transaction Reference',
                        prefixIcon: const Icon(Icons.tag_rounded, size: 20),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Submit Button
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitBankDeposit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          isBangla ? 'রসিদ জমা দিন ও যাচাইয়ের জন্য পাঠান' : 'Submit Receipt for Verification',
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankInfoRow(String label, String value, AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: GoogleFonts.hindSiliguri(fontSize: 12, color: palette.inkSecondary),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 12)),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.hindSiliguri(fontSize: 12, fontWeight: FontWeight.w600, color: palette.ink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopyableRow(String label, String value, AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: GoogleFonts.hindSiliguri(fontSize: 12, color: palette.inkSecondary),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 12)),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w700, color: const Color(0xFF0066FF)),
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$label কপি করা হয়েছে: $value'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.copy_rounded, size: 14, color: palette.inkSecondary),
            ),
          ),
        ],
      ),
    );
  }

  void _pickReceiptPhoto() {
    setState(() {
      _attachedReceiptPath = 'bank_deposit_slip_${DateTime.now().millisecondsSinceEpoch}.jpg';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ব্যাংক জমার স্লিপ সফলভাবে যুক্ত হয়েছে!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _submitBankDeposit() async {
    final isBangla = widget.state.isBangla;
    if (_txnRefController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isBangla ? 'অনুগ্রহ করে স্লিপ নম্বর লিখুন।' : 'Please enter deposit slip number.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 600));

    widget.state.submitBankDepositInvestment(
      shares: widget.shareCount,
      depositBankName: _selectedDepositBank,
      depositorName: _depositorController.text.trim(),
      paymentReference: _txnRefController.text.trim(),
      receiptImageUrl: _attachedReceiptPath ?? 'deposit_slip_verified.jpg',
    );

    if (!mounted) return;
    widget.onSubmitSuccess();
    Navigator.of(context).pop(true);
  }
}
