import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/admin/modules/kyc_approvals_screen.dart';

class AdminProjectDetailScreen extends StatelessWidget {
  final ProjectModel project;
  final AppState state;

  const AdminProjectDetailScreen({
    super.key,
    required this.project,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = state.isBangla;
    final progress = (project.allocatedShares / project.totalShares).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isBangla ? 'প্রজেক্ট বিবরণী (অ্যাডমিন)' : 'Project Details (Admin)',
          style: GoogleFonts.hindSiliguri(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          project.name,
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: palette.ink),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C853).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isBangla ? 'সক্রিয়' : 'Active',
                            style: GoogleFonts.hindSiliguri(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF00C853)),
                          ),
                        ),
                      ],
                    ),
                    Text(project.location, style: GoogleFonts.poppins(fontSize: 12, color: palette.inkSecondary)),
                    const SizedBox(height: 14),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('৳ 18,36,000 / ৳ 25,50,000', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: palette.ink)),
                        Text('${(progress * 100).toInt()}%', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0066FF))),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: palette.surfaceSunken,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0066FF)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // KPI Grid (Admin View)
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.2,
                children: [
                  _buildMetric('মোট শেয়ার', '${project.totalShares}', palette),
                  _buildMetric('বরাদ্দকৃত শেয়ার', '${project.allocatedShares}', palette),
                  _buildMetric('প্রতি শেয়ার মূল্য', '৳ 25,500', palette),
                  _buildMetric('মোট ইনভেস্টর', '24 জন', palette),
                ],
              ),
              const SizedBox(height: 24),

              // Investors in this Project
              Text(
                isBangla ? 'এই প্রজেক্টের বিনিয়োগকারী' : 'Project Investors',
                style: GoogleFonts.hindSiliguri(fontSize: 15, fontWeight: FontWeight.w700, color: palette.ink),
              ),
              const SizedBox(height: 10),

              _buildInvestorRow('Krishna Saha', '3 Shares (৳ 76,500)', 'Verified', palette),
              const SizedBox(height: 8),
              _buildInvestorRow('Rahim Ahmed', '2 Shares (৳ 51,000)', 'Verified', palette),
              const SizedBox(height: 8),
              _buildInvestorRow('Tanvir Hasan', '1 Share (৳ 25,500)', 'Pending', palette),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminKycApprovalsScreen(state: state)),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF0066FF)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        isBangla ? 'ভেরিফিকেশন' : 'Verifications',
                        style: GoogleFonts.hindSiliguri(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF0066FF)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isBangla ? 'প্রজেক্ট আপডেট মোড সক্রিয়' : 'Project edit mode opened'),
                            backgroundColor: const Color(0xFF0066FF),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0066FF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        isBangla ? 'সম্পাদনা করুন' : 'Edit Project',
                        style: GoogleFonts.hindSiliguri(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
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

  Widget _buildMetric(String label, String value, AppPalette palette) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.rule, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: GoogleFonts.hindSiliguri(fontSize: 11, color: palette.inkSecondary)),
          const SizedBox(height: 2),
          Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: palette.ink)),
        ],
      ),
    );
  }

  Widget _buildInvestorRow(String name, String shares, String status, AppPalette palette) {
    final isVerified = status == 'Verified';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: palette.rule, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: palette.ink)),
              Text(shares, style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isVerified ? const Color(0xFF00C853).withValues(alpha: 0.1) : const Color(0xFFF59E0B).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: isVerified ? const Color(0xFF00C853) : const Color(0xFFF59E0B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
