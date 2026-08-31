import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/status_chip.dart';
import 'package:swapnojatri/data/models/user_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/kyc/kyc_screen.dart';
import 'package:swapnojatri/features/investor/document_vault/document_vault_screen.dart';
import 'package:swapnojatri/features/investor/support/support_screen.dart';
import 'package:swapnojatri/features/investor/transparency/transparency_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AppState state;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.state,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final user = state.currentUser;
    final kyc = state.kyc;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'বিনিয়োগকারী প্রোফাইল ও সেটিংস' : 'Investor Profile & Settings',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: AppRadius.borderXl,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user.avatarUrl),
                    backgroundColor: AppColors.primarySubtle,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla).copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.phone,
                          style: AppTypography.bodySmall(isDark: isDark).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        StatusChip.kyc(kyc.status, isBangla: isBangla),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Role Switcher Highlight Card (Switch to Admin)
            InkWell(
              onTap: () {
                state.switchRole(UserRole.admin);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isBangla
                          ? 'অ্যাডমিন কনসোলে স্যুইচ করা হয়েছে (তানভীর আহমেদ)'
                          : 'Switched to Admin Management Console (Tanvir Ahmed)',
                    ),
                    backgroundColor: AppColors.accentGoldDark,
                  ),
                );
              },
              borderRadius: AppRadius.borderLg,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? const LinearGradient(colors: [Color(0xFF261D0A), Color(0xFF140F05)])
                      : const LinearGradient(colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)]),
                  borderRadius: AppRadius.borderLg,
                  border: Border.all(
                    color: AppColors.accentGold.withValues(alpha: 0.6),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.accentGold.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.admin_panel_settings_rounded, color: AppColors.accentGoldDark, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBangla ? 'অ্যাডমিন কনসোলে প্রবেশ করুন' : 'Switch to Admin Management Console',
                            style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: isDark ? AppColors.accentGoldLight : const Color(0xFF92400E),
                            ),
                          ),
                          Text(
                            isBangla
                                ? 'পেমেন্ট যাচাই, শেয়ার লট বরাদ্দ, ভাউচার অনুমোদন ও অডিট ট্রেইল'
                                : 'Manage payments, share lot allocations, expenses & audit logs',
                            style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.swap_horiz_rounded, color: AppColors.accentGoldDark),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Settings Group 1: Identity & Compliance
            _sectionTitle(isBangla ? 'পরিচয় ও কমপ্লায়েন্স' : 'Identity & Compliance', isDark, isBangla),
            const SizedBox(height: 8),

            _settingsTile(
              icon: Icons.verified_user_outlined,
              title: isBangla ? 'কেওয়াইসি যাচাইকরণ' : 'KYC Verification',
              subtitle: isBangla ? 'এনআইডি ও ব্যাংক তথ্য' : 'NID & Bank Details',
              trailing: StatusChip.kyc(kyc.status, isBangla: isBangla),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KycScreen(state: state)),
                );
              },
              isDark: isDark,
              isBangla: isBangla,
            ),
            _settingsTile(
              icon: Icons.folder_shared_outlined,
              title: isBangla ? 'দলিল ও রসিদ ভল্ট' : 'Document Vault',
              subtitle: isBangla ? 'মালিকানা দলিল ও শেয়ার সার্টিফিকেট' : 'Deeds & Certificates',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DocumentVaultScreen(state: state)),
                );
              },
              isDark: isDark,
              isBangla: isBangla,
            ),
            _settingsTile(
              icon: Icons.query_stats_rounded,
              title: isBangla ? 'তহবিল স্বচ্ছতা ড্যাশবোর্ড' : 'Fund Transparency',
              subtitle: isBangla ? 'প্রকল্পের আয়-ব্যয় অডিট' : 'Project Expenses & Ledger',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransparencyScreen(state: state)),
                );
              },
              isDark: isDark,
              isBangla: isBangla,
            ),

            const SizedBox(height: 20),

            // Settings Group 2: App Preferences
            _sectionTitle(isBangla ? 'অ্যাপ পছন্দসমূহ' : 'Preferences', isDark, isBangla),
            const SizedBox(height: 8),

            _settingsTile(
              icon: Icons.language_rounded,
              title: isBangla ? 'ভাষা (Language)' : 'App Language',
              subtitle: isBangla ? 'বাংলা (Bangla First)' : 'English',
              trailing: Switch.adaptive(
                value: isBangla,
                activeColor: isDark ? AppColors.accentGold : AppColors.primary,
                onChanged: (_) => state.toggleLanguage(),
              ),
              onTap: () => state.toggleLanguage(),
              isDark: isDark,
              isBangla: isBangla,
            ),
            _settingsTile(
              icon: Icons.dark_mode_outlined,
              title: isBangla ? 'ডার্ক মোড' : 'Dark Mode',
              subtitle: isDark ? 'Dark Theme' : 'Light Theme',
              trailing: Switch.adaptive(
                value: isDark,
                activeColor: isDark ? AppColors.accentGold : AppColors.primary,
                onChanged: (_) => state.toggleTheme(),
              ),
              onTap: () => state.toggleTheme(),
              isDark: isDark,
              isBangla: isBangla,
            ),
            _settingsTile(
              icon: Icons.help_outline_rounded,
              title: isBangla ? 'হেল্প ও সাপোর্ট' : 'Help & Support',
              subtitle: isBangla ? 'সচরাচর জিজ্ঞাসা ও যোগাযোগ' : 'FAQs & Customer Desk',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportScreen(state: state)),
                );
              },
              isDark: isDark,
              isBangla: isBangla,
            ),

            const SizedBox(height: 24),

            // Logout Button
            InkWell(
              onTap: onLogout,
              borderRadius: AppRadius.borderMd,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.errorLight.withValues(alpha: isDark ? 0.15 : 0.6),
                  borderRadius: AppRadius.borderMd,
                  border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout_rounded, color: AppColors.error, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      isBangla ? 'লগআউট করুন' : 'Log Out',
                      style: AppTypography.headingSmall(isBangla: isBangla).copyWith(
                        color: AppColors.error,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, bool isDark, bool isBangla) {
    return Text(
      title,
      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
    required bool isDark,
    required bool isBangla,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: AppRadius.borderMd,
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: isDark ? AppColors.accentGoldLight : AppColors.primary, size: 22),
        title: Text(
          title,
          style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle, style: AppTypography.caption(isDark: isDark, isBangla: isBangla)),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.lightTextMuted),
        onTap: onTap,
      ),
    );
  }
}
