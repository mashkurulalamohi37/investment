import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/widgets/app_logo_widget.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/app_shell.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isBangla;
  final AppState state;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.state,
    this.isBangla = true,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String _enteredOtp = '';
  int _countdown = 45;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _countdown = 45);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onDigitPressed(String digit) {
    if (_enteredOtp.length < 6) {
      HapticFeedback.selectionClick();
      setState(() {
        _enteredOtp += digit;
      });
      if (_enteredOtp.length == 6) {
        _verifyOtp();
      }
    }
  }

  void _onBackspacePressed() {
    if (_enteredOtp.isNotEmpty) {
      HapticFeedback.selectionClick();
      setState(() {
        _enteredOtp = _enteredOtp.substring(0, _enteredOtp.length - 1);
      });
    }
  }

  void _verifyOtp() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AppShell(state: widget.state)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.isBangla;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: palette.ink),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    // Top Logo
                    SwapnojatriLogoWidget(
                      size: 46,
                      showText: true,
                      isDark: isDark,
                      isBangla: isBangla,
                    ),
                    const SizedBox(height: 28),

                    Text(
                      isBangla ? 'আপনার কোড যাচাই করুন' : 'Verify Your Code',
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: palette.ink,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isBangla
                          ? 'আমরা পাঠানো ৬ সংখ্যার কোডটি ${widget.phoneNumber} নম্বরে পাঠিয়েছি'
                          : 'We have sent a 6-digit code to ${widget.phoneNumber}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 13,
                        color: palette.inkSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 6 Square OTP Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        final isFilled = index < _enteredOtp.length;
                        final isCurrent = index == _enteredOtp.length;
                        final digit = isFilled ? _enteredOtp[index] : '';

                        return Container(
                          width: 44,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: palette.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isCurrent
                                  ? const Color(0xFF0066FF)
                                  : (isFilled ? const Color(0xFF0066FF).withValues(alpha: 0.5) : palette.ruleStrong),
                              width: isCurrent ? 2.0 : 1.2,
                            ),
                            boxShadow: isCurrent
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF0066FF).withValues(alpha: 0.15),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            digit,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: palette.ink,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),

                    // Resend Timer Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isBangla ? 'পুনরায় কোড পাঠান ' : 'Resend Code in ',
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 13,
                            color: palette.inkSecondary,
                          ),
                        ),
                        Text(
                          '00:${_countdown.toString().padLeft(2, '0')}',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0066FF),
                          ),
                        ),
                        if (_countdown == 0) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _startTimer,
                            child: Text(
                              isBangla ? 'এখনই পাঠান' : 'Resend Now',
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0066FF),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // On-Screen Numeric Dialpad
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border(
                  top: BorderSide(color: palette.rule, width: 1.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDialpadRow(['1', '2', '3'], palette),
                  const SizedBox(height: 12),
                  _buildDialpadRow(['4', '5', '6'], palette),
                  const SizedBox(height: 12),
                  _buildDialpadRow(['7', '8', '9'], palette),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 64, height: 50),
                      _buildDialpadKey('0', palette),
                      SizedBox(
                        width: 64,
                        height: 50,
                        child: IconButton(
                          onPressed: _onBackspacePressed,
                          icon: Icon(Icons.backspace_outlined, size: 22, color: palette.ink),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialpadRow(List<String> keys, AppPalette palette) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) => _buildDialpadKey(key, palette)).toList(),
    );
  }

  Widget _buildDialpadKey(String label, AppPalette palette) {
    return InkWell(
      onTap: () => _onDigitPressed(label),
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 64,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: palette.ink,
          ),
        ),
      ),
    );
  }
}
