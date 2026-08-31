import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/data/models/user_model.dart';

class AuthScreen extends StatefulWidget {
  final Function(UserRole role) onAuthSuccess;
  final bool isBangla;

  const AuthScreen({
    super.key,
    required this.onAuthSuccess,
    this.isBangla = true,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneController = TextEditingController(text: '01712-345678');
  final List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  bool _isOtpStep = false;
  int _resendTimerSeconds = 59;
  Timer? _timer;
  bool _isLoading = false;

  void _startTimer() {
    _resendTimerSeconds = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimerSeconds > 0) {
        setState(() => _resendTimerSeconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  void _requestOtp() {
    if (_phoneController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isOtpStep = true;
        });
        _startTimer();
        // Prefill demo OTP
        _otpControllers[0].text = '7';
        _otpControllers[1].text = '4';
        _otpControllers[2].text = '9';
        _otpControllers[3].text = '1';
      }
    });
  }

  void _verifyOtp() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() => _isLoading = false);
        widget.onAuthSuccess(UserRole.investor);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _phoneController.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Back button if in OTP step
              if (_isOtpStep)
                IconButton(
                  onPressed: () {
                    _timer?.cancel();
                    setState(() => _isOtpStep = false);
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                )
              else
                const SizedBox(height: 48),

              // Brand Emblem
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.goldGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentGold.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.account_balance_rounded, color: AppColors.primaryDark, size: 28),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                _isOtpStep
                    ? (widget.isBangla ? 'ওটিপি কোড যাচাই' : 'Verify OTP Code')
                    : (widget.isBangla ? 'স্বপ্নযাত্রীতে স্বাগতম' : 'Welcome to Swapnojatri'),
                style: AppTypography.displayMedium(isDark: isDark, isBangla: widget.isBangla),
              ),
              const SizedBox(height: 8),
              Text(
                _isOtpStep
                    ? (widget.isBangla
                        ? '${_phoneController.text} নম্বরে প্রেরিত ৪-সংখ্যার কোডটি লিখুন'
                        : 'Enter the 4-digit code sent to ${_phoneController.text}')
                    : (widget.isBangla
                        ? 'আপনার মোবাইল নম্বর দিয়ে বিনিয়োগ অ্যাকাউন্টে প্রবেশ করুন'
                        : 'Enter your mobile number to access verified opportunities'),
                style: AppTypography.bodyMedium(isDark: isDark, isBangla: widget.isBangla),
              ),

              const SizedBox(height: 36),

              if (!_isOtpStep) ...[
                // Phone Input Field
                Text(
                  widget.isBangla ? 'মোবাইল নম্বর' : 'Mobile Number',
                  style: AppTypography.caption(isDark: isDark, isBangla: widget.isBangla).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightCard,
                    borderRadius: AppRadius.borderMd,
                    border: Border.all(
                      color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text('🇧🇩', style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 6),
                            Text(
                              '+880',
                              style: AppTypography.headingSmall(isDark: isDark).copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: AppTypography.headingSmall(isDark: isDark).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: '1712-345678',
                            hintStyle: TextStyle(
                              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                AppButton(
                  text: widget.isBangla ? 'ওটিপি কোড পাঠান' : 'Send OTP Code',
                  onPressed: _requestOtp,
                  isLoading: _isLoading,
                  isBangla: widget.isBangla,
                ),
              ] else ...[
                // OTP Input Field
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 68,
                      height: 64,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : AppColors.lightCard,
                        borderRadius: AppRadius.borderMd,
                        border: Border.all(
                          color: _otpControllers[index].text.isNotEmpty
                              ? (isDark ? AppColors.accentGold : AppColors.primary)
                              : (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _otpFocusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: AppTypography.displayMedium(isDark: isDark).copyWith(
                            fontWeight: FontWeight.w800,
                            color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          onChanged: (val) {
                            if (val.isNotEmpty && index < 3) {
                              _otpFocusNodes[index + 1].requestFocus();
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // Resend Countdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isBangla
                          ? (_resendTimerSeconds > 0
                              ? 'পুনরায় ওটিপি কোড: $_resendTimerSeconds সেকেন্ড'
                              : 'ওটিপি মেয়াদ শেষ হয়েছে')
                          : (_resendTimerSeconds > 0
                              ? 'Resend OTP in $_resendTimerSeconds s'
                              : 'OTP expired'),
                      style: AppTypography.caption(isDark: isDark, isBangla: widget.isBangla),
                    ),
                    if (_resendTimerSeconds == 0)
                      TextButton(
                        onPressed: _startTimer,
                        child: Text(
                          widget.isBangla ? 'আবার পাঠান' : 'Resend Code',
                          style: AppTypography.caption(isDark: isDark, isBangla: widget.isBangla).copyWith(
                            color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 28),

                AppButton(
                  text: widget.isBangla ? 'যাচাই ও প্রবেশ করুন' : 'Verify & Continue',
                  onPressed: _verifyOtp,
                  isLoading: _isLoading,
                  isBangla: widget.isBangla,
                ),
              ],

              const SizedBox(height: 48),

              // Demo Mode Quick Login Cards (For Evaluator & User testing)
              Center(
                child: Text(
                  widget.isBangla ? '— তাৎক্ষণিক ডেমো লগইন —' : '— QUICK DEMO LOGIN —',
                  style: AppTypography.caption(isDark: isDark, isBangla: widget.isBangla).copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Investor Demo Login Card
              InkWell(
                onTap: () => widget.onAuthSuccess(UserRole.investor),
                borderRadius: AppRadius.borderMd,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: AppRadius.borderMd,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primarySubtle,
                        child: Icon(Icons.person_rounded, color: AppColors.primaryDark),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isBangla ? 'বিনিয়োগকারী হিসেবে প্রবেশ (ওহী)' : 'Login as Investor (Ohi)',
                              style: AppTypography.headingSmall(isDark: isDark, isBangla: widget.isBangla).copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              widget.isBangla ? '৪টি শেয়ার সাবস্ক্রাইবড • ল্যান্ডভেস্ট ১০০' : '4 Shares • LandVest 100 Portfolio',
                              style: AppTypography.caption(isDark: isDark, isBangla: widget.isBangla),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.primary),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Admin Demo Login Card
              InkWell(
                onTap: () => widget.onAuthSuccess(UserRole.admin),
                borderRadius: AppRadius.borderMd,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: AppRadius.borderMd,
                    border: Border.all(
                      color: AppColors.accentGold.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.accentGoldMuted,
                        child: Icon(Icons.admin_panel_settings_rounded, color: AppColors.accentGoldDark),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isBangla ? 'অ্যাডমিন কনসোলে প্রবেশ (তানভীর)' : 'Login as Super Admin & Finance',
                              style: AppTypography.headingSmall(isDark: isDark, isBangla: widget.isBangla).copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              widget.isBangla ? 'পেমেন্ট যাচাই, শেয়ার বরাদ্দ ও ভাউচার নিয়ন্ত্রণ' : 'Reconciliation, Allocation, Audit & Ledger',
                              style: AppTypography.caption(isDark: isDark, isBangla: widget.isBangla),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.accentGoldDark),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
