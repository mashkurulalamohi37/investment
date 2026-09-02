import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/services/eps_payment_service.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/widgets/brand_icons.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class EpsCheckoutSheet extends StatefulWidget {
  final ProjectModel project;
  final int shareCount;
  final AppState state;
  final VoidCallback onPaymentSuccess;

  const EpsCheckoutSheet({
    super.key,
    required this.project,
    required this.shareCount,
    required this.state,
    required this.onPaymentSuccess,
  });

  static Future<bool?> show({
    required BuildContext context,
    required ProjectModel project,
    required int shareCount,
    required AppState state,
    required VoidCallback onPaymentSuccess,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EpsCheckoutSheet(
        project: project,
        shareCount: shareCount,
        state: state,
        onPaymentSuccess: onPaymentSuccess,
      ),
    );
  }

  @override
  State<EpsCheckoutSheet> createState() => _EpsCheckoutSheetState();
}

class _EpsCheckoutSheetState extends State<EpsCheckoutSheet> {
  int _selectedCategoryIndex = 0; // 0: MFS, 1: Cards, 2: Net Banking
  String _selectedMethod = 'bKash';
  bool _isProcessing = false;
  String _processingStatus = '';

  final EpsPaymentService _epsService = EpsPaymentService();

  final List<Map<String, dynamic>> _mfsChannels = [
    {'name': 'bKash', 'subtitle': 'বিকাশ পেমেন্ট', 'badge': 'জনপ্রিয়'},
    {'name': 'Nagad', 'subtitle': 'নগদ ক্যাশলেস', 'badge': 'ক্যাশব্যাক'},
    {'name': 'Rocket', 'subtitle': 'ডিবিবিএল রকেট', 'badge': 'নগদ ছাড়'},
  ];

  final List<Map<String, dynamic>> _cardChannels = [
    {'name': 'Visa Card', 'subtitle': 'যেকোনো ভিসা কার্ড', 'icon': Icons.credit_card_rounded},
    {'name': 'Mastercard', 'subtitle': 'মাস্টারকার্ড ডেবিট/ক্রেডিট', 'icon': Icons.credit_card_rounded},
    {'name': 'DBBL Nexus', 'subtitle': 'নেক্সাস পে কার্ড', 'icon': Icons.payment_rounded},
  ];

  final List<Map<String, dynamic>> _netBankingChannels = [
    {'name': 'City Touch (City Bank)', 'subtitle': 'ইন্টারনেট ব্যাংকিং', 'icon': Icons.account_balance_rounded},
    {'name': 'BRAC Bank Astha', 'subtitle': 'ব্র্যাক ব্যাংক পোর্টাল', 'icon': Icons.account_balance_rounded},
    {'name': 'Cellfin (IBBL)', 'subtitle': 'ইসলামী ব্যাংক বাংলাদেশ', 'icon': Icons.account_balance_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;
    final totalAmount = widget.shareCount * widget.project.sharePrice;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
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
            // Top Header Bar
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
                  // EPS Official Logo & Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0066FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'EPS',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Easy Payment System',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: palette.ink,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00C853).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'BB Licensed PSO',
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF00C853),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          isBangla ? 'নিরাপদ অনলাইন পেমেন্ট গেটওয়ে' : 'Secure Online Payment Gateway',
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
                    onPressed: _isProcessing ? null : () => Navigator.of(context).pop(),
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
                    // Amount Summary Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF0066FF).withValues(alpha: 0.08),
                            const Color(0xFF00B4D8).withValues(alpha: 0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF0066FF).withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.project.name,
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: palette.ink,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isBangla
                                    ? '${widget.shareCount} টি শেয়ার (৳ ${widget.project.sharePrice.toInt()} / শেয়ার)'
                                    : '${widget.shareCount} Shares (৳ ${widget.project.sharePrice.toInt()} / share)',
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 12,
                                  color: palette.inkSecondary,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                isBangla ? 'মোট প্রদেয়' : 'Total Payable',
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 11,
                                  color: palette.inkTertiary,
                                ),
                              ),
                              Text(
                                '৳ ${totalAmount.toInt()}',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0066FF),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Channel Tabs (MFS / Cards / Net Banking)
                    Text(
                      isBangla ? 'পেমেন্ট মাধ্যম বেছে নিন' : 'Select Payment Method',
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: palette.ink,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: palette.surfaceSunken,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          _buildCategoryTab(0, isBangla ? 'মোবাইল ওয়ালেট' : 'MFS Wallet', Icons.phone_android_rounded, palette),
                          _buildCategoryTab(1, isBangla ? 'কার্ড' : 'Cards', Icons.credit_card_rounded, palette),
                          _buildCategoryTab(2, isBangla ? 'নেট ব্যাংকিং' : 'Net Banking', Icons.account_balance_rounded, palette),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // List of channels for selected category
                    if (_selectedCategoryIndex == 0) ...[
                      ..._mfsChannels.map((item) => _buildMfsOption(item, palette)),
                    ] else if (_selectedCategoryIndex == 1) ...[
                      ..._cardChannels.map((item) => _buildCardOption(item, palette)),
                    ] else ...[
                      ..._netBankingChannels.map((item) => _buildNetBankingOption(item, palette)),
                    ],

                    const SizedBox(height: 18),

                    // Security Guarantee Notice
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: palette.surfaceSunken,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: palette.rule, width: 1),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lock_outline_rounded, size: 16, color: Color(0xFF00C853)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              isBangla
                                  ? 'EPS-এর মাধ্যমে আপনার লেনদেন ২৫৬-বিট এসএসএল এনক্রিপশনে সুরক্ষিত।'
                                  : 'Transactions are secured with 256-bit SSL encryption via EPS.',
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 11,
                                color: palette.inkSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Pay Now CTA Bottom Button
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _handleEpsPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: _isProcessing
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _processingStatus.isNotEmpty
                                  ? _processingStatus
                                  : (isBangla ? 'EPS গেটওয়ে ভেরিফিকেশন...' : 'Connecting EPS Gateway...'),
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.bolt_rounded, color: Colors.amber, size: 20),
                            const SizedBox(width: 6),
                            Text(
                              isBangla
                                  ? '$_selectedMethod দিয়ে পরিশোধ করুন (৳ ${totalAmount.toInt()})'
                                  : 'Pay ৳ ${totalAmount.toInt()} via $_selectedMethod',
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(int index, String title, IconData icon, AppPalette palette) {
    final isSelected = _selectedCategoryIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategoryIndex = index;
            if (index == 0) _selectedMethod = 'bKash';
            if (index == 1) _selectedMethod = 'Visa Card';
            if (index == 2) _selectedMethod = 'City Touch (City Bank)';
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0066FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.white : palette.inkSecondary,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: GoogleFonts.hindSiliguri(
                  fontSize: 11.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : palette.inkSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMfsOption(Map<String, dynamic> item, AppPalette palette) {
    final isSelected = _selectedMethod == item['name'];
    Widget logo;
    if (item['name'] == 'bKash') {
      logo = const BkashLogoWidget(size: 32);
    } else if (item['name'] == 'Nagad') {
      logo = const NagadLogoWidget(size: 32);
    } else {
      logo = const RocketLogoWidget(size: 32);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => setState(() => _selectedMethod = item['name']),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF0066FF) : palette.rule,
              width: isSelected ? 1.8 : 1.0,
            ),
          ),
          child: Row(
            children: [
              logo,
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: palette.ink,
                          ),
                        ),
                        if (item['badge'] != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0066FF).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item['badge'],
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0066FF),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      item['subtitle'],
                      style: GoogleFonts.hindSiliguri(fontSize: 11, color: palette.inkSecondary),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                size: 20,
                color: isSelected ? const Color(0xFF0066FF) : palette.inkTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardOption(Map<String, dynamic> item, AppPalette palette) {
    final isSelected = _selectedMethod == item['name'];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => setState(() => _selectedMethod = item['name']),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF0066FF) : palette.rule,
              width: isSelected ? 1.8 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF0066FF).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item['icon'] as IconData, color: const Color(0xFF0066FF), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: palette.ink,
                      ),
                    ),
                    Text(
                      item['subtitle'],
                      style: GoogleFonts.hindSiliguri(fontSize: 11, color: palette.inkSecondary),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                size: 20,
                color: isSelected ? const Color(0xFF0066FF) : palette.inkTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetBankingOption(Map<String, dynamic> item, AppPalette palette) {
    final isSelected = _selectedMethod == item['name'];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => setState(() => _selectedMethod = item['name']),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF0066FF) : palette.rule,
              width: isSelected ? 1.8 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item['icon'] as IconData, color: const Color(0xFF00C853), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: palette.ink,
                      ),
                    ),
                    Text(
                      item['subtitle'],
                      style: GoogleFonts.hindSiliguri(fontSize: 11, color: palette.inkSecondary),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                size: 20,
                color: isSelected ? const Color(0xFF0066FF) : palette.inkTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleEpsPayment() async {
    final isBangla = widget.state.isBangla;
    final totalAmount = widget.shareCount * widget.project.sharePrice;
    final user = widget.state.currentUser;

    setState(() {
      _isProcessing = true;
      _processingStatus = isBangla ? 'EPS গেটওয়েতে সংযোগ হচ্ছে...' : 'Connecting to EPS Gateway...';
    });

    final request = EpsPaymentSessionRequest(
      merchantTransactionId: EpsPaymentService.generateTxnId(),
      amount: totalAmount,
      customerName: user.name,
      customerEmail: user.email,
      customerPhone: user.phone,
      projectTitle: widget.project.name,
      shareCount: widget.shareCount,
    );

    // Simulate OTP / Payment Confirmation via EPS
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _processingStatus = isBangla ? '$_selectedMethod অথেনটিকেশন সম্পন্ন হচ্ছে...' : 'Verifying with $_selectedMethod...';
    });

    final response = await _epsService.processEpsCheckout(
      request: request,
      selectedChannel: _selectedMethod,
    );

    if (!mounted) return;

    if (response.isSuccess) {
      // Complete investment in state with EPS Gateway status
      widget.state.submitEpsInvestment(
        shares: widget.shareCount,
        paymentMethod: 'EPS ($_selectedMethod)',
        epsTransactionId: response.epsTransactionId,
      );

      widget.onPaymentSuccess();
      Navigator.of(context).pop(true);
    }
  }
}
