import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_theme.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const SwapnojatriApp());
}

class SwapnojatriApp extends StatefulWidget {
  const SwapnojatriApp({super.key});

  @override
  State<SwapnojatriApp> createState() => _SwapnojatriAppState();
}

class _SwapnojatriAppState extends State<SwapnojatriApp> {
  final AppState _appState = AppState();

  @override
  void initState() {
    super.initState();
    // Connect and synchronize live data with the website backend on startup
    _appState.syncWithWebsite(notify: false);
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      notifier: _appState,
      child: ListenableBuilder(
        listenable: _appState,
        builder: (context, child) {
          final isDark = _appState.themeMode == ThemeMode.dark;

          return MaterialApp(
            title: 'Swapnojatri Investment Platform • স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(flavor: _appState.paletteFlavor),
            darkTheme: AppTheme.dark(flavor: _appState.paletteFlavor),
            themeMode: _appState.themeMode,
            builder: (context, child) {
              final palette = AppTheme.getPalette(_appState.paletteFlavor, isDark);
              return LayoutBuilder(
                builder: (context, constraints) {
                  // Desktop preview frame with authentic phone proportions
                  if (constraints.maxWidth > 500) {
                    final targetHeight = math.min(constraints.maxHeight - 32, 820.0);

                    return Container(
                      color: isDark ? const Color(0xFF0C100E) : const Color(0xFFE2E7DF),
                      alignment: Alignment.center,
                      child: Container(
                        width: 412,
                        height: targetHeight,
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: palette.canvas,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: palette.ruleStrong,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.12),
                              blurRadius: 32,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: child ?? const SizedBox.shrink(),
                      ),
                    );
                  }
                  // Mobile viewport fills 100%
                  return child ?? const SizedBox.shrink();
                },
              );
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
