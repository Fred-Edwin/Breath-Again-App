import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/glass_bottom_nav_bar.dart';
import 'garden_screen.dart'; 
import 'insights_screen.dart';
import 'ai_botanist_screen.dart';
import 'profile_screen.dart';
import 'lighting_control_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onNavTap(BuildContext context, int index) {
    if (index == 1) { // Garden
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const GardenScreen(),
          transitionDuration: Duration.zero, // Instant switch for tabs
        ),
      );
    } else if (index == 2) { // Insights
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const InsightsScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else if (index == 3) { // AI
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AIBotanistScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else if (index == 4) { // Profile
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ProfileScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/dark_tropical_leaves_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0x33000000), // Semi-transparent black (0.2)
                    const Color(0xE6000000), // Deep charcoal/black (0.9)
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // 3. Body Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good evening, Julian.",
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.white.withAlpha(179),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Your Vertical Garden",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Profile Picture - Tappable
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const ProfileScreen(),
                              transitionDuration: Duration.zero,
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: const AssetImage('assets/images/user_profile.png'),
                          backgroundColor: Colors.white.withAlpha(26),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Water Tank Status - Hero Element
                  Center(
                    child: _buildWaterTankWidget(),
                  ),

                  const SizedBox(height: 40),

                  // Sensor Data Row
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSensorItem(Icons.air, "Air Quality", "42", "Good", const Color(0xFF22C55E)),
                        _buildDivider(),
                        _buildSensorItem(Icons.thermostat_outlined, "Temperature", "22°C", "Optimal", const Color(0xFF3B82F6)),
                        _buildDivider(),
                        _buildSensorItem(Icons.water_drop_outlined, "Humidity", "65%", "Ideal", const Color(0xFF8B5CF6)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Alerts Section
                  _buildAlertsSection(),

                  const SizedBox(height: 40),

                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.lightbulb_outline,
                          label: "Lighting",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LightingControlScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.show_chart,
                          label: "Environment",
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const InsightsScreen(),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // 4. Custom Floating Bottom Navigation
          Positioned(
            left: 20,
            right: 20,
            bottom: 30, // Tucked into safe area
            child: GlassBottomNavBar(
              currentIndex: 0,
              onTap: (index) => _onNavTap(context, index),
            ),
          ),
        ],
      ),
    );
  }

  // Water Tank Widget - Beautiful Circular Progress
  Widget _buildWaterTankWidget() {
    const double tankLevel = 45.0; // Percentage
    final Color tankColor = tankLevel > 60 ? const Color(0xFF22C55E) : (tankLevel > 30 ? const Color(0xFFFBBF24) : const Color(0xFFEF4444));
    
    return Column(
      children: [
        // Circular Progress Indicator
        Stack(
          alignment: Alignment.center,
          children: [
            // Background circle
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withAlpha(26),
                  width: 8,
                ),
              ),
            ),
            // Progress circle
            SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                value: tankLevel / 100,
                strokeWidth: 8,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation(tankColor),
              ),
            ),
            // Center content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.water_drop, color: tankColor, size: 32),
                const SizedBox(height: 8),
                Text(
                  '${tankLevel.toInt()}%',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Water Tank',
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: Colors.white.withAlpha(179),
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Status text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: tankColor.withAlpha(26),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: tankColor.withAlpha(51)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.schedule, color: tankColor, size: 16),
              const SizedBox(width: 8),
              Text(
                'Refill in 3 days',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: tankColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Sensor Item - Color-coded with elegant design
  Widget _buildSensorItem(IconData icon, String label, String value, String status, Color accentColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: accentColor.withAlpha(26),
            shape: BoxShape.circle,
            border: Border.all(color: accentColor.withAlpha(51)),
          ),
          child: Icon(icon, color: accentColor, size: 24),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 10,
            color: Colors.white.withAlpha(153),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          status,
          style: GoogleFonts.lato(
            fontSize: 10,
            color: accentColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Alerts Section
  Widget _buildAlertsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'ALERTS',
            style: GoogleFonts.lato(
              fontSize: 11,
              color: Colors.white.withAlpha(128),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFBBF24).withAlpha(13),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFBBF24).withAlpha(51)),
          ),
          child: Row(
            children: [
              Icon(Icons.water_drop_outlined, color: const Color(0xFFFBBF24), size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Water tank at 45%',
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Refill recommended soon',
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.white.withAlpha(128), size: 20),
            ],
          ),
        ),
      ],
    );
  }

  // Action Button
  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withAlpha(26)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF22C55E), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white.withAlpha(51),
    );
  }
}
