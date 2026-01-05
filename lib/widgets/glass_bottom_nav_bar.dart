import 'package:flutter/material.dart';
import 'dart:ui'; // For BackdropFilter

class GlassBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 70,
          color: Colors.white.withAlpha(13), // ~0.05 opacity, very subtle fill
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home_filled, 0),
              _buildNavItem(Icons.filter_vintage_outlined, 1), // Garden
              _buildNavItem(Icons.graphic_eq, 2), // Insights
              _buildNavItem(Icons.smart_toy_outlined, 3), // AI
              _buildNavItem(Icons.person_outline, 4), // Profile
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: isActive 
            ? const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3322C55E),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ]
              )
            : null,
        child: Icon(
          icon,
          color: isActive ? const Color(0xFF22C55E) : Colors.white.withAlpha(128), // ~0.5 opacity
          size: 24,
        ),
      ),
    );
  }
}
