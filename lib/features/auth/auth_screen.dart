import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/main_layout.dart';
import 'package:swapnojatri/features/admin/admin_layout.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneController = TextEditingController(text: '1712345678');
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController(text: '${index + 1}'));
  final List<FocusNode> _otpFocusNodes = List.generate(6, (index) => FocusNode());

  bool _isOtpSent = false;
  bool _isLoading = false;
  bool _isBangla = true;

  @override
  void dispose() {
    _phoneController.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _sendOtp() {
    HapticFeedback.selectionClick();
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isOtpSent = true;
        });
      }
    });
  }

  void _verifyOtp(AppState state, {bool asAdmin = false}) {
    HapticFeedback.selectionClick();
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _isLoading = false);
        if (asAdmin) {
          state.switchUser('usr-002'); // Admin
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminLayout(state: state)),
          );
        } else {
          state.switchUser('usr-001'); // Rahim
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainLayout(state: state)),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, size: 20, color: palette.ink),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Language Switcher Chip
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _isBangla = !_isBangla);
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: palette.ruleStrong, width: 1.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.language_rounded, size: 13, color: palette.pine),
                    const SizedBox(width: 4),
                    Text(
                      _isBangla ? 'English' : 'বাংলা',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: palette.pine,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Crest & Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: palette.pine,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: palette.brass, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'স্ব',
                      style: TextStyle(
                        fontFamily: 'serif',
                        color: palette.brass,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isBangla ? 'স্বপ্নযাত্রী ইনভেস্টমেন্ট' : 'SWAPNOJATRI',
                        style: AppTypography.titleLarge(isDark: isDark, isBangla: _isBangla).copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        _isBangla ? 'সুরক্ষিত ভূমি পোর্টফোলিও হিসাব' : 'Institutional Land Portfolio',
                        style: AppTypography.caption(isDark: isDark, isBangla: _isBangla).copyWith(
                          color: palette.inkSecondary,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Title Section
              Text(
                _isBangla ? 'পোর্টফোলিওতে প্রবেশ করুন' : 'Sign In to Your Portfolio',
                style: AppTypography.titleLarge(isDark: isDark, isBangla: _isBangla).copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _isBangla
                    ? 'আপনার নিবন্ধিত মোবাইল নম্বরে ওটিপি যাচাইকরণ কোড পাঠানো হবে।'
                    : 'A 6-digit verification code will be sent to your registered mobile number.',
                style: AppTypography.body(isDark: isDark, isBangla: _isBangla).copyWith(
                  color: palette.inkSecondary,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 28),

              // Phone Field with +880 Prefix in a Sunken Well
              Text(
                _isBangla ? 'মোবাইল নম্বর' : 'Mobile Number',
                style: AppTypography.sectionLabel(isDark: isDark, isBangla: _isBangla).copyWith(
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderControl,
                  border: Border.all(color: palette.ruleStrong, width: 1.0),
                ),
                child: Row(
                  children: [
                    // Sunken +880 Prefix
                    Container(
                      width: 64,
                      height: 48,
                      decoration: BoxDecoration(
                        color: palette.surfaceSunken,
                        border: Border(right: BorderSide(color: palette.rule, width: 1.0)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '+880',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          color: palette.inkSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        enabled: !_isOtpSent,
                        style: AppTypography.bodyStrong(isDark: isDark).copyWith(letterSpacing: 0.5),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '1XXXXXXXXX',
                          hintStyle: TextStyle(color: palette.inkTertiary),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              if (!_isOtpSent) ...[
                AppButton(
                  label: _isBangla ? 'যাচাইকরণ কোড পাঠান' : 'Send Verification Code',
                  variant: AppButtonVariant.primary,
                  isLoading: _isLoading,
                  isBangla: _isBangla,
                  onPressed: _sendOtp,
                ),
              ] else ...[
                // OTP as 6 Ruled Boxes
                Text(
                  _isBangla ? '৬ সংখ্যার ওটিপি কোড' : '6-Digit OTP Code',
                  style: AppTypography.sectionLabel(isDark: isDark, isBangla: _isBangla).copyWith(
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 44,
                      height: 48,
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: AppRadius.borderChip,
                        border: Border.all(color: palette.ruleStrong, width: 1.0),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _otpFocusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: AppTypography.amountMedium(isDark: isDark).copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          onChanged: (val) {
                            if (val.isNotEmpty && index < 5) {
                              _otpFocusNodes[index + 1].requestFocus();
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                AppButton(
                  label: _isBangla ? 'যাচাই করে প্রবেশ করুন' : 'Verify & Continue',
                  variant: AppButtonVariant.primary,
                  isLoading: _isLoading,
                  isBangla: _isBangla,
                  onPressed: () => _verifyOtp(state),
                ),
                const SizedBox(height: 8),

                Center(
                  child: TextButton(
                    onPressed: () => setState(() => _isOtpSent = false),
                    child: Text(
                      _isBangla ? 'মোবাইল নম্বর পরিবর্তন করুন' : 'Change Phone Number',
                      style: TextStyle(color: palette.inkSecondary, fontSize: 12),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 32),
              const Divider(height: 1),
              const SizedBox(height: 20),

              // Instant Sandbox Mode Quick Selectors
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shield_outlined, size: 14, color: palette.pine),
                        const SizedBox(width: 6),
                        Text(
                          _isBangla ? 'নমুনা পরিবেশ অ্যাক্সেস' : 'Instant Sandbox Access',
                          style: AppTypography.caption(isDark: isDark, isBangla: _isBangla).copyWith(
                            color: palette.inkSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () => _verifyOtp(state, asAdmin: false),
                      borderRadius: AppRadius.borderControl,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: palette.surface,
                          borderRadius: AppRadius.borderControl,
                          border: Border.all(color: palette.ruleStrong, width: 1.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(color: palette.pine, shape: BoxShape.circle),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isBangla ? 'বিনিয়োগকারী পোর্টাল (রহিম চৌধুরী)' : 'Investor Portal (Rahim Chowdhury)',
                                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: palette.ink),
                                    ),
                                    Text(
                                      _isBangla ? '৪টি অংশ • ৳ ১,০২,০০০ বিনিয়োগ' : '4 Shares • ৳ 1,02,000 Invested',
                                      style: TextStyle(fontSize: 11, color: palette.inkSecondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(Icons.chevron_right_rounded, size: 18, color: palette.inkSecondary),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _verifyOtp(state, asAdmin: true),
                      borderRadius: AppRadius.borderControl,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: palette.surface,
                          borderRadius: AppRadius.borderControl,
                          border: Border.all(color: palette.ruleStrong, width: 1.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(color: palette.brass, shape: BoxShape.circle),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isBangla ? 'প্রশাসক কনসোল (তানভীর আহমেদ)' : 'Admin Console (Tanvir Ahmed)',
                                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: palette.ink),
                                    ),
                                    Text(
                                      _isBangla ? 'তহবিল ও ব্যয় ভাউচার অনুমোদন' : 'Fund & Expense Approval',
                                      style: TextStyle(fontSize: 11, color: palette.inkSecondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(Icons.chevron_right_rounded, size: 18, color: palette.inkSecondary),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
