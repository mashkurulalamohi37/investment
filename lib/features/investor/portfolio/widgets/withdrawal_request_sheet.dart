import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/models/withdrawal_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class WithdrawalRequestSheet extends StatefulWidget {
  final AppState state;
  final WithdrawalType initialType;
  final VoidCallback? onSuccess;

  const WithdrawalRequestSheet({
    super.key,
    required this.state,
    this.initialType = WithdrawalType.dividend,
    this.onSuccess,
  });

  static Future<void> show(
    BuildContext context, {
    required AppState state,
    WithdrawalType initialType = WithdrawalType.dividend,
    VoidCallback? onSuccess,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WithdrawalRequestSheet(
        state: state,
        initialType: initialType,
        onSuccess: onSuccess,
      ),
    );
  }

  @override
  State<WithdrawalRequestSheet> createState() => _WithdrawalRequestSheetState();
}

class _WithdrawalRequestSheetState extends State<WithdrawalRequestSheet> {
  late WithdrawalType _selectedType;
  late PayoutChannel _selectedChannel;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _mfsController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _errorMessage;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
    _selectedChannel = PayoutChannel.bankTransfer;
    _mfsController.text = '01711-000000';
  }

  @override
  void dispose() {
    _amountController.dispose();
    _mfsController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  double get _maxAvailable {
    if (_selectedType == WithdrawalType.dividend) {
      return widget.state.availableDividendBalance;
    }
    return widget.state.withdrawableCapitalAmount;
  }

  void _setPercentAmount(double fraction) {
    final amount = (_maxAvailable * fraction).floorToDouble();
    _amountController.text = amount > 0 ? amount.toStringAsFixed(0) : '0';
    setState(() => _errorMessage = null);
  }

  void _handleSubmit() async {
    final rawAmount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    final isBangla = widget.state.isBangla;

    if (rawAmount <= 0) {
      setState(() {
        _errorMessage = isBangla ? 'অনুগ্রহ করে একটি সঠিক টাকার পরিমাণ লিখুন।' : 'Please enter a valid withdrawal amount.';
      });
      return;
    }

    if (rawAmount > _maxAvailable) {
      setState(() {
        _errorMessage = isBangla
            ? 'পর্যাপ্ত ব্যালেন্স নেই। সর্বোচ্চ প্রাপ্যতা ${CurrencyFormatter.format(rawAmount, isBangla: isBangla)}।'
            : 'Insufficient funds. Maximum available is ${CurrencyFormatter.format(_maxAvailable, isBangla: false)}.';
      });
      return;
    }

    if (_selectedType == WithdrawalType.dividend && rawAmount < 500) {
      setState(() {
        _errorMessage = isBangla
            ? 'লভ্যাংশ উত্তোলনের সর্বনিম্ন পরিমাণ ৳৫০০।'
            : 'Minimum dividend withdrawal is ৳500.';
      });
      return;
    }

    if (_selectedChannel != PayoutChannel.bankTransfer && _mfsController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = isBangla ? 'অনুগ্রহ করে আপনার মোবাইল ওয়ালেট নাম্বার প্রদান করুন।' : 'Please enter your mobile wallet number.';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
      _isSubmitting = true;
    });

    HapticFeedback.mediumImpact();

    final success = widget.state.submitWithdrawalRequest(
      type: _selectedType,
      amount: rawAmount,
      payoutChannel: _selectedChannel,
      mfsNumber: _selectedChannel != PayoutChannel.bankTransfer ? _mfsController.text.trim() : null,
      userNote: _noteController.text.trim().isNotEmpty ? _noteController.text.trim() : null,
    );

    setState(() => _isSubmitting = false);

    if (success && mounted) {
      Navigator.pop(context);
      if (widget.onSuccess != null) widget.onSuccess!();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF0066FF),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isBangla
                      ? 'উত্তোলন অনুরোধ সফলভাবে জমা হয়েছে! অনুমোদনের পর নিষ্পন্ন হবে।'
                      : 'Withdrawal request submitted successfully! Queued for approval.',
                  style: GoogleFonts.hindSiliguri(fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final kyc = widget.state.kyc;
    final maxAvailable = _maxAvailable;

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 14,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 44,
                height: 4.5,
                decoration: BoxDecoration(
                  color: palette.rule,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sheet Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? 'তহবিল উত্তোলনের অনুরোধ' : 'Request Fund Withdrawal',
                      style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isBangla ? 'ব্যাংক একাউন্ট অথবা বিকাশ/নগদে তহবিল উত্তোলন' : 'Disburse funds to verified bank or mobile wallet',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, color: palette.inkSecondary, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Type Toggle: Dividend vs Capital Exit
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: palette.rule, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTypeSegment(
                      title: isBangla ? 'লভ্যাংশ উত্তোলন' : 'Dividend Payout',
                      type: WithdrawalType.dividend,
                      isSelected: _selectedType == WithdrawalType.dividend,
                      palette: palette,
                      isBangla: isBangla,
                    ),
                  ),
                  Expanded(
                    child: _buildTypeSegment(
                      title: isBangla ? 'মূলধন প্রত্যাহার' : 'Capital Exit',
                      type: WithdrawalType.capitalExit,
                      isSelected: _selectedType == WithdrawalType.capitalExit,
                      palette: palette,
                      isBangla: isBangla,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Available Balance Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF0066FF).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF0066FF).withValues(alpha: 0.25)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedType == WithdrawalType.dividend
                            ? (isBangla ? 'উত্তোলনযোগ্য অবশিষ্ট লভ্যাংশ:' : 'Available Distributable Profit:')
                            : (isBangla ? 'মোট বিনিয়োগকৃত প্রত্যাহারযোগ্য মূলধন:' : 'Active Eligible Invested Capital:'),
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 12,
                          color: const Color(0xFF0066FF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        CurrencyFormatter.format(maxAvailable, isBangla: isBangla),
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0066FF),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0066FF).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF0066FF), size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Amount Input Field
            Text(
              isBangla ? 'উত্তোলনের পরিমাণ (টাকা)' : 'Withdrawal Amount (BDT)',
              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: palette.ink),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    '৳',
                    style: GoogleFonts.hindSiliguri(fontSize: 22, fontWeight: FontWeight.bold, color: palette.ink),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                hintText: isBangla ? 'যেমন: ৫০০০' : 'e.g. 5000',
                hintStyle: GoogleFonts.hindSiliguri(fontSize: 14, color: palette.inkSecondary),
                filled: true,
                fillColor: palette.surfaceSunken,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: palette.rule)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: palette.rule)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF0066FF), width: 1.5)),
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              ),
            ),
            const SizedBox(height: 10),

            // Quick Percentage Chips
            Row(
              children: [
                _buildQuickChip('25%', () => _setPercentAmount(0.25), palette),
                const SizedBox(width: 8),
                _buildQuickChip('50%', () => _setPercentAmount(0.50), palette),
                const SizedBox(width: 8),
                _buildQuickChip('75%', () => _setPercentAmount(0.75), palette),
                const SizedBox(width: 8),
                _buildQuickChip(isBangla ? 'সর্বোচ্চ (১০০%)' : 'Max (100%)', () => _setPercentAmount(1.0), palette),
              ],
            ),
            const SizedBox(height: 18),

            // Payout Destination Selection
            Text(
              isBangla ? 'টাকা গ্রহণের মাধ্যম' : 'Payout Destination',
              style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            // Destination Channels (Bank vs bKash vs Nagad)
            Row(
              children: [
                Expanded(
                  child: _buildChannelOption(
                    title: isBangla ? 'ব্যাংক' : 'Bank',
                    icon: Icons.account_balance_rounded,
                    channel: PayoutChannel.bankTransfer,
                    palette: palette,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildChannelOption(
                    title: 'bKash',
                    icon: Icons.phone_android_rounded,
                    channel: PayoutChannel.bkash,
                    palette: palette,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildChannelOption(
                    title: 'Nagad',
                    icon: Icons.wallet_rounded,
                    channel: PayoutChannel.nagad,
                    palette: palette,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Destination Details Card
            if (_selectedChannel == PayoutChannel.bankTransfer) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: palette.rule),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.verified_user_rounded, size: 15, color: Color(0xFF00C853)),
                        const SizedBox(width: 6),
                        Text(
                          isBangla ? 'ভেরিফাইড ব্যাংক একাউন্ট (City Bank PLC)' : 'Verified Escrow Clearing Account',
                          style: GoogleFonts.hindSiliguri(fontSize: 12.5, fontWeight: FontWeight.w700, color: palette.ink),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${isBangla ? "হিসাবধারী:" : "Holder:"} ${widget.state.currentUser.name}',
                      style: GoogleFonts.hindSiliguri(fontSize: 12, color: palette.inkSecondary),
                    ),
                    Text(
                      '${isBangla ? "হিসাব নম্বর:" : "A/C No:"} ${kyc.bankAccountNumber} (${isBangla ? "রাউটিং:" : "Routing:"} ${kyc.routingNumber})',
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: palette.ink),
                    ),
                  ],
                ),
              ),
            ] else ...[
              TextField(
                controller: _mfsController,
                keyboardType: TextInputType.phone,
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: palette.ink),
                decoration: InputDecoration(
                  labelText: isBangla ? 'মোবাইল ওয়ালেট নাম্বার' : 'Mobile Wallet Number',
                  labelStyle: GoogleFonts.hindSiliguri(fontSize: 13, color: palette.inkSecondary),
                  hintText: '01XXXXXXXXX',
                  filled: true,
                  fillColor: palette.surfaceSunken,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: palette.rule)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: palette.rule)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ],
            const SizedBox(height: 14),

            // User Note (Optional)
            TextField(
              controller: _noteController,
              style: GoogleFonts.hindSiliguri(fontSize: 13, color: palette.ink),
              decoration: InputDecoration(
                labelText: isBangla ? 'মন্তব্য বা কারণ (ঐচ্ছিক)' : 'Note or Reason (Optional)',
                labelStyle: GoogleFonts.hindSiliguri(fontSize: 13, color: palette.inkSecondary),
                hintText: isBangla ? 'কোনো বিশেষ নির্দেশনা থাকলে লিখুন...' : 'Enter any instructions...',
                filled: true,
                fillColor: palette.surfaceSunken,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: palette.rule)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: palette.rule)),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            const SizedBox(height: 14),

            // Policy & Summary Note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded, size: 16, color: palette.inkSecondary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _selectedType == WithdrawalType.dividend
                          ? (isBangla
                              ? 'লভ্যাংশ উত্তোলনে কোনো ফি নেই (০%)। অডিট যাচাই শেষে ১-২ কার্যদিবসে আপনার একাউন্টে টাকা পৌঁছাবে।'
                              : '0% fee for dividend withdrawals. Settled into your destination in 1-2 business days.')
                          : (isBangla
                              ? 'মূলধন প্রত্যাহারের ক্ষেত্রে জমি/শেয়ার লিকুইডেশন সাপেক্ষে অডিট ও পরিচালনা পর্ষদের অনুমোদন আবশ্যক।'
                              : 'Capital exit requests require compliance review and project share liquidation approval.'),
                      style: GoogleFonts.hindSiliguri(fontSize: 11.5, color: palette.inkSecondary, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
                ),
                child: Text(
                  _errorMessage!,
                  style: GoogleFonts.hindSiliguri(fontSize: 12.5, color: const Color(0xFFEF4444), fontWeight: FontWeight.w600),
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF0066FF).withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(
                        isBangla ? 'অনুরোধ নিশ্চিত করুন' : 'Submit Withdrawal Request',
                        style: GoogleFonts.hindSiliguri(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSegment({
    required String title,
    required WithdrawalType type,
    required bool isSelected,
    required AppPalette palette,
    required bool isBangla,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedType = type;
          _errorMessage = null;
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0066FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.hindSiliguri(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? Colors.white : palette.inkSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickChip(String label, VoidCallback onTap, AppPalette palette) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: palette.surfaceSunken,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: palette.rule),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: palette.ink),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChannelOption({
    required String title,
    required IconData icon,
    required PayoutChannel channel,
    required AppPalette palette,
  }) {
    final isSelected = _selectedChannel == channel;

    return InkWell(
      onTap: () => setState(() => _selectedChannel = channel),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0066FF).withValues(alpha: 0.1) : palette.surfaceSunken,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF0066FF) : palette.rule,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: isSelected ? const Color(0xFF0066FF) : palette.inkSecondary),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? const Color(0xFF0066FF) : palette.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
