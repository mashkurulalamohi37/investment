import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/models/investment_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AdminPaymentVerificationScreen extends StatefulWidget {
  final AppState state;

  const AdminPaymentVerificationScreen({
    super.key,
    required this.state,
  });

  @override
  State<AdminPaymentVerificationScreen> createState() => _AdminPaymentVerificationScreenState();
}

class _AdminPaymentVerificationScreenState extends State<AdminPaymentVerificationScreen> {
  int _selectedFilterIndex = 0; // 0: Pending, 1: Approved / Allocated, 2: All

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;

    final allInvestments = widget.state.investments;
    final pendingList = allInvestments
        .where((i) =>
            i.status == InvestmentStatus.pending ||
            i.status == InvestmentStatus.pendingPaymentVerification)
        .toList();
    final approvedList = allInvestments
        .where((i) =>
            i.status == InvestmentStatus.allocated ||
            i.status == InvestmentStatus.verified)
        .toList();

    List<InvestmentModel> displayList;
    if (_selectedFilterIndex == 0) {
      displayList = pendingList;
    } else if (_selectedFilterIndex == 1) {
      displayList = approvedList;
    } else {
      displayList = allInvestments;
    }

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isBangla ? 'পেমেন্ট ও ব্যাংক রসিদ যাচাই' : 'Payment & Deposit Verification',
          style: GoogleFonts.hindSiliguri(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // KPI Summary Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: isBangla ? 'যাচাই পেন্ডিং' : 'Pending Review',
                      count: '${pendingList.length}',
                      color: const Color(0xFFFF9800),
                      palette: palette,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      title: isBangla ? 'অনুমোদিত ডিপোজিট' : 'Approved Deposits',
                      count: '${approvedList.length}',
                      color: const Color(0xFF00C853),
                      palette: palette,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Filter Tabs
            Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildFilterTab(0, isBangla ? 'যাচাই প্রয়োজন (${pendingList.length})' : 'Pending (${pendingList.length})', palette),
                  const SizedBox(width: 8),
                  _buildFilterTab(1, isBangla ? 'অনুমোদিত (${approvedList.length})' : 'Approved (${approvedList.length})', palette),
                  const SizedBox(width: 8),
                  _buildFilterTab(2, isBangla ? 'সকল (${allInvestments.length})' : 'All (${allInvestments.length})', palette),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // List of Investments
            Expanded(
              child: displayList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_turned_in_outlined, size: 48, color: palette.inkTertiary),
                          const SizedBox(height: 10),
                          Text(
                            isBangla ? 'কোনো যাচাই পেন্ডিং নেই' : 'No pending deposit slips',
                            style: GoogleFonts.hindSiliguri(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: palette.inkSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      itemCount: displayList.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = displayList[index];
                        return _buildDepositCard(item, palette, isBangla);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String count,
    required Color color,
    required AppPalette palette,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.ruleStrong, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.hindSiliguri(fontSize: 11.5, color: palette.inkSecondary),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(
                count,
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800, color: palette.ink),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(int index, String label, AppPalette palette) {
    final isSelected = _selectedFilterIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilterIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0066FF) : palette.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF0066FF) : palette.ruleStrong,
            width: 1.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.hindSiliguri(
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : palette.ink,
          ),
        ),
      ),
    );
  }

  Widget _buildDepositCard(InvestmentModel item, AppPalette palette, bool isBangla) {
    final isPending = item.status == InvestmentStatus.pending ||
        item.status == InvestmentStatus.pendingPaymentVerification;
    final isApproved = item.status == InvestmentStatus.allocated ||
        item.status == InvestmentStatus.verified;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPending ? const Color(0xFFFF9800).withValues(alpha: 0.4) : palette.rule,
          width: isPending ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Inv No & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: (item.paymentGateway == 'EPS'
                              ? const Color(0xFF0066FF)
                              : const Color(0xFF7B1FA2))
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.paymentGateway == 'EPS' ? 'EPS Gateway' : 'Bank Deposit',
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: item.paymentGateway == 'EPS'
                            ? const Color(0xFF0066FF)
                            : const Color(0xFF7B1FA2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.investmentNo,
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: palette.inkSecondary),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isPending
                      ? const Color(0xFFFF9800).withValues(alpha: 0.15)
                      : isApproved
                          ? const Color(0xFF00C853).withValues(alpha: 0.15)
                          : Colors.redAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isPending
                      ? (isBangla ? 'যাচাই প্রক্রিয়াধীন' : 'Pending Review')
                      : isApproved
                          ? (isBangla ? 'অনুমোদিত' : 'Approved')
                          : (isBangla ? 'বাতিলকৃত' : 'Rejected'),
                  style: GoogleFonts.hindSiliguri(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isPending
                        ? const Color(0xFFFF9800)
                        : isApproved
                            ? const Color(0xFF00C853)
                            : Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Project & Investor Info
          Text(
            item.projectName,
            style: GoogleFonts.hindSiliguri(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: palette.ink,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${isBangla ? 'শেয়ার সংখ্যা' : 'Shares'}: ${item.shares}টি',
                style: GoogleFonts.hindSiliguri(fontSize: 12.5, color: palette.inkSecondary),
              ),
              Text(
                '৳ ${item.grossAmount.toInt()}',
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: const Color(0xFF0066FF)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: palette.rule, height: 1),
          const SizedBox(height: 8),

          // Payment Details
          Row(
            children: [
              const Icon(Icons.payment_rounded, size: 14, color: Color(0xFF0066FF)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${item.paymentMethod ?? 'Bank Transfer'} • Ref: ${item.paymentReference ?? 'N/A'}',
                  style: GoogleFonts.poppins(fontSize: 11.5, color: palette.ink),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          if (item.depositorName != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.person_outline_rounded, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${isBangla ? 'জমাদানকারী' : 'Depositor'}: ${item.depositorName}',
                  style: GoogleFonts.hindSiliguri(fontSize: 11.5, color: palette.inkSecondary),
                ),
              ],
            ),
          ],

          if (isApproved && item.allocatedLotNumbers.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF00C853).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF00C853)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '${isBangla ? 'বরাদ্দকৃত লট' : 'Allocated Lots'}: ${item.allocatedLotNumbers.join(', ')}',
                      style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF00C853)),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Actions
          if (isPending) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openReceiptInspector(item),
                    icon: const Icon(Icons.receipt_long_rounded, size: 16),
                    label: Text(
                      isBangla ? 'রসিদ দেখুন' : 'Inspect Slip',
                      style: GoogleFonts.hindSiliguri(fontSize: 12.5, fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: palette.ink,
                      side: BorderSide(color: palette.ruleStrong),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _approveDeposit(item),
                    icon: const Icon(Icons.check_rounded, size: 16, color: Colors.white),
                    label: Text(
                      isBangla ? 'অনুমোদন করুন' : 'Approve',
                      style: GoogleFonts.hindSiliguri(fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C853),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _openReceiptInspector(InvestmentModel item) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: palette.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'ব্যাংক জমার রসিদ যাচাই' : 'Deposit Receipt Inspector',
                    style: GoogleFonts.hindSiliguri(fontSize: 16, fontWeight: FontWeight.w700, color: palette.ink),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Realistic Deposit Slip Graphic Frame
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: palette.ruleStrong),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.receipt_long_rounded, size: 48, color: Color(0xFF0066FF)),
                          const SizedBox(height: 8),
                          Text(
                            'BANK DEPOSIT SLIP',
                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.2, color: palette.ink),
                          ),
                          Text(
                            'Ref: ${item.paymentReference ?? 'DEP-9821408'}',
                            style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary),
                          ),
                          Text(
                            'Amount: ৳ ${item.grossAmount.toInt()} • City Bank Ltd',
                            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF0066FF)),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00C853).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'BANK SEAL VERIFIED',
                          style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w700, color: const Color(0xFF00C853)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Details
              _buildInspectorRow(isBangla ? 'প্রকল্প' : 'Project', item.projectName, palette),
              _buildInspectorRow(isBangla ? 'জমাদানকারী' : 'Depositor', item.depositorName ?? 'Mashkurul Alam Ohi', palette),
              _buildInspectorRow(isBangla ? 'স্লিপ / ট্রানজেকশন' : 'Slip / Txn Ref', item.paymentReference ?? 'N/A', palette),
              _buildInspectorRow(isBangla ? 'পরিমাণ' : 'Amount', '৳ ${item.grossAmount.toInt()}', palette, isBold: true),
              const SizedBox(height: 18),

              // Action Buttons inside inspector
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _rejectDeposit(item);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(isBangla ? 'বাতিল করুন' : 'Reject', style: GoogleFonts.hindSiliguri(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _approveDeposit(item);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C853),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(isBangla ? 'অনুমোদন ও লট বরাদ্দ' : 'Approve & Allocate', style: GoogleFonts.hindSiliguri(fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInspectorRow(String label, String value, AppPalette palette, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.hindSiliguri(fontSize: 12, color: palette.inkSecondary)),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: isBold ? const Color(0xFF0066FF) : palette.ink,
            ),
          ),
        ],
      ),
    );
  }

  void _approveDeposit(InvestmentModel item) {
    final isBangla = widget.state.isBangla;
    widget.state.adminVerifyAndAllocateShare(item.id);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBangla
              ? '${item.investmentNo} এর পেমেন্ট অনুমোদিত হয়েছে এবং শেয়ার লট বরাদ্দ সম্পন্ন হয়েছে!'
              : '${item.investmentNo} approved and share lots allocated!',
        ),
        backgroundColor: const Color(0xFF00C853),
      ),
    );
  }

  void _rejectDeposit(InvestmentModel item) {
    final isBangla = widget.state.isBangla;
    widget.state.adminRejectInvestment(item.id, 'Invalid deposit slip reference');
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBangla
              ? '${item.investmentNo} এর জমার রসিদ বাতিল করা হয়েছে।'
              : '${item.investmentNo} deposit rejected.',
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
