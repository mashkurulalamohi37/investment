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
          return MaterialApp(
            title: 'Swapnojatri Investment Platform',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: _appState.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
