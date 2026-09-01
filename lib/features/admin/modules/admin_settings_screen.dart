import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/models/user_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/admin/modules/audit_logs_screen.dart';

class AdminSettingsScreen extends StatelessWidget {
  final AppState state;
  final VoidCallback? onLogout;

  const AdminSettingsScreen({
    super.key,
    required this.state,
    this.onLogout,
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
        title: Text(
          isBangla ? 'সেটিংস' : 'Admin Settings',
          style: GoogleFonts.hindSiliguri(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: General Settings
              Text(
                isBangla ? 'সাধারণ সেটিংস' : 'General Settings',
                style: GoogleFonts.hindSiliguri(fontSize: 13, fontWeight: FontWeight.w600, color: palette.inkSecondary),
              ),
              const SizedBox(height: 10),

              _buildSettingsTile(Icons.person_outline_rounded, isBangla ? 'প্রোফাইল সেটিংস' : 'Profile Settings', palette),
              _buildSettingsTile(Icons.settings_outlined, isBangla ? 'সিস্টেম সেটিংস' : 'System Settings', palette),
              _buildSettingsTile(Icons.notifications_none_rounded, isBangla ? 'নোটিফিকেশন সেটিংস' : 'Notifications Settings', palette),
              _buildSettingsTile(Icons.verified_user_outlined, isBangla ? 'KYC সেটিংস' : 'KYC Settings', palette),
              _buildSettingsTile(Icons.payment_rounded, isBangla ? 'পেমেন্ট সেটিংস' : 'Payment Settings', palette),
              const SizedBox(height: 24),

              // Section 2: System Management
              Text(
                isBangla ? 'সিস্টেম ম্যানেজমেন্ট' : 'System Management',
                style: GoogleFonts.hindSiliguri(fontSize: 13, fontWeight: FontWeight.w600, color: palette.inkSecondary),
              ),
              const SizedBox(height: 10),

              _buildSettingsTile(Icons.manage_accounts_outlined, isBangla ? 'অ্যাডমিন ম্যানেজার' : 'Admin Management', palette),
              _buildSettingsTile(
                Icons.receipt_long_outlined,
                isBangla ? 'অ্যাক্টিভিটি ও অডিট লগ' : 'Activity & Audit Logs',
                palette,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminAuditLogsScreen(state: state)),
                  );
                },
              ),
              _buildSettingsTile(Icons.cloud_sync_outlined, isBangla ? 'ব্যাকআপ ও রিস্টোর' : 'Backup & Restore', palette),
              _buildSettingsTile(Icons.security_outlined, isBangla ? 'সিকিউরিটি সেটিংস' : 'Security Settings', palette),
              const SizedBox(height: 16),

              // Switch to Investor Role
              _buildSettingsTile(
                Icons.swap_horiz_rounded,
                isBangla ? 'ইনভেস্টর অ্যাপে স্যুইচ করুন' : 'Switch to Investor App',
                palette,
                isHighlight: true,
                onTap: () => state.switchRole(UserRole.investor),
              ),
              const SizedBox(height: 20),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: onLogout,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    isBangla ? 'লগআউট' : 'Log Out',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    IconData icon,
    String title,
    AppPalette palette, {
    VoidCallback? onTap,
    bool isHighlight = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isHighlight ? const Color(0xFF0066FF).withValues(alpha: 0.08) : palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlight ? const Color(0xFF0066FF).withValues(alpha: 0.3) : palette.rule,
          width: 1.0,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        leading: Icon(icon, size: 20, color: isHighlight ? const Color(0xFF0066FF) : palette.ink),
        title: Text(
          title,
          style: GoogleFonts.hindSiliguri(
            fontSize: 13.5,
            fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
            color: isHighlight ? const Color(0xFF0066FF) : palette.ink,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: palette.inkTertiary),
      ),
    );
  }
}
