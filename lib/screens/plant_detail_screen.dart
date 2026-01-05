import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class PlantDetailScreen extends StatelessWidget {
  final Map<String, dynamic> plantData;

  const PlantDetailScreen({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    // Determine status color safely
    final Color statusColor = plantData['statusColor'] ?? const Color(0xFF22C55E);

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Stack(
        children: [
          // 1. Hero Image (45% Height)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  plantData['image'],
                  fit: BoxFit.cover,
                ),
                // Gradient Overlay for Text Readability
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color(0xFF050505).withAlpha(128), // Semi-transparent at bottom
                        const Color(0xFF050505), // Solid at bottom merge
                      ],
                      stops: const [0.6, 0.9, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Navigation Header (Overlay)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(51), // 0.2 opacity
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                      ),
                    ),
                    // Profile Profile
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: const AssetImage('assets/images/user_profile.png'),
                      backgroundColor: Colors.white.withAlpha(26),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Scrollable Body
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.35, // Start overlapping image slightly
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Floating Header Text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status Label
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: statusColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "LIVE STATUS",
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Common Name
                        Text(
                          plantData['name'],
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // Botanical Name
                        Text(
                          plantData['botanicalName'] ?? "Botanical Name",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            color: Colors.white.withAlpha(153), // 0.6 opacity
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Summary Metrics (Type 2 Cards)
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.eco_outlined,
                          label: "Health",
                          value: "Thriving",
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.air,
                          label: "Air Purity",
                          value: "98%",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Care Rituals
                  Text(
                    "Care Rituals",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRitualItem(Icons.wb_sunny_outlined, "Light", "Indirect morning sun.", "GOOD"),
                  _buildDivider(),
                  _buildRitualItem(Icons.water_drop_outlined, "Water", "Soil is moist.", "IN 3 DAYS"),
                  _buildDivider(),
                  _buildRitualItem(Icons.thermostat, "Temp", "Ideal range 20-25°C.", "PERFECT"),

                  const SizedBox(height: 32),

                  // Journal Entry
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B1A0F),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\"Acquired this beauty from the downtown nursery. It had two new leaves unfurling.\"",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 16,
                            color: Colors.white.withAlpha(230), // 0.9 opacity
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "— Oct 12, 2025",
                          style: GoogleFonts.lato(
                            fontSize: 12,
                            color: Colors.white.withAlpha(100), // 0.4 opacity
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 120), // Space for Sticky Button
                ],
              ),
            ),
          ),

          // 4. Primary CTA (Sticky Bottom)
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF22C55E).withAlpha(100), // Glow
                    blurRadius: 20,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Ask AI Botanist
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.psychology, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "Ask AI Botanist about this plant",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({required IconData icon, required String label, required String value}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(13), // 0.05 opacity
            border: Border.all(color: Colors.white.withAlpha(26)), // 0.1 opacity
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(height: 12),
              Text(
                value,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: Colors.white.withAlpha(128), // 0.5 opacity
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRitualItem(IconData icon, String title, String subtitle, String badge) {
    Color badgeColor = badge == "IN 3 DAYS" ? const Color(0xFF22C55E) : Colors.white;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(13),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: Colors.white.withAlpha(128),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor.withAlpha(26), // 0.1 opacity
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              badge,
              style: GoogleFonts.lato(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: badgeColor,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.white.withAlpha(26), // 0.1 opacity
    );
  }
}
