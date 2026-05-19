import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/main_navigation.dart';

// ==========================================
// PURPOSE: Application Entry Point
// Initializes the app and system UI overlays for a light theme
// ==========================================
void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const SiteDiscoveryApp());
}

// ==========================================
// PURPOSE: Root Application Widget
// Defines the global eco-friendly light theme and green palette
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
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F7F5), // Soft off-white/gray background
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF135029), // Deep Forest Green (Main Actions)
          onPrimary: Colors.white,
          surface: Colors.white, // Pure white cards
          onSurface: Color(0xFF1A1C19), // Dark text
          secondary: Color(0xFFD6E8D9), // Soft background green
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F7F5),
          foregroundColor: Color(0xFF1A1C19),
          centerTitle: true,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF135029),
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Highly rounded like Fina
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFFE0E5E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFFE0E5E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF135029), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF8B938D)),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}