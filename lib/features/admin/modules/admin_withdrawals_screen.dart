import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/models/withdrawal_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AdminWithdrawalsScreen extends StatefulWidget {
  final AppState state;

  const AdminWithdrawalsScreen({
    super.key,
    required this.state,
  });

  @override
  State<AdminWithdrawalsScreen> createState() => _AdminWithdrawalsScreenState();
}

class _AdminWithdrawalsScreenState extends State<AdminWithdrawalsScreen> {
  int _selectedFilterIndex = 0;

  final List<String> _filtersEn = ['All', 'Pending Approval', 'Disbursed', 'Rejected'];
  final List<String> _filtersBn = ['সকল', 'অনুমোদনের অপেক্ষায়', 'পরিশোধিত', 'প্রত্যাখ্যাত'];

  void _showApproveDialog(WithdrawalModel item) {
    final isBangla = widget.state.isBangla;
    final trxController = TextEditingController(
      text: 'EFT-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
    );
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Color(0xFF00C853), size: 22),
            const SizedBox(width: 8),
            Text(isBangla ? 'উত্তোলন অনুমোদন ও নিষ্পত্তি' : 'Approve & Disburse Payout'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${isBangla ? "বিনিয়োগকারী:" : "Investor:"} ${item.userName}',
                style: GoogleFonts.hindSiliguri(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                '${isBangla ? "উত্তোলনের পরিমাণ:" : "Amount:"} ${CurrencyFormatter.format(item.amount, isBangla: isBangla)} (${item.typeLabelEn})',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14, color: const Color(0xFF0066FF)),
              ),
              Text(
                '${isBangla ? "পেমেন্ট মাধ্যম:" : "Destination:"} ${item.destinationSummary}',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: trxController,
                decoration: InputDecoration(
                  labelText: isBangla ? 'ব্যাংক/বিকাশ ট্রানজেকশন রেফারেন্স *' : 'Transaction Ref / Voucher No *',
                  hintText: 'e.g. CBL-EFT-991823',
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: isBangla ? 'অ্যাডমিন মন্তব্য (ঐচ্ছিক)' : 'Disbursement Note (Optional)',
                  hintText: isBangla ? 'ব্যাংক ট্রান্সফার সম্পন্ন...' : 'Transferred successfully...',
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(isBangla ? 'ফিরে যান' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final ref = trxController.text.trim();
              if (ref.isEmpty) return;

              widget.state.adminApproveWithdrawal(
                item.id,
                transactionRef: ref,
                adminFeedback: noteController.text.trim().isNotEmpty ? noteController.text.trim() : null,
              );
              Navigator.pop(ctx);
              setState(() {});

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF00C853),
                  content: Text(
                    isBangla ? 'উত্তোলন সফলভাবে অনুমোদিত এবং নিষ্পন্ন হয়েছে!' : 'Withdrawal successfully approved and settled!',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C853),
              foregroundColor: Colors.white,
            ),
            child: Text(isBangla ? 'অনুমোদন নিশ্চিত করুন' : 'Confirm Disbursement'),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(WithdrawalModel item) {
    final isBangla = widget.state.isBangla;
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.cancel_rounded, color: Color(0xFFEF4444), size: 22),
            const SizedBox(width: 8),
            Text(isBangla ? 'উত্তোলন আবেদন প্রত্যাখ্যান' : 'Decline Withdrawal'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla
                  ? 'উত্তোলন বাতিলের সুনির্দিষ্ট কারণ উল্লেখ করুন যা বিনিয়োগকারীকে জানানো হবে:'
                  : 'Please state the reason for rejection (will be sent to investor):',
              style: GoogleFonts.hindSiliguri(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: isBangla
                    ? 'যেমন: লক-ইন মেয়াদ চলমান / ব্যাংক রাউটিং নম্বরে অসঙ্গতি...'
                    : 'e.g. Active lock-in period / bank routing discrepancy...',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(isBangla ? 'ফিরে যান' : 'Back'),
          ),
          ElevatedButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              if (reason.isEmpty) return;

              widget.state.adminRejectWithdrawal(item.id, reason: reason);
              Navigator.pop(ctx);
              setState(() {});

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFFEF4444),
                  content: Text(
                    isBangla ? 'উত্তোলন আবেদনটি বাতিল করা হয়েছে।' : 'Withdrawal request has been rejected.',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            child: Text(isBangla ? 'প্রত্যাখ্যান নিশ্চিত করুন' : 'Decline Request'),
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
    final withdrawals = widget.state.withdrawals;
    final filters = isBangla ? _filtersBn : _filtersEn;

    final filteredList = withdrawals.where((w) {
      if (_selectedFilterIndex == 1) {
        return w.status == WithdrawalStatus.pending ||
            w.status == WithdrawalStatus.underReview ||
            w.status == WithdrawalStatus.processing;
      }
      if (_selectedFilterIndex == 2) {
        return w.status == WithdrawalStatus.completed;
      }
      if (_selectedFilterIndex == 3) {
        return w.status == WithdrawalStatus.rejected || w.status == WithdrawalStatus.cancelled;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: palette.ink),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isBangla ? 'উত্তোলন অনুমোদন কিউ' : 'Withdrawal Approvals Queue',
          style: GoogleFonts.hindSiliguri(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Admin KPI Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: palette.rule),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildKpiCol(
                    isBangla ? 'অপেক্ষমান আবেদন' : 'Pending Requests',
                    '${widget.state.adminPendingWithdrawalsCount}',
                    const Color(0xFFF59E0B),
                    isBangla,
                  ),
                  Container(width: 1, height: 30, color: palette.rule),
                  _buildKpiCol(
                    isBangla ? 'অপেক্ষমান তহবিল' : 'Pending Amount',
                    CurrencyFormatter.format(widget.state.pendingWithdrawalAmount, isBangla: isBangla),
                    const Color(0xFF0066FF),
                    isBangla,
                  ),
                  Container(width: 1, height: 30, color: palette.rule),
                  _buildKpiCol(
                    isBangla ? 'নিষ্পন্ন তহবিল' : 'Total Disbursed',
                    CurrencyFormatter.format(widget.state.totalWithdrawnAmount, isBangla: isBangla),
                    const Color(0xFF00C853),
                    isBangla,
                  ),
                ],
              ),
            ),

            // Filter Tabs
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilterIndex == index;
                  return InkWell(
                    onTap: () => setState(() => _selectedFilterIndex = index),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0066FF) : palette.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? const Color(0xFF0066FF) : palette.rule),
                      ),
                      child: Center(
                        child: Text(
                          filters[index],
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                            color: isSelected ? Colors.white : palette.inkSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Queue List
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Text(
                        isBangla ? 'কোনো উইথড্রয়াল আবেদন পেন্ডিং নেই' : 'No withdrawal requests in queue',
                        style: GoogleFonts.hindSiliguri(fontSize: 14, color: palette.inkSecondary),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: filteredList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return _buildAdminQueueCard(item, palette, isDark, isBangla);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCol(String label, String value, Color color, bool isBangla) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.hindSiliguri(fontSize: 11.5, color: Colors.grey[600]),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: color),
        ),
      ],
    );
  }

  Widget _buildAdminQueueCard(
    WithdrawalModel item,
    AppPalette palette,
    bool isDark,
    bool isBangla,
  ) {
    final isPending = item.status == WithdrawalStatus.pending;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPending ? const Color(0xFF0066FF).withValues(alpha: 0.5) : palette.rule,
          width: isPending ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: User & Type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFF0066FF).withValues(alpha: 0.1),
                    child: Text(
                      item.userName.isNotEmpty ? item.userName[0] : 'U',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.userName,
                        style: GoogleFonts.hindSiliguri(fontSize: 14, fontWeight: FontWeight.w700, color: palette.ink),
                      ),
                      Text(
                        'ID: ${item.userId} • ${item.typeLabelEn}',
                        style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                CurrencyFormatter.format(item.amount, isBangla: isBangla),
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800, color: const Color(0xFF0066FF)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Destination Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      item.payoutChannel == PayoutChannel.bankTransfer ? Icons.account_balance_rounded : Icons.phone_android_rounded,
                      size: 14,
                      color: palette.inkSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.destinationSummary,
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: palette.ink),
                    ),
                  ],
                ),
                if (item.routingNumber != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Routing: ${item.routingNumber} | Branch: ${item.branchName ?? "Main"}',
                    style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary),
                  ),
                ],
                if (item.userNote != null && item.userNote!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${isBangla ? "বিনিয়োগকারীর নোট:" : "Note:"} "${item.userNote}"',
                    style: GoogleFonts.hindSiliguri(fontSize: 11.5, fontStyle: FontStyle.italic, color: palette.inkSecondary),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Trx Ref / Feedback if already processed
          if (item.transactionRef != null) ...[
            Text(
              'Trx Ref: ${item.transactionRef}',
              style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF00C853)),
            ),
          ],
          if (item.adminFeedback != null && item.adminFeedback!.isNotEmpty) ...[
            Text(
              'Feedback: ${item.adminFeedback}',
              style: GoogleFonts.hindSiliguri(fontSize: 11.5, color: palette.inkSecondary),
            ),
          ],

          // Action Buttons for Pending Requests
          if (isPending) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showRejectDialog(item),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(color: Color(0xFFEF4444)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      isBangla ? 'প্রত্যাখ্যান' : 'Decline',
                      style: GoogleFonts.hindSiliguri(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _showApproveDialog(item),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C853),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 0,
                    ),
                    child: Text(
                      isBangla ? 'অনুমোদন ও নিষ্পত্তি' : 'Approve & Disburse',
                      style: GoogleFonts.hindSiliguri(fontSize: 13, fontWeight: FontWeight.w700),
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
}
