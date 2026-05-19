import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'create_site_screen.dart';

// ==========================================
// PURPOSE: Dashboard Screen
// Displays a flawlessly swipable vertical deck of metric cards
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ==========================================
  // PURPOSE: State Variables
  // ==========================================
  late final PageController _pageController;
  
  // The container is 260px tall, but the cards inside are 220px.
  // This leaves 40px of "bleed room" at the bottom for shadows!
  final double _containerHeight = 260.0; 
  final double _cardHeight = 220.0; 

  @override
  void initState() {
    super.initState();
    // FIXED: Removed viewportFraction. We use pure math for the stack now.
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ==========================================
  // PURPOSE: Build Main Layout
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: _buildHeader(),
              ),
              const SizedBox(height: 12),
              
              // 1. THE VERTICAL SWIPE DECK
              _buildStackedMainCards(),
              
              // 2. THE BLEND TRICK
              Transform.translate(
                offset: const Offset(0, -20), 
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildQuickActions(context),
                ),
              ),
              
              const SizedBox(height: 12),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1C19))),
                    Text('Weekly', style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildActivityList(),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // PURPOSE: Build Top Header
  // ==========================================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xFFD6E8D9),
              child: Icon(Icons.person, color: Color(0xFF135029)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sales Officer', style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                const Text('Zaheer Abbas', style: TextStyle(color: Color(0xFF1A1C19), fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
          child: const Icon(Icons.notifications_none, color: Color(0xFF1A1C19)),
        ),
      ],
    );
  }

  // ==========================================
  // PURPOSE: Vertical Stacked Deck Animation
  // FIXED: Flawless math to keep cards pinned in a stack while scrolling
  // ==========================================
  Widget _buildStackedMainCards() {
    return SizedBox(
      height: _containerHeight,
      child: PageView.builder(
        clipBehavior: Clip.none, 
        scrollDirection: Axis.vertical, 
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double page = 0.0;
              if (_pageController.position.haveDimensions) {
                page = _pageController.page ?? 0.0;
              }
              double delta = index - page; 

              if (delta > 0) {
                // CARDS WAITING BEHIND:
                // We perfectly counteract the native downward scroll by pulling it UP by delta * containerHeight.
                // Then we add a small 20px step so it peeks out at the bottom like a real deck.
                double translateY = -(delta * _containerHeight) + (delta * 20.0);
                double scale = math.max(0.85, 1.0 - (delta * 0.05)); 
                
                return Transform.translate(
                  offset: Offset(0, translateY),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topCenter,
                    child: child,
                  ),
                );
              } else {
                // CARD LEAVING (SCROLLING UP):
                // We let the native PageView handle the upward swipe, just fading it out.
                double opacity = math.max(0.0, 1.0 + delta);
                return Opacity(
                  opacity: opacity,
                  child: child,
                );
              }
            },
            // Align keeps the 220px card at the TOP of the 260px container,
            // giving the shadow 40px of room to bleed safely.
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: _cardHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildCarouselCardData(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ==========================================
  // PURPOSE: Select Data for the Deck
  // ==========================================
  Widget _buildCarouselCardData(int index) {
    if (index == 0) {
      return _buildCarouselCard(
        title: 'Total Assigned Sites', value: '1,250', icon: Icons.map_outlined,
        stat1Label: 'Region', stat1Value: 'Assam Zone', stat2Label: 'Completion', stat2Value: '65.2%', isPrimary: true,
      );
    } else if (index == 1) {
      return _buildCarouselCard(
        title: 'Verified Today', value: '42', icon: Icons.verified_user_outlined,
        stat1Label: 'Active Area', stat1Value: 'Kamrup', stat2Label: 'Pending', stat2Value: '18 Sites', isPrimary: false,
      );
    } else {
      return _buildCarouselCard(
        title: 'Est. Cement Demand', value: '15.2k', icon: Icons.inventory_2_outlined,
        stat1Label: 'Top Brand', stat1Value: 'EcoCem', stat2Label: 'Unit', stat2Value: 'Bags/Mo', isPrimary: false,
      );
    }
  }

  // ==========================================
  // PURPOSE: Individual Card Builder
  // ==========================================
  Widget _buildCarouselCard({
    required String title, required String value, required IconData icon,
    required String stat1Label, required String stat1Value, required String stat2Label, required String stat2Value, required bool isPrimary,
  }) {
    final bgColor = isPrimary ? const Color(0xFF135029) : const Color(0xFFE8F3E9);
    final textColor = isPrimary ? Colors.white : const Color(0xFF135029);
    final mutedTextColor = isPrimary ? Colors.white70 : const Color(0xFF135029).withOpacity(0.6);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isPrimary ? Colors.white.withOpacity(0.15) : const Color(0xFF135029).withOpacity(0.1), 
          width: 1.5
        ),
        boxShadow: [
          BoxShadow(
            color: isPrimary ? const Color(0xFF135029).withOpacity(0.4) : Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600)),
              Icon(icon, color: mutedTextColor, size: 24),
            ],
          ),
          const Spacer(), 
          Text(value, style: TextStyle(color: textColor, fontSize: 48, fontWeight: FontWeight.w800, letterSpacing: -1.5)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stat1Label, style: TextStyle(color: mutedTextColor, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(stat1Value, style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stat2Label, style: TextStyle(color: mutedTextColor, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(stat2Value, style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // PURPOSE: Build Quick Actions Row
  // ==========================================
  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _actionButton(
            'Verify Site',
            Icons.verified,
            true, 
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateSiteScreen()),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 4,
          child: _actionButton(
            'Discover',
            Icons.travel_explore,
            false, 
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.grid_view_rounded, color: Color(0xFF135029)),
        ),
      ],
    );
  }

  // ==========================================
  // PURPOSE: Quick Action Button UI
  // ==========================================
  Widget _actionButton(String title, IconData icon, bool isPrimary, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF135029) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isPrimary 
            ? [BoxShadow(color: const Color(0xFF135029).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))]
            : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? Colors.white : const Color(0xFF135029),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isPrimary ? Colors.white : const Color(0xFF135029),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // PURPOSE: Build Activity List
  // ==========================================
  Widget _buildActivityList() {
    return Row(
      children: [
        Expanded(
          child: _overviewBlock(
            Icons.check_circle_outline,
            'Verified',
            '42',
            '+12% this week',
            true,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _overviewBlock(
            Icons.hourglass_empty,
            'Pending',
            '15',
            '-3% this week',
            false,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // PURPOSE: Activity Block UI
  // ==========================================
  Widget _overviewBlock(IconData icon, String title, String value, String trend, bool isPositive) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F3E9), 
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF135029),
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1A1C19),
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            trend,
            style: TextStyle(
              color: isPositive ? const Color(0xFF135029) : Colors.orange.shade700,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}