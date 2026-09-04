import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/transactions/transactions_screen.dart';

class MyInvestmentScreen extends StatelessWidget {
  final ProjectModel project;
  final AppState state;

  const MyInvestmentScreen({
    super.key,
    required this.project,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = state.isBangla;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: palette.ink),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'আমার বিনিয়োগ' : 'My Investment',
              style: GoogleFonts.hindSiliguri(
                fontSize: 12.5,
                color: palette.inkSecondary,
              ),
            ),
            Text(
              project.name,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: palette.ink,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Royal Blue Summary Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0066FF), Color(0xFF0A2540)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCol(isBangla ? 'মোট শেয়ার' : 'Total Shares', '3', isBangla),
                    Container(width: 1, height: 32, color: Colors.white.withValues(alpha: 0.2)),
                    _buildStatCol(isBangla ? 'মোট বিনিয়োগ' : 'Total Invested', '৳ 76,500', isBangla),
                    Container(width: 1, height: 32, color: Colors.white.withValues(alpha: 0.2)),
                    _buildStatCol(isBangla ? 'মোট লাভ' : 'Total Profit', '৳ 8,450', isBangla, isProfit: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Shares Breakdown List
              Text(
                isBangla ? 'শেয়ারের বিবরণ' : 'Shares Breakdown',
                style: GoogleFonts.hindSiliguri(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: palette.ink,
                ),
              ),
              const SizedBox(height: 12),

              _buildShareItem('Share #1', '05 Sep 2026', '৳ 25,500', palette),
              const SizedBox(height: 10),
              _buildShareItem('Share #2', '05 Sep 2026', '৳ 25,500', palette),
              const SizedBox(height: 10),
              _buildShareItem('Share #3', '05 Sep 2026', '৳ 25,500', palette),
              const SizedBox(height: 20),

              // 3. Deed & Status Info Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBangla ? 'বিনিয়োগ শুরুর তারিখ' : 'Investment Date',
                          style: GoogleFonts.hindSiliguri(fontSize: 11, color: palette.inkSecondary),
                        ),
                        Text(
                          '05 September 2026',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: palette.ink),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C853).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isBangla ? 'সক্রিয়' : 'Active',
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF00C853),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Button: View Transactions
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TransactionsScreen(state: state)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    isBangla ? 'লেনদেন দেখুন' : 'View Transactions',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCol(String label, String value, bool isBangla, {bool isProfit = false}) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.hindSiliguri(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isProfit ? const Color(0xFF00E676) : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildShareItem(String title, String date, String amount, AppPalette palette) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.rule, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0066FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.token_rounded, size: 18, color: Color(0xFF0066FF)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: palette.ink),
                  ),
                  Text(
                    date,
                    style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary),
                  ),
                ],
              ),
            ],
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: palette.ink),
          ),
        ],
      ),
    );
  }
}
