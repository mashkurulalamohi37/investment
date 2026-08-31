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
  Widget build(BuildContext context) {
    return AppStateScope(
      notifier: _appState,
      child: ListenableBuilder(
        listenable: _appState,
        builder: (context, child) {
          final isDark = _appState.themeMode == ThemeMode.dark;

          return MaterialApp(
            title: 'Swapnojatri Investment Platform',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: _appState.themeMode,
            builder: (context, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  // Desktop / Large screen frame wrapper
                  if (constraints.maxWidth > 500) {
                    return Scaffold(
                      backgroundColor: isDark ? const Color(0xFF070B12) : const Color(0xFFE8ECEF),
                      body: SafeArea(
                        child: Center(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 440,
                              maxHeight: constraints.maxHeight.clamp(0.0, 920.0),
                            ),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF070B12) : const Color(0xFFF7F9FC),
                              borderRadius: constraints.maxHeight > 700 ? BorderRadius.circular(16) : BorderRadius.zero,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                                  blurRadius: 28,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: child ?? const SizedBox.shrink(),
                          ),
                        ),
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
