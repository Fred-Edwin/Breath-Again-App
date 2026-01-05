import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../widgets/glass_bottom_nav_bar.dart';
import 'home_screen.dart'; 
import 'plant_detail_screen.dart';
import 'insights_screen.dart';
import 'ai_botanist_screen.dart';
import 'profile_screen.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Plants in vertical garden (6 total)
  final List<Map<String, dynamic>> _leftColumnItems = [
    {
      "image": "assets/images/monstera_portrait.png",
      "name": "Monstera",
      "botanicalName": "Monstera deliciosa",
      "location": "Living Room",
      "status": "THRIVING",
      "statusColor": Color(0xFF22C55E), // Green
      "height": 280.0,
    },
    {
      "image": "assets/images/fern_portrait.png",
      "name": "Boston Fern",
      "botanicalName": "Nephrolepis exaltata",
      "location": "Bathroom",
      "status": "THIRSTY",
      "statusColor": Color(0xFFF97316), // Orange
      "height": 220.0,
    },
  ];

  // Right Column items
  final List<Map<String, dynamic>> _rightColumnItems = [
    {
      "image": "assets/images/ficus_portrait.png",
      "name": "Fiddle Leaf",
      "botanicalName": "Ficus lyrata",
      "location": "Bedroom",
      "status": "THRIVING",
      "statusColor": Color(0xFF22C55E), // Green
      "height": 240.0,
    },
    {
      "image": "assets/images/palm_portrait.png",
      "name": "Areca Palm",
      "botanicalName": "Dypsis lutescens",
      "location": "Office",
      "status": "THRIVING",
      "statusColor": Color(0xFF22C55E), // Green
      "height": 300.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == 0) { // Home
       Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionDuration: Duration.zero,
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
      backgroundColor: const Color(0xFF050F07), // Midnight Moss
      body: Stack(
        children: [
          // Content
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // 1. Header (Minimalist Nav)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu, color: Colors.white, size: 24),
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage('assets/images/user_profile.png'),
                        backgroundColor: Colors.white.withAlpha(26), // ~0.1 opacity
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // 2. Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Vertical Garden",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 34,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "6 Plants • All Thriving",
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: const Color(0xFF22C55E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 3. Garden Health Overview
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _buildHealthOverview(),
                ),

                const SizedBox(height: 24),

                // 4. Asymmetric Grid
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 100), // Bottom padding for nav/fab
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column
                        Expanded(
                          child: Column(
                            children: _leftColumnItems.asMap().entries.map((entry) {
                              return _buildPlantCard(entry.value, entry.key, 0);
                            }).toList(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Right Column
                        Expanded(
                          child: Column(
                            children: _rightColumnItems.asMap().entries.map((entry) {
                              return _buildPlantCard(entry.value, entry.key, 1); // Delay slightly different
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 5. FAB
          Positioned(
            right: 24,
            bottom: 110, // Just above nav bar
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF22C55E),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF22C55E).withAlpha(100), // Glow
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ),

          // 6. Bottom Navigation
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: GlassBottomNavBar(
              currentIndex: 1, // Garden tab
              onTap: _onNavTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantCard(Map<String, dynamic> item, int index, int colIndex) {
    // Staggered delay based on column and index
    int delay = (colIndex * 100) + (index * 200);
    
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            delay / 1000.0, 
            (delay + 500) / 1000.0 > 1.0 ? 1.0 : (delay + 500) / 1000.0,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => PlantDetailScreen(plantData: item),
              transitionsBuilder: (_, animation, __, child) {
                 return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with Badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      item['image'],
                      width: double.infinity,
                      height: item['height'],
                      fit: BoxFit.cover,
                    ),
                  ),
                // Badge
                Positioned(
                  top: 16,
                  right: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        color: Colors.black.withAlpha(51), // 0.2 opacity
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: item['statusColor'],
                                boxShadow: [
                                  BoxShadow(
                                    color: (item['statusColor'] as Color).withAlpha(128),
                                    blurRadius: 4,
                                  )
                                ]
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              item['status'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Labels
            Text(
              item['name'],
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item['location'],
              style: GoogleFonts.lato(
                color: Colors.white.withAlpha(128), // 0.5 opacity
                fontSize: 12,
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }

  // Health Overview Card
  Widget _buildHealthOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x1A22C55E),
            Color(0x0D22C55E),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF22C55E).withAlpha(51)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHealthMetric("Health", "98%", Icons.favorite_outline),
          _buildDivider(),
          _buildHealthMetric("Water", "Optimal", Icons.water_drop_outlined),
          _buildDivider(),
          _buildHealthMetric("Light", "Good", Icons.wb_sunny_outlined),
        ],
      ),
    );
  }

  Widget _buildHealthMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF22C55E), size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 11,
            color: Colors.white.withAlpha(179),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white.withAlpha(26),
    );
  }
}
