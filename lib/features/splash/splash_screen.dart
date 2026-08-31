import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/widgets/matra_rule_widget.dart';
import 'package:swapnojatri/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Matra rule draws, then title fades in, 900ms total before navigation (§10)
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _fadeController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1100), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim, secondaryAnim) => const OnboardingScreen(),
            transitionDuration: const Duration(milliseconds: 240),
            transitionsBuilder: (context, anim, secondaryAnim, child) {
              return FadeTransition(opacity: anim, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Scaffold(
      backgroundColor: palette.canvas,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Matra Rule draws
            MatraRuleWidget(width: 80, color: palette.pine, animate: true),
            const SizedBox(height: 8),

            // 2. Title sets in Noto Serif Bengali
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    'স্বপ্নযাত্রী',
                    style: GoogleFonts.notoSerifBengali(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: palette.pine,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ইনভেস্টমেন্ট প্ল্যাটফর্ম • প্লট ৪১৮',
                    style: GoogleFonts.anekBangla(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: palette.inkSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
