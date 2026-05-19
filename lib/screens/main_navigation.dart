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
      const Scaffold(body: Center(child: Text('Map View - Coming Soon'))),
      const SiteListScreen(), 
      const Scaffold(body: Center(child: Text('Leads - Coming Soon'))),
      const Scaffold(body: Center(child: Text('Profile - Coming Soon'))),
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
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) => setState(() => _currentIndex = index),
          backgroundColor: const Color(0xFF14141F),
          indicatorColor: const Color(0xFF8A4FFF).withOpacity(0.2),
          height: 70,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard, color: Color(0xFF8A4FFF)), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map, color: Color(0xFF8A4FFF)), label: 'Map'),
            NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment, color: Color(0xFF8A4FFF)), label: 'Tasks'),
            NavigationDestination(icon: Icon(Icons.radar_outlined), selectedIcon: Icon(Icons.radar, color: Color(0xFF8A4FFF)), label: 'Leads'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: Color(0xFF8A4FFF)), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}