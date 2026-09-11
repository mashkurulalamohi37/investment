import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/status_chip.dart';
import 'package:swapnojatri/core/widgets/matra_rule_widget.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/data/models/user_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/kyc/kyc_screen.dart';
import 'package:swapnojatri/features/investor/document_vault/document_vault_screen.dart';
import 'package:swapnojatri/features/investor/support/support_screen.dart';
import 'package:swapnojatri/features/investor/transparency/transparency_screen.dart';
import 'package:swapnojatri/features/investor/portfolio/withdrawals_history_screen.dart';
import 'package:swapnojatri/features/investor/profit_distribution/profit_distribution_screen.dart';
import 'package:swapnojatri/core/constants/app_config.dart';

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
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final user = state.currentUser;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'বিনিয়োগকারী প্রোফাইল' : 'Investor Profile',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderCard,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(user.avatarUrl),
                      backgroundColor: palette.surfaceSunken,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user.phone,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                              color: palette.inkSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          StatusChip(
                            rawStatus: 'Verified',
                            isBangla: isBangla,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Switch to Admin Console Bar
              InkWell(
                onTap: () {
                  state.switchRole(UserRole.admin);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isBangla
                            ? 'অ্যাডমিন কনসোলে স্যুইচ করা হয়েছে'
                            : 'Switched to Admin Management Console',
                      ),
                      backgroundColor: palette.pine,
                    ),
                  );
                },
                borderRadius: AppRadius.borderCard,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: palette.surfaceSunken,
                    borderRadius: AppRadius.borderCard,
                    border: Border.all(color: palette.ruleStrong, width: 1.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.admin_panel_settings_outlined, size: 20, color: palette.pine),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isBangla ? 'প্রশাসক কনসোল ভিউ' : 'Switch to Admin Console',
                              style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              isBangla ? 'পেমেন্ট ভেরিফিকেশন ও লট বরাদ্দ ব্যবস্থাপনা' : 'Manage payment verification & sequential share lots',
                              style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                                color: palette.inkSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded, size: 16, color: palette.inkTertiary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Account & Compliance Sections
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Text(
                isBangla ? 'অ্যাকাউন্ট ও নিরাপত্তা' : 'Account & Verification',
                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderCard,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  children: [
                    _profileNavRow(
                      icon: Icons.verified_user_outlined,
                      title: isBangla ? 'কেওয়াইসি পরিচিতি যাচাই' : 'KYC Compliance Status',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => KycScreen(state: state)));
                      },
                    ),
                    _profileNavRow(
                      icon: Icons.account_balance_wallet_outlined,
                      title: isBangla ? 'তহবিল উত্তোলন ও প্রস্থান অনুরোধ' : 'Payment Withdrawals & Settlements',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WithdrawalsHistoryScreen(state: state)));
                      },
                    ),
                    _profileNavRow(
                      icon: Icons.payments_outlined,
                      title: isBangla ? 'লভ্যাংশ বণ্টন ও নিষ্পত্তি' : 'Profit Distribution History',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfitDistributionScreen(state: state)));
                      },
                    ),
                    _profileNavRow(
                      icon: Icons.receipt_long_outlined,
                      title: isBangla ? 'তহবিল স্বচ্ছতা ও ব্যয়ের হিসাব' : 'Fund Transparency Ledger',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TransparencyScreen(state: state)));
                      },
                    ),
                    _profileNavRow(
                      icon: Icons.folder_outlined,
                      title: isBangla ? 'আইনি ও দলিল ভল্ট' : 'Document & Title Vault',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentVaultScreen(state: state)));
                      },
                    ),
                    _profileNavRow(
                      icon: Icons.headset_mic_outlined,
                      title: isBangla ? 'সহায়তা ও গ্রাহক সেবা' : 'Customer Support & Inquiries',
                      palette: palette,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SupportScreen(state: state)));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Cloud Backend & CMS Connection Section
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla ? 'অনলাইন ক্লাউড ও সিএমএস সিঙ্ক' : 'Cloud Backend & CMS Live Sync',
                    style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: state.isWebsiteConnected
                          ? const Color(0xFF10B981).withValues(alpha: 0.12)
                          : const Color(0xFFEF4444).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: state.isWebsiteConnected
                            ? const Color(0xFF10B981).withValues(alpha: 0.3)
                            : const Color(0xFFEF4444).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state.isWebsiteConnected ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          state.isWebsiteConnected
                              ? (isBangla ? 'অনলাইন ক্লাউড' : 'Online Vercel')
                              : (isBangla ? 'অফলাইন ক্যাশ' : 'Offline Mode'),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: state.isWebsiteConnected ? const Color(0xFF059669) : const Color(0xFFDC2626),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderCard,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.cloud_done_rounded, color: palette.pine, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBangla ? 'লাইভ ক্লাউড ব্যাকএন্ড ডিপ্লয়মেন্ট' : 'Live Production Deployment',
                                style: AppTypography.bodyStrong(isDark: isDark).copyWith(fontSize: 13),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                AppConfig.activeApiUrl,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: Color(0xFF0066FF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.lastSyncedAt != null
                              ? (isBangla
                                  ? 'সর্বশেষ সিঙ্ক: ${state.lastSyncedAt!.hour.toString().padLeft(2, '0')}:${state.lastSyncedAt!.minute.toString().padLeft(2, '0')}'
                                  : 'Last Sync: ${state.lastSyncedAt!.hour.toString().padLeft(2, '0')}:${state.lastSyncedAt!.minute.toString().padLeft(2, '0')}')
                              : (isBangla ? 'সিঙ্ক করা প্রয়োজন' : 'Sync needed'),
                          style: TextStyle(fontSize: 11, color: palette.inkSecondary),
                        ),
                        InkWell(
                          onTap: state.isSyncing
                              ? null
                              : () async {
                                  await state.syncWithWebsite();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          state.isWebsiteConnected
                                              ? (isBangla
                                                  ? 'অনলাইন ক্লাউড ডাটা সফলভাবে সিঙ্ক হয়েছে'
                                                  : 'Live cloud data synced with Vercel backend!')
                                              : (isBangla
                                                  ? 'ক্লাউড ব্যাকএন্ডে সংযোগ স্থাপন করা সম্ভব হয়নি'
                                                  : 'Could not connect to online backend'),
                                        ),
                                        backgroundColor: state.isWebsiteConnected
                                            ? const Color(0xFF059669)
                                            : const Color(0xFFDC2626),
                                      ),
                                    );
                                  }
                                },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: palette.pine.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: palette.pine.withValues(alpha: 0.2)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (state.isSyncing)
                                  const SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                else
                                  Icon(Icons.sync_rounded, size: 14, color: palette.pine),
                                const SizedBox(width: 6),
                                Text(
                                  state.isSyncing
                                      ? (isBangla ? 'সিঙ্ক হচ্ছে...' : 'Syncing...')
                                      : (isBangla ? 'এখনই সিঙ্ক করুন' : 'Sync Now'),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: palette.pine,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Preferences Section (Language & Theme)
              MatraRuleWidget(width: 32, color: palette.pine),
              const SizedBox(height: 8),
              Text(
                isBangla ? 'ভাষা ও থিম পছন্দ' : 'Language & Display Theme',
                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderCard,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text(
                        isBangla ? 'বাংলা ভাষা (Bangla-First)' : 'English Language',
                        style: AppTypography.bodyStrong(isDark: isDark),
                      ),
                      subtitle: Text(
                        isBangla ? 'বাংলা ও ইংরেজি দ্রুত পরিবর্তন করুন' : 'Toggle between Bengali and English',
                        style: AppTypography.caption(isDark: isDark),
                      ),
                      value: isBangla,
                      activeColor: palette.pine,
                      onChanged: (val) => state.toggleLanguage(),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: Text(
                        isBangla ? 'ডার্ক মোড (Night Ledger)' : 'Dark Theme (Night Ledger)',
                        style: AppTypography.bodyStrong(isDark: isDark),
                      ),
                      subtitle: Text(
                        isBangla ? 'রাতের ব্যবহারের জন্য ডার্ক থিম' : 'High contrast dark palette',
                        style: AppTypography.caption(isDark: isDark),
                      ),
                      value: isDark,
                      activeColor: palette.pine,
                      onChanged: (val) => state.toggleTheme(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Logout Action
              AppButton(
                label: isBangla ? 'হিসাব থেকে প্রস্থান করুন' : 'Sign Out of Account',
                variant: AppButtonVariant.destructive,
                isBangla: isBangla,
                onPressed: onLogout,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileNavRow({
    required IconData icon,
    required String title,
    required AppPalette palette,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: palette.pine),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTypography.bodyStrong(isDark: isDark).copyWith(fontSize: 13),
                ),
              ],
            ),
            Icon(Icons.chevron_right_rounded, size: 16, color: palette.inkTertiary),
          ],
        ),
      ),
    );
  }
}
