import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_theme.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/splash/splash_screen.dart';
import 'package:swapnojatri/features/onboarding/onboarding_screen.dart';
import 'package:swapnojatri/features/auth/auth_screen.dart';
import 'package:swapnojatri/features/investor/main_layout.dart';
import 'package:swapnojatri/features/admin/admin_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const SwapnojatriApp());
}

enum AppFlowState { splash, onboarding, auth, authenticated }

class SwapnojatriApp extends StatefulWidget {
  const SwapnojatriApp({super.key});

  @override
  State<SwapnojatriApp> createState() => _SwapnojatriAppState();
}

class _SwapnojatriAppState extends State<SwapnojatriApp> {
  final AppState _appState = AppState();
  AppFlowState _flowState = AppFlowState.splash;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _appState,
      builder: (context, child) {
        return MaterialApp(
          title: 'Swapnojatri Investment Platform',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: _appState.themeMode,
          home: _buildCurrentScreen(),
        );
      },
    );
  }

  Widget _buildCurrentScreen() {
    Widget content;

    switch (_flowState) {
      case AppFlowState.splash:
        content = SplashScreen(
          isBangla: _appState.isBangla,
          onFinish: () {
            setState(() => _flowState = AppFlowState.onboarding);
          },
        );
        break;

      case AppFlowState.onboarding:
        content = OnboardingScreen(
          isBangla: _appState.isBangla,
          onComplete: () {
            setState(() => _flowState = AppFlowState.auth);
          },
        );
        break;

      case AppFlowState.auth:
        content = AuthScreen(
          isBangla: _appState.isBangla,
          onAuthSuccess: (role) {
            _appState.switchRole(role);
            setState(() => _flowState = AppFlowState.authenticated);
          },
        );
        break;

      case AppFlowState.authenticated:
        content = _appState.isAdmin
            ? AdminLayout(state: _appState)
            : InvestorMainLayout(
                state: _appState,
                onLogout: () {
                  setState(() => _flowState = AppFlowState.auth);
                },
              );
        break;
    }

    // Responsive Desktop/Web container wrapper for clean layout on large screens
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 650) {
          final isDark = _appState.themeMode == ThemeMode.dark;
          return Scaffold(
            backgroundColor: isDark ? AppColors.darkBg : const Color(0xFFE2E8F0),
            body: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 480),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: content,
              ),
            ),
          );
        }
        return content;
      },
    );
  }
}
