import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/widgets/app_logo_widget.dart';
import 'package:swapnojatri/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _emblemScale;
  late Animation<double> _emblemFade;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _emblemScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.60, curve: Curves.easeOutBack),
      ),
    );
    _emblemFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
      ),
    );

    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.35, 0.85, curve: Curves.easeOut),
      ),
    );
    _textSlide = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.35, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _animController.forward();

    // Auto-navigate after splash animation
    Future.delayed(const Duration(milliseconds: 2200), () {
      _proceedToApp();
    });
  }

  void _proceedToApp() {
    if (_navigated || !mounted) return;
    _navigated = true;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A2540),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _proceedToApp,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0A2540),
                Color(0xFF0D1F33),
                Color(0xFF071422),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              // Mountain / Wave Silhouette Graphic Backdrop
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 240,
                child: Opacity(
                  opacity: 0.25,
                  child: CustomPaint(
                    painter: _MountainSilhouettesPainter(),
                  ),
                ),
              ),

              // Main Content
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 1. Official Swapnojatri Blue Suitcase Logo
                      FadeTransition(
                        opacity: _emblemFade,
                        child: ScaleTransition(
                          scale: _emblemScale,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0066FF).withValues(alpha: 0.25),
                                  blurRadius: 36,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const SwapnojatriLogoWidget(
                              size: 110,
                              showText: false,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),

                      // 2. Headline & Slogan (From Specification)
                      FadeTransition(
                        opacity: _textFade,
                        child: SlideTransition(
                          position: _textSlide,
                          child: Column(
                            children: [
                              Text(
                                'একসাথে স্বপ্ন দেখি',
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                'একসাথে ভবিষ্যৎ গড়ি',
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00B4D8).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFF00B4D8).withValues(alpha: 0.3),
                                    width: 1.0,
                                  ),
                                ),
                                child: Text(
                                  'জমি ভিত্তিক বিনিয়োগ • নিরাপদ ভবিষ্যতের জন্য',
                                  style: GoogleFonts.hindSiliguri(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF00B4D8),
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Indicator
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'SWAPNOJATRI INVESTMENT PLATFORM',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.4),
                      letterSpacing: 2.0,
                    ),
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

class _MountainSilhouettesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF0066FF).withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height);
    path1.lineTo(0, size.height * 0.5);
    path1.lineTo(size.width * 0.35, size.height * 0.15);
    path1.lineTo(size.width * 0.70, size.height * 0.6);
    path1.lineTo(size.width, size.height * 0.3);
    path1.lineTo(size.width, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    final paint2 = Paint()
      ..color = const Color(0xFF00B4D8).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height);
    path2.lineTo(0, size.height * 0.7);
    path2.lineTo(size.width * 0.25, size.height * 0.45);
    path2.lineTo(size.width * 0.55, size.height * 0.8);
    path2.lineTo(size.width * 0.85, size.height * 0.4);
    path2.lineTo(size.width, size.height * 0.6);
    path2.lineTo(size.width, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
