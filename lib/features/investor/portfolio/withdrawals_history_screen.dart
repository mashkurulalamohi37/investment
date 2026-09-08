import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/models/withdrawal_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/portfolio/widgets/withdrawal_request_sheet.dart';

class WithdrawalsHistoryScreen extends StatefulWidget {
  final AppState state;

  const WithdrawalsHistoryScreen({
    super.key,
    required this.state,
  });

  @override
  State<WithdrawalsHistoryScreen> createState() => _WithdrawalsHistoryScreenState();
}

class _WithdrawalsHistoryScreenState extends State<WithdrawalsHistoryScreen> {
  int _selectedFilterIndex = 0;

  final List<String> _filtersEn = ['All', 'Pending', 'Completed', 'Rejected'];
  final List<String> _filtersBn = ['সকল', 'অপেক্ষমান', 'পরিশোধিত', 'প্রত্যাখ্যাত'];

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
          isBangla ? 'তহবিল উত্তোলন খতিয়ান' : 'Withdrawal Ledger',
          style: GoogleFonts.hindSiliguri(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              WithdrawalRequestSheet.show(
                context,
                state: widget.state,
                onSuccess: () => setState(() {}),
              );
            },
            icon: const Icon(Icons.add_circle_outline_rounded, color: Color(0xFF0066FF), size: 24),
            tooltip: isBangla ? 'নতুন উত্তোলন অনুরোধ' : 'New Request',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // KPI Summary Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: palette.rule),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBangla ? 'উত্তোলনযোগ্য লভ্যাংশ' : 'Available Profit',
                            style: GoogleFonts.hindSiliguri(fontSize: 11.5, color: palette.inkSecondary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            CurrencyFormatter.format(widget.state.availableDividendBalance, isBangla: isBangla),
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0066FF)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: palette.rule),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBangla ? 'মোট উত্তোলিত অর্থ' : 'Total Withdrawn',
                            style: GoogleFonts.hindSiliguri(fontSize: 11.5, color: palette.inkSecondary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            CurrencyFormatter.format(widget.state.totalWithdrawnAmount, isBangla: isBangla),
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF00C853)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Filter Tabs
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 8),
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

            // List of Withdrawals
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_long_outlined, size: 48, color: palette.inkSecondary.withValues(alpha: 0.5)),
                          const SizedBox(height: 12),
                          Text(
                            isBangla ? 'কোনো উত্তোলন রেকর্ড পাওয়া যায়নি' : 'No withdrawal records found',
                            style: GoogleFonts.hindSiliguri(fontSize: 14, color: palette.inkSecondary, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: () {
                              WithdrawalRequestSheet.show(
                                context,
                                state: widget.state,
                                onSuccess: () => setState(() {}),
                              );
                            },
                            icon: const Icon(Icons.add, size: 16),
                            label: Text(isBangla ? 'অনুরোধ পাঠান' : 'Submit Request', style: GoogleFonts.hindSiliguri(fontWeight: FontWeight.w700)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0066FF),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: filteredList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return _buildWithdrawalCard(item, palette, isDark, isBangla);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithdrawalCard(
    WithdrawalModel item,
    AppPalette palette,
    bool isDark,
    bool isBangla,
  ) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (item.status) {
      case WithdrawalStatus.pending:
        statusColor = const Color(0xFFF59E0B);
        statusText = isBangla ? 'পর্যালোচনাধীন' : 'Pending Review';
        statusIcon = Icons.hourglass_top_rounded;
        break;
      case WithdrawalStatus.underReview:
      case WithdrawalStatus.processing:
        statusColor = const Color(0xFF0066FF);
        statusText = isBangla ? 'প্রক্রিয়াধীন' : 'Processing';
        statusIcon = Icons.sync_rounded;
        break;
      case WithdrawalStatus.completed:
        statusColor = const Color(0xFF00C853);
        statusText = isBangla ? 'পরিশোধিত' : 'Completed';
        statusIcon = Icons.check_circle_rounded;
        break;
      case WithdrawalStatus.rejected:
        statusColor = const Color(0xFFEF4444);
        statusText = isBangla ? 'প্রত্যাখ্যাত' : 'Rejected';
        statusIcon = Icons.cancel_rounded;
        break;
      case WithdrawalStatus.cancelled:
        statusColor = palette.inkSecondary;
        statusText = isBangla ? 'বাতিলকৃত' : 'Cancelled';
        statusIcon = Icons.block_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.rule),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Type & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: item.type == WithdrawalType.dividend
                          ? const Color(0xFF00C853).withValues(alpha: 0.12)
                          : const Color(0xFF0066FF).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      item.type == WithdrawalType.dividend ? Icons.monetization_on_rounded : Icons.account_balance_rounded,
                      size: 16,
                      color: item.type == WithdrawalType.dividend ? const Color(0xFF00C853) : const Color(0xFF0066FF),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isBangla ? item.typeLabelBn : item.typeLabelEn,
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: palette.ink,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 12, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      statusText,
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Amount & Destination
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBangla ? 'উত্তোলিত অর্থ' : 'Requested Amount',
                    style: GoogleFonts.hindSiliguri(fontSize: 11.5, color: palette.inkSecondary),
                  ),
                  Text(
                    CurrencyFormatter.format(item.amount, isBangla: isBangla),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: palette.ink,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isBangla ? 'পেমেন্ট চ্যানেল' : 'Payment Channel',
                    style: GoogleFonts.hindSiliguri(fontSize: 11.5, color: palette.inkSecondary),
                  ),
                  Text(
                    item.destinationSummary,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: palette.ink,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: palette.rule, height: 1),
          const SizedBox(height: 10),

          // Date & Trx Ref / Note
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                CurrencyFormatter.formatDate(item.createdAt, isBangla: isBangla),
                style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary),
              ),
              if (item.transactionRef != null)
                Text(
                  'Ref: ${item.transactionRef}',
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF0066FF)),
                ),
            ],
          ),

          if (item.adminFeedback != null && item.adminFeedback!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${isBangla ? "অ্যাডমিন মন্তব্য:" : "Admin note:"} ${item.adminFeedback}',
                style: GoogleFonts.hindSiliguri(fontSize: 11, color: palette.inkSecondary),
              ),
            ),
          ],

          // Cancel button if still pending
          if (item.status == WithdrawalStatus.pending) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(isBangla ? 'অনুরোধ বাতিল করবেন?' : 'Cancel Request?'),
                      content: Text(
                        isBangla
                            ? 'আপনি কি নিশ্চিত যে ৳${item.amount} উত্তোলনের অনুরোধটি প্রত্যাহার করতে চান?'
                            : 'Are you sure you want to cancel the withdrawal request of ৳${item.amount}?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(isBangla ? 'না' : 'No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            widget.state.cancelWithdrawalRequest(item.id);
                            setState(() {});
                          },
                          child: Text(
                            isBangla ? 'হ্যাঁ, বাতিল করুন' : 'Yes, Cancel',
                            style: const TextStyle(color: Color(0xFFEF4444)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.close, size: 14, color: Color(0xFFEF4444)),
                label: Text(
                  isBangla ? 'অনুরোধ বাতিল করুন' : 'Cancel Request',
                  style: GoogleFonts.hindSiliguri(fontSize: 12, color: const Color(0xFFEF4444), fontWeight: FontWeight.w600),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
