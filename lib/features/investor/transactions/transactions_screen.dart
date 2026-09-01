import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class TransactionsScreen extends StatefulWidget {
  final AppState state;

  const TransactionsScreen({
    super.key,
    required this.state,
  });

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  int _selectedTabIndex = 0;

  final List<String> _tabsEn = ['All', 'Investment', 'Profit', 'Return'];
  final List<String> _tabsBn = ['সব', 'বিনিয়োগ', 'লাভ', 'প্রাপ্তি'];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;
    final tabs = isBangla ? _tabsBn : _tabsEn;

    final allTx = [
      _TxItem(
        title: isBangla ? 'বিনিয়োগ' : 'Investment',
        subtitle: 'LandVest 100 (Share #3)',
        date: '05 Sep 2026',
        amount: '+ ৳ 25,500',
        isProfit: false,
        icon: Icons.account_balance_wallet_rounded,
        color: const Color(0xFF0066FF),
      ),
      _TxItem(
        title: isBangla ? 'বিনিয়োগ' : 'Investment',
        subtitle: 'LandVest 100 (Share #2)',
        date: '05 Sep 2026',
        amount: '+ ৳ 25,500',
        isProfit: false,
        icon: Icons.account_balance_wallet_rounded,
        color: const Color(0xFF0066FF),
      ),
      _TxItem(
        title: isBangla ? 'বিনিয়োগ' : 'Investment',
        subtitle: 'LandVest 100 (Share #1)',
        date: '05 Sep 2026',
        amount: '+ ৳ 25,500',
        isProfit: false,
        icon: Icons.account_balance_wallet_rounded,
        color: const Color(0xFF0066FF),
      ),
      _TxItem(
        title: isBangla ? 'লাভ বিতরণ' : 'Profit Distribution',
        subtitle: 'LandVest 100',
        date: '15 Mar 2027',
        amount: '+ ৳ 8,450',
        isProfit: true,
        icon: Icons.monetization_on_rounded,
        color: const Color(0xFF00C853),
      ),
      _TxItem(
        title: isBangla ? 'লাভ বিতরণ' : 'Profit Distribution',
        subtitle: 'LandVest 100',
        date: '15 Sep 2027',
        amount: '+ ৳ 6,200',
        isProfit: true,
        icon: Icons.monetization_on_rounded,
        color: const Color(0xFF00C853),
      ),
    ];

    final filteredTx = allTx.where((tx) {
      if (_selectedTabIndex == 1) return !tx.isProfit;
      if (_selectedTabIndex == 2) return tx.isProfit;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isBangla ? 'লেনদেন ইতিহাস' : 'Transaction History',
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
            // Tabs Row
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedTabIndex == index;
                  return InkWell(
                    onTap: () => setState(() => _selectedTabIndex = index),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
                        tabs[index],
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 12.5,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? Colors.white : palette.inkSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Transactions List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: filteredTx.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = filteredTx[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: palette.rule, width: 1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: item.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(item.icon, size: 20, color: item.color),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: GoogleFonts.hindSiliguri(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: palette.ink,
                                  ),
                                ),
                                Text(
                                  item.subtitle,
                                  style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary),
                                ),
                                Text(
                                  item.date,
                                  style: GoogleFonts.poppins(fontSize: 10, color: palette.inkTertiary),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          item.amount,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: item.isProfit ? const Color(0xFF00C853) : const Color(0xFF0066FF),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Download Statement Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isBangla ? 'স্টেটমেন্ট ডাউনলোড শুরু হয়েছে' : 'Downloading Statement...'),
                        backgroundColor: const Color(0xFF0066FF),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    isBangla ? 'স্টেটমেন্ট ডাউনলোড করুন' : 'Download Statement',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 16,
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
}

class _TxItem {
  final String title;
  final String subtitle;
  final String date;
  final String amount;
  final bool isProfit;
  final IconData icon;
  final Color color;

  _TxItem({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.isProfit,
    required this.icon,
    required this.color,
  });
}
