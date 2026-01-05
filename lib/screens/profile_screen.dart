import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glass_bottom_nav_bar.dart';
import 'home_screen.dart';
import 'garden_screen.dart';
import 'insights_screen.dart';
import 'ai_botanist_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock Settings State
  bool _hydrationAlerts = true;
  bool _lightAdjustments = true;
  bool _aiTips = false;

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => const HomeScreen(), transitionDuration: Duration.zero));
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => const GardenScreen(), transitionDuration: Duration.zero));
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => const InsightsScreen(), transitionDuration: Duration.zero));
    } else if (index == 3) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => const AIBotanistScreen(), transitionDuration: Duration.zero));
    }
    // Index 4 is current
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050F07), // Midnight Moss
      body: Stack(
        children: [
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF121212).withOpacity(0.8), // Deep Charcoal
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),
          
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), // Padding for Nav
              child: Column(
                children: [
                   // 1. Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                        // Title could go here, but design reference has it centered? No, design has header icons.
                        // "Profile & Settings" is implied by context or could be added. 
                        // User request: "Header: A 'Back' arrow on the top-left and a Green Checkmark on the top-right".
                        // No text title in the strict top bar described.
                        const Icon(Icons.check, color: Color(0xFF22C55E), size: 24),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 2. Profile Avatar & Name
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE0BFA0), // Soft tan/peach
                            image: const DecorationImage(
                              image: AssetImage('assets/images/user_profile.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E3B33), // Dark Grey/Green
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF050F07), width: 2),
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Elara Vance",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.spa, color: Color(0xFF22C55E), size: 14),
                      const SizedBox(width: 8),
                      Text(
                        "Vertical Garden",
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // 3. Top Statistics
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(child: _buildStatCard("6", "PLANTS")),
                        const SizedBox(width: 16),
                        Expanded(child: _buildStatCard("98%", "HEALTH SCORE")),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 4. Settings List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("NOTIFICATIONS"),
                        const SizedBox(height: 16),
                        _buildSettingsContainer([
                          _buildSwitchTile(Icons.water_drop_outlined, "Hydration Alerts", "Get notified when soil is dry", _hydrationAlerts, (v) => setState(() => _hydrationAlerts = v)),
                          const Divider(height: 1, color: Colors.white10),
                          _buildSwitchTile(Icons.wb_sunny_outlined, "Light Adjustments", "Smart lighting suggestions", _lightAdjustments, (v) => setState(() => _lightAdjustments = v)),
                          const Divider(height: 1, color: Colors.white10),
                          _buildSwitchTile(Icons.spa_outlined, "AI Botanist Tips", "Weekly insights digest", _aiTips, (v) => setState(() => _aiTips = v)),
                        ]),

                        const SizedBox(height: 32),

                        _buildSectionTitle("PREFERENCES"),
                        const SizedBox(height: 16),
                        _buildSettingsContainer([
                           _buildNavTile(Icons.edit_outlined, "Garden Name", "Vertical Garden"),
                           const Divider(height: 1, color: Colors.white10),
                           _buildNavTile(Icons.thermostat_outlined, "Temperature Unit", "Fahrenheit (°F)"),
                           const Divider(height: 1, color: Colors.white10),
                           _buildNavTile(Icons.dark_mode_outlined, "Appearance", "Dark (System)"),
                        ]),

                        const SizedBox(height: 32),
                        
                        _buildSectionTitle("SUPPORT"),
                        const SizedBox(height: 16),
                        _buildSettingsContainer([
                           _buildNavTile(Icons.help_outline, "Help Center", "", showArrow: true), // Icon overlay? Use custom icon
                           const Divider(height: 1, color: Colors.white10),
                           _buildNavTile(Icons.privacy_tip_outlined, "Privacy Policy", "", showArrow: true),
                           const Divider(height: 1, color: Colors.white10),
                           _buildNavTile(Icons.description_outlined, "Terms of Service", "", showArrow: true),
                        ]),
                        
                        const SizedBox(height: 40),

                        // 5. Footer
                        Container(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF121212),
                              side: const BorderSide(color: Color(0xFF3D1A1A)), // Red/Brown
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                            ),
                            child: Text(
                              "Log Out",
                              style: GoogleFonts.playfairDisplay(
                                color: const Color(0xFFEF5350), // Muted Red
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Breathe Again v2.4.0",
                          style: GoogleFonts.lato(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Nav
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: GlassBottomNavBar(
              currentIndex: 4,
              onTap: _onNavTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 0.5),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 10,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.lato(
        fontSize: 12,
        color: const Color(0xFF22C55E),
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSettingsContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1A0F), // Lighter Moss
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.lato(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                if (subtitle.isNotEmpty) 
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(subtitle, style: GoogleFonts.lato(color: Colors.white54, fontSize: 12)),
                  ),
              ],
            ),
          ),
          Switch(
            value: value, 
            onChanged: onChanged,
            activeColor: const Color(0xFF22C55E),
            activeTrackColor: const Color(0xFF22C55E).withOpacity(0.4),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile(IconData icon, String title, String trailingText, {bool showArrow = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: GoogleFonts.lato(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          if (trailingText.isNotEmpty)
            Text(trailingText, style: GoogleFonts.lato(color: Colors.white54, fontSize: 14)),
          if (showArrow) ...[
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.white38, size: 20),
          ]
        ],
      ),
    );
  }
}
