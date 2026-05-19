import 'package:flutter/material.dart';
import 'create_site_screen.dart';

// ==========================================
// PURPOSE: Dashboard Screen
// Displays the primary metrics card, quick actions, and recent activity
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ==========================================
  // PURPOSE: Build Main Layout
  // Constructs the scrollable dashboard interface
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildMainCard(),
              const SizedBox(height: 32),
              _buildQuickActions(context),
              const SizedBox(height: 32),
              const Text(
                'Recent Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
              _buildActivityList(),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // PURPOSE: Build Top Header
  // Displays user greeting and notification icon
  // ==========================================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning,', style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
            const Text('Sales Officer', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: const Color(0xFF1F1F2E), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }

  // ==========================================
  // PURPOSE: Build Primary Metrics Card
  // Renders the large purple gradient signature card
  // ==========================================
  Widget _buildMainCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9D63FF), Color(0xFF6C38FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: const Color(0xFF6C38FF).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Assigned Sites', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          const Text('1,250', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Target Completion: 65%', style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: 1.5)),
              Row(
                children: const [
                  Text('VIEW ALL', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // PURPOSE: Build Quick Actions Row
  // Renders the horizontal row of rounded action buttons
  // ==========================================
  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionIcon(Icons.verified_user, 'Verify', const Color(0xFF1F1F2E), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateSiteScreen()))),
        _actionIcon(Icons.qr_code_scanner, 'Scan QR', const Color(0xFF1F1F2E)),
        _actionIcon(Icons.location_on, 'Nearby', const Color(0xFF1F1F2E)),
        _actionIcon(Icons.auto_awesome, 'Insights', const Color(0xFF1F1F2E)),
      ],
    );
  }

  Widget _actionIcon(IconData icon, String label, Color bgColor, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
            child: Icon(icon, color: const Color(0xFF8A4FFF), size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // ==========================================
  // PURPOSE: Build Activity List
  // Renders the vertical list of recent operations
  // ==========================================
  Widget _buildActivityList() {
    return Column(
      children: [
        _activityTile(Icons.foundation, 'Slab Casting Verified', 'Site A - In Progress', 'Today', true),
        const SizedBox(height: 12),
        _activityTile(Icons.warning_amber_rounded, 'Demand Spike Alert', 'Site C - Kamrup Area', 'Yesterday', false),
        const SizedBox(height: 12),
        _activityTile(Icons.camera_alt, 'Photo Uploaded', 'Site B - Foundation', '10.05.2026', true),
      ],
    );
  }

  Widget _activityTile(IconData icon, String title, String subtitle, String date, bool success) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1F1F2E), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: success ? const Color(0xFF8A4FFF).withOpacity(0.2) : Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: success ? const Color(0xFF8A4FFF) : Colors.orange, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              ],
            ),
          ),
          Text(date, style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}