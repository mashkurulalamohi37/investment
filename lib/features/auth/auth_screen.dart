import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/widgets/app_logo_widget.dart';
import 'package:swapnojatri/core/widgets/brand_icons.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/app_shell.dart';
import 'package:swapnojatri/features/auth/otp_verification_screen.dart';

class AuthScreen extends StatefulWidget {
  final bool startInSignUp;
  const AuthScreen({super.key, this.startInSignUp = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool _isSignUp;
  bool _isBangla = true;
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _agreeToTerms = true;
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(text: '01812-345678');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(text: '••••••••');
  final TextEditingController _referralController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isSignUp = widget.startInSignUp;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  void _submitLogin(AppState state, {bool asAdmin = false}) async {
    HapticFeedback.mediumImpact();
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    setState(() => _isLoading = false);

    if (asAdmin) {
      state.switchUser('usr-002');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppShell(state: state)),
      );
    } else {
      state.switchUser('usr-001');
      // Navigate to OTP Screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            phoneNumber: _phoneController.text.isNotEmpty ? _phoneController.text : '01812-345678',
            state: state,
            isBangla: _isBangla,
          ),
        ),
      );
    }
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
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: palette.ink),
          onPressed: () {
            if (_isSignUp) {
              setState(() => _isSignUp = false);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          // Language Switcher
          TextButton(
            onPressed: () {
              HapticFeedback.selectionClick();
              setState(() => _isBangla = !_isBangla);
            },
            child: Text(
              _isBangla ? 'EN' : 'বাং',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0066FF),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Top Brand Logo
              SwapnojatriLogoWidget(
                size: 52,
                showText: true,
                isDark: isDark,
                isBangla: _isBangla,
              ),
              const SizedBox(height: 24),

              // 2. Title & Subtitle
              Text(
                _isSignUp
                    ? (_isBangla ? 'একাউন্ট তৈরি করুন' : 'Create Account')
                    : (_isBangla ? 'স্বাগতম ফিরে এসেছেন! 👋' : 'Welcome Back! 👋'),
                style: GoogleFonts.hindSiliguri(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: palette.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _isSignUp
                    ? (_isBangla ? 'বিনিয়োগ শুরু করতে এখনই যোগ দিন' : 'Join now to start smart investing')
                    : (_isBangla ? 'চালু রাখতে লগইন করুন' : 'Sign in to continue to your portfolio'),
                style: GoogleFonts.hindSiliguri(
                  fontSize: 13,
                  color: palette.inkSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // 3. Form Inputs
              if (_isSignUp) ...[
                _buildInputField(
                  controller: _nameController,
                  label: _isBangla ? 'পুরো নাম' : 'Full Name',
                  hint: _isBangla ? 'আপনার পূর্ণ নাম লিখুন' : 'Enter full name',
                  prefixIcon: Icons.person_outline_rounded,
                  palette: palette,
                ),
                const SizedBox(height: 14),
              ],

              _buildInputField(
                controller: _phoneController,
                label: _isBangla ? 'মোবাইল নম্বর' : 'Mobile Number',
                hint: '01812-345678',
                prefixIcon: Icons.phone_outlined,
                palette: palette,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 14),

              if (_isSignUp) ...[
                _buildInputField(
                  controller: _emailController,
                  label: _isBangla ? 'ইমেইল (ঐচ্ছিক)' : 'Email (Optional)',
                  hint: 'example@domain.com',
                  prefixIcon: Icons.email_outlined,
                  palette: palette,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),
              ],

              _buildInputField(
                controller: _passwordController,
                label: _isBangla ? 'পাসওয়ার্ড' : 'Password',
                hint: '••••••••',
                prefixIcon: Icons.lock_outline_rounded,
                palette: palette,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                    color: palette.inkTertiary,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),

              if (_isSignUp) ...[
                const SizedBox(height: 14),
                _buildInputField(
                  controller: _referralController,
                  label: _isBangla ? 'রেফার কোড (ঐচ্ছিক)' : 'Referral Code (Optional)',
                  hint: 'REF-12345',
                  prefixIcon: Icons.card_giftcard_outlined,
                  palette: palette,
                ),
              ],

              const SizedBox(height: 12),

              // 4. Remember / Forgot / Terms Checkbox
              if (!_isSignUp) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: const Color(0xFF0066FF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            onChanged: (val) => setState(() => _rememberMe = val ?? false),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isBangla ? 'আমাকে মনে রাখুন' : 'Remember me',
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 12.5,
                            color: palette.inkSecondary,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_isBangla ? 'পাসওয়ার্ড রিসেট লিঙ্ক এসএমএস করা হয়েছে' : 'Password reset link sent to mobile!'),
                            backgroundColor: const Color(0xFF0066FF),
                          ),
                        );
                      },
                      child: Text(
                        _isBangla ? 'পাসওয়ার্ড ভুলেছেন?' : 'Forgot Password?',
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0066FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _agreeToTerms,
                        activeColor: const Color(0xFF0066FF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (val) => setState(() => _agreeToTerms = val ?? false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _isBangla
                            ? 'আমি শর্তাবলী ও গোপনীয়তা নীতিমালার সাথে একমত'
                            : 'I agree to the Terms of Service and Privacy Policy',
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 12,
                          color: palette.inkSecondary,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 20),

              // 5. Primary Action Button (Royal Blue)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () => _submitLogin(state, asAdmin: false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          _isSignUp
                              ? (_isBangla ? 'সাইন আপ' : 'Sign Up')
                              : (_isBangla ? 'লগইন' : 'Log In'),
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // 6. Social Logins Section
              if (!_isSignUp) ...[
                Row(
                  children: [
                    Expanded(child: Divider(color: palette.rule)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        _isBangla ? 'অথবা অন্য মাধ্যমে লগইন করুন' : 'Or continue with',
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 11.5,
                          color: palette.inkTertiary,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: palette.rule)),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(const GoogleLogoWidget(size: 24), 'Google', palette, state),
                    const SizedBox(width: 16),
                    _buildSocialButton(const AppleLogoWidget(size: 24), 'Apple', palette, state),
                    const SizedBox(width: 16),
                    _buildSocialButton(const MicrosoftLogoWidget(size: 22), 'Microsoft', palette, state),
                  ],
                ),
                const SizedBox(height: 24),
              ],

              // 7. Toggle between Login & SignUp
              GestureDetector(
                onTap: () => setState(() => _isSignUp = !_isSignUp),
                child: RichText(
                  text: TextSpan(
                    text: _isSignUp
                        ? (_isBangla ? 'ইতিমধ্যে একাউন্ট আছে? ' : 'Already have an account? ')
                        : (_isBangla ? 'একাউন্ট নেই? ' : "Don't have an account? "),
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 13,
                      color: palette.inkSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: _isSignUp
                            ? (_isBangla ? 'লগইন' : 'Log In')
                            : (_isBangla ? 'সাইন আপ করুন' : 'Sign Up'),
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0066FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Quick Admin Switcher (For Pair Testing)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.admin_panel_settings_outlined, size: 16, color: palette.inkSecondary),
                    const SizedBox(width: 8),
                    Text(
                      _isBangla ? 'অ্যাডমিন হিসেবে প্রবেশ:' : 'Admin Portal:',
                      style: GoogleFonts.hindSiliguri(fontSize: 12, color: palette.inkSecondary),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _submitLogin(state, asAdmin: true),
                      child: Text(
                        _isBangla ? 'অ্যাডমিন ড্যাশবোর্ড' : 'Open Admin App',
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0066FF),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    required AppPalette palette,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.hindSiliguri(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: palette.ink,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: palette.ruleStrong, width: 1.0),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: GoogleFonts.poppins(fontSize: 14, color: palette.ink),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(fontSize: 13, color: palette.inkTertiary),
              prefixIcon: Icon(prefixIcon, size: 18, color: palette.inkSecondary),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(Widget iconWidget, String label, AppPalette palette, AppState state) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.ruleStrong, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: iconWidget,
        onPressed: () => _submitLogin(state, asAdmin: false),
      ),
    );
  }
}
