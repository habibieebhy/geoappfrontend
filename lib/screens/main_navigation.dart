import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'site_list_screen.dart';

// ==========================================
// PURPOSE: Main Navigation Wrapper
// Holds the state for the bottom navigation bar
// ==========================================
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  // ==========================================
  // PURPOSE: Initialize Screen List
  // Sets up the IndexedStack children on load
  // ==========================================
  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const Scaffold(body: Center(child: Text('Map View - Coming Soon', style: TextStyle(color: Colors.black)))),
      const SiteListScreen(), 
      const Scaffold(body: Center(child: Text('Leads - Coming Soon', style: TextStyle(color: Colors.black)))),
      const Scaffold(body: Center(child: Text('Profile - Coming Soon', style: TextStyle(color: Colors.black)))),
    ];
  }

  // ==========================================
  // PURPOSE: Build Navigation UI
  // Renders the IndexedStack and BottomNavigationBar
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, -5))
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFD6E8D9), // Soft green indicator
          height: 80,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined, color: Colors.grey), selectedIcon: Icon(Icons.home, color: Color(0xFF135029)), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.insert_chart_outlined, color: Colors.grey), selectedIcon: Icon(Icons.insert_chart, color: Color(0xFF135029)), label: 'Analytic'),
            NavigationDestination(icon: Icon(Icons.qr_code_scanner, color: Colors.grey), selectedIcon: Icon(Icons.qr_code_scanner, color: Color(0xFF135029)), label: 'Scan'),
            NavigationDestination(icon: Icon(Icons.assignment_outlined, color: Colors.grey), selectedIcon: Icon(Icons.assignment, color: Color(0xFF135029)), label: 'Tasks'),
            NavigationDestination(icon: Icon(Icons.person_outline, color: Colors.grey), selectedIcon: Icon(Icons.person, color: Color(0xFF135029)), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}