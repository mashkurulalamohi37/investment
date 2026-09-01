import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/admin/modules/admin_chat_screen.dart';

class AdminUserManageScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userStatus;
  final bool isVerified;
  final AppState state;

  const AdminUserManageScreen({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userStatus,
    required this.isVerified,
    required this.state,
  });

  static void show({
    required BuildContext context,
    required String userName,
    required String userEmail,
    required String userStatus,
    required bool isVerified,
    required AppState state,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AdminUserManageScreen(
        userName: userName,
        userEmail: userEmail,
        userStatus: userStatus,
        isVerified: isVerified,
        state: state,
      ),
    );
  }

  @override
  State<AdminUserManageScreen> createState() => _AdminUserManageScreenState();
}

class _AdminUserManageScreenState extends State<AdminUserManageScreen> {
  late bool _verified;
  late String _status;
  bool _isSuspended = false;

  @override
  void initState() {
    super.initState();
    _verified = widget.isVerified;
    _status = widget.userStatus;
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: palette.ruleStrong,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // User Header Card
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF0066FF).withValues(alpha: 0.1),
                child: Text(
                  widget.userName.isNotEmpty ? widget.userName[0] : 'U',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0066FF),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.userName,
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: palette.ink,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: _verified
                                ? const Color(0xFF00C853).withValues(alpha: 0.1)
                                : const Color(0xFFF59E0B).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _status,
                            style: GoogleFonts.hindSiliguri(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: _verified ? const Color(0xFF00C853) : const Color(0xFFF59E0B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.userEmail,
                      style: GoogleFonts.poppins(fontSize: 12, color: palette.inkSecondary),
                    ),
                    Text(
                      '01812-345678 • সদস্য আইডি: #SJ-USR-8821',
                      style: GoogleFonts.poppins(fontSize: 11, color: palette.inkTertiary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // User Investment Stats Grid
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: palette.surfaceSunken,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: palette.rule, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('মোট বিনিয়োগ', '৳ 76,500', palette),
                Container(width: 1, height: 32, color: palette.ruleStrong),
                _buildStat('সক্রিয় শেয়ার', '3 Shares', palette),
                Container(width: 1, height: 32, color: palette.ruleStrong),
                _buildStat('প্রকল্প', 'LandVest 100', palette),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Management Actions Header
          Text(
            isBangla ? 'ব্যবহারকারী ব্যবস্থাপনা অ্যাকশন' : 'User Management Actions',
            style: GoogleFonts.hindSiliguri(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: palette.ink,
            ),
          ),
          const SizedBox(height: 12),

          // 1. KYC Approval / Revoke Button
          _buildActionTile(
            icon: _verified ? Icons.verified_user_rounded : Icons.pending_actions_rounded,
            iconColor: _verified ? const Color(0xFF00C853) : const Color(0xFFF59E0B),
            title: _verified
                ? (isBangla ? 'KYC ভেরিফিকেশন সক্রিয় রয়েছে' : 'KYC Verified (Click to Revoke)')
                : (isBangla ? 'KYC অনুমোদন করুন (Approve KYC)' : 'Approve User KYC'),
            subtitle: _verified
                ? (isBangla ? 'এনআইডি ও ডকুমেন্টস যাচাইকৃত' : 'NID & documents verified')
                : (isBangla ? 'পেন্ডিং ডকুমেন্টস অনুমোদন করুন' : 'Review & grant verified status'),
            palette: palette,
            onTap: () {
              setState(() {
                _verified = !_verified;
                _status = _verified ? (isBangla ? 'সক্রিয়' : 'Active') : (isBangla ? 'পেন্ডিং' : 'Pending');
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _verified
                        ? (isBangla ? '${widget.userName} এর KYC অনুমোদিত হয়েছে!' : '${widget.userName} KYC Approved!')
                        : (isBangla ? 'KYC স্ট্যাটাস পেন্ডিং করা হয়েছে।' : 'KYC set to Pending.'),
                  ),
                  backgroundColor: _verified ? const Color(0xFF00C853) : const Color(0xFFF59E0B),
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          // 2. Suspend / Block User
          _buildActionTile(
            icon: _isSuspended ? Icons.lock_open_rounded : Icons.block_rounded,
            iconColor: _isSuspended ? const Color(0xFF0066FF) : const Color(0xFFEF4444),
            title: _isSuspended
                ? (isBangla ? 'একাউন্ট আনব্লক করুন' : 'Unblock Account')
                : (isBangla ? 'একাউন্ট সাসপেন্ড / ব্লক করুন' : 'Suspend / Block User'),
            subtitle: _isSuspended
                ? (isBangla ? 'ব্যবহারকারী পুনরায় প্ল্যাটফর্মে লগইন করতে পারবে' : 'Restore user access')
                : (isBangla ? 'সাময়িকভাবে লেনদেন ও লগইন বন্ধ করুন' : 'Restrict trading & access'),
            palette: palette,
            onTap: () {
              setState(() {
                _isSuspended = !_isSuspended;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isSuspended
                        ? (isBangla ? '${widget.userName} কে ব্লক করা হয়েছে' : '${widget.userName} suspended')
                        : (isBangla ? '${widget.userName} এর একাউন্ট সক্রিয় করা হয়েছে' : '${widget.userName} unblocked'),
                  ),
                  backgroundColor: _isSuspended ? const Color(0xFFEF4444) : const Color(0xFF0066FF),
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          // 3. Send Message Option
          _buildActionTile(
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: const Color(0xFF0066FF),
            title: isBangla ? 'ব্যবহারকারীকে মেসেজ পাঠান' : 'Send Message to User',
            subtitle: isBangla ? 'সরাসরি চ্যাটে যোগাযোগ করুন' : 'Open live support chat',
            palette: palette,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminChatScreen(state: widget.state)),
              );
            },
          ),
          const SizedBox(height: 16),

          // Close Button
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: palette.ruleStrong),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isBangla ? 'বন্ধ করুন' : 'Close',
                style: GoogleFonts.hindSiliguri(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: palette.ink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, AppPalette palette) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.hindSiliguri(fontSize: 11, color: palette.inkSecondary)),
        const SizedBox(height: 2),
        Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: palette.ink)),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required AppPalette palette,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: palette.rule, width: 1.0),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: palette.ink,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 11,
                      color: palette.inkSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 18, color: palette.inkTertiary),
          ],
        ),
      ),
    );
  }
}
