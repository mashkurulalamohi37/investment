import 'package:flutter/foundation.dart';

/// Application & Network Configuration for Swapnojatri
class AppConfig {
  /// Base domain of the deployed live server & Ingress (Port 8083)
  static const String siteBaseUrl = 'http://118.179.223.42:8083';

  /// Local development Next.js server endpoint
  /// For Android emulator, 10.0.2.2 can be used; for web/desktop, localhost:3000.
  static const String localApiBaseUrl = kIsWeb
      ? 'http://localhost:3000/api'
      : 'http://127.0.0.1:3000/api';

  /// Live Cloud/Dedicated Server Backend API URL (Port 9003)
  static String productionApiBaseUrl = 'http://118.179.223.42:9003/api/v1';

  /// Fallback / Alternative Vercel API endpoint
  static const String vercelApiBaseUrl = 'https://investment-alpha-smoky.vercel.app/api';

  /// Dynamic API Base URL switcher - Defaulting to TRUE for live server backend
  static bool useProduction = true;

  /// Active Base URL
  static String get apiBaseUrl =>
      useProduction ? productionApiBaseUrl : localApiBaseUrl;

  /// Custom Base URL override if user enters custom domain in settings
  static String? customApiBaseUrl;

  static String get activeApiUrl => customApiBaseUrl ?? apiBaseUrl;

  /// Helper to resolve relative image or asset URLs against active site host
  static String resolveUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    final cleanPath = path.startsWith('/') ? path : '/$path';
    return '$siteBaseUrl$cleanPath';
  }

  /// App Metadata
  static const String appName = 'Swapnojatri (স্বপ্নযাত্রী)';
  static const String appVersion = '1.0.0+1';
  static const String escrowBank = 'The City Bank Limited';
}
