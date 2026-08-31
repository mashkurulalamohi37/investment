import 'package:flutter/material.dart';
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
        actions: [
          TextButton(
            onPressed: () => setState(() => _isBangla = !_isBangla),
            child: Text(
              _isBangla ? 'EN' : 'বাং',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: palette.pine),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                _isBangla ? 'বিনিয়োগকারী হিসাব প্রবেশ' : 'Sign In to Your Portfolio',
                style: AppTypography.titleLarge(isDark: isDark, isBangla: _isBangla).copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _isBangla
                    ? 'আপনার নিবন্ধিত মোবাইল নম্বরে ওটিপি যাচাইকরণ কোড পাঠানো হবে।'
                    : 'A 6-digit verification code will be sent to your registered mobile number.',
                style: AppTypography.body(isDark: isDark, isBangla: _isBangla).copyWith(
                  color: palette.inkSecondary,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 32),

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
                          fontWeight: FontWeight.w600,
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '1XXXXXXXXX',
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
                // OTP as 6 Ruled Boxes at Radius 2 (§10)
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
                        borderRadius: AppRadius.borderChip, // Radius 2
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
                      _isBangla ? 'নম্বর পরিবর্তন করুন' : 'Change Phone Number',
                      style: TextStyle(color: palette.inkSecondary, fontSize: 12),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 36),
              const Divider(height: 1),
              const SizedBox(height: 24),

              // Sample Data Entry (Quiet Button, not a glowing AI demo button)
              Center(
                child: Column(
                  children: [
                    Text(
                      _isBangla ? 'পরীক্ষামূলক নমুনা তথ্য দিয়ে দেখুন' : 'Developer & Sandbox Access',
                      style: AppTypography.caption(isDark: isDark, isBangla: _isBangla).copyWith(
                        color: palette.inkTertiary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppButton(
                      label: _isBangla ? 'বিনিয়োগকারী নমুনা পোর্টফোলিও' : 'Explore with Sample Investor Data',
                      variant: AppButtonVariant.quiet,
                      isBangla: _isBangla,
                      onPressed: () => _verifyOtp(state, asAdmin: false),
                    ),
                    const SizedBox(height: 4),
                    AppButton(
                      label: _isBangla ? 'প্রশাসক ব্যবস্থাপনা কনসোল' : 'Open Admin Management Console',
                      variant: AppButtonVariant.quiet,
                      isBangla: _isBangla,
                      onPressed: () => _verifyOtp(state, asAdmin: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
