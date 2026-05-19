import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/main_navigation.dart';

// ==========================================
// PURPOSE: Application Entry Point
// Initializes the app and system UI overlays
// ==========================================
void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const SiteDiscoveryApp());
}

// ==========================================
// PURPOSE: Root Application Widget
// Defines the global dark theme and color palette
// ==========================================
class SiteDiscoveryApp extends StatelessWidget {
  const SiteDiscoveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SiteDiscovery',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF14141F), // Deep Dark Background
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8A4FFF), // Vibrant Purple Accent
          onPrimary: Colors.white,
          surface: Color(0xFF1F1F2E), // Dark Elevated Surface
          onSurface: Colors.white,
          secondary: Color(0xFF2D2D3F),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF14141F),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8A4FFF),
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1F1F2E),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF8A4FFF), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF8B8B9D)),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}