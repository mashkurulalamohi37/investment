import 'package:flutter/foundation.dart';

/// Application & Network Configuration for Swapnojatri
class AppConfig {
  /// Local development Next.js server endpoint
  /// For Android emulator, 10.0.2.2 can be used; for web/desktop, localhost:3000.
  static const String localApiBaseUrl = kIsWeb
      ? 'http://localhost:3000/api'
      : 'http://127.0.0.1:3000/api';

  /// Production cPanel URL where your Next.js website is deployed
  /// e.g., 'https://swapnojatri.com/api' or 'https://your-cpanel-domain.com/api'
  static String productionApiBaseUrl = 'https://swapnojatri.com/api';

  /// Dynamic API Base URL switcher
  static bool useProduction = false;

  /// Active Base URL
  static String get apiBaseUrl =>
      useProduction ? productionApiBaseUrl : localApiBaseUrl;

  /// Custom Base URL override if user enters custom domain in settings
  static String? customApiBaseUrl;

  static String get activeApiUrl => customApiBaseUrl ?? apiBaseUrl;

  /// App Metadata
  static const String appName = 'Swapnojatri (স্বপ্নযাত্রী)';
  static const String appVersion = '1.0.0+1';
  static const String escrowBank = 'The City Bank Limited';
}
