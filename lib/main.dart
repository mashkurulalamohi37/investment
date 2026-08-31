import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
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
  Widget build(BuildContext context) {
    return AppStateScope(
      notifier: _appState,
      child: ListenableBuilder(
        listenable: _appState,
        builder: (context, child) {
          final isDark = _appState.themeMode == ThemeMode.dark;

          return MaterialApp(
            title: 'Swapnojatri • Land Investment',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: _appState.themeMode,
            builder: (context, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  // Desktop preview frame with authentic phone proportions
                  if (constraints.maxWidth > 500) {
                    final targetHeight = math.min(constraints.maxHeight - 32, 820.0);

                    return Container(
                      color: isDark ? const Color(0xFF070B12) : const Color(0xFFE2E6E4),
                      alignment: Alignment.center,
                      child: Container(
                        width: 412,
                        height: targetHeight,
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkBg : AppColors.lightBg,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
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
