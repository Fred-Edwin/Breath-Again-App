import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/editorial_cta.dart';
import 'personalization_screen.dart';


class GardenSetupScreen extends StatefulWidget {
  const GardenSetupScreen({super.key});

  @override
  State<GardenSetupScreen> createState() => _GardenSetupScreenState();
}

enum SetupState { searching, success }

class _GardenSetupScreenState extends State<GardenSetupScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  SetupState _currentState = SetupState.searching;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // 4-second loop
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut), // Breathing motion
    );

    _opacityAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);

    // Simulate "Finding Sensor" after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _currentState = SetupState.success;
          _controller.stop();
          // Reset to a stable "Success" state visualization
          _controller.value = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSuccess = _currentState == SetupState.success;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/calathea_ornata_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Gradient Overlay (0.85 opacity at bottom)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0x4D000000), // Top: Semi-transparent black (0.3)
                    const Color(0xD9000000), // Bottom: Deep charcoal/black (0.85)
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // 3. Central Content (Breathing Halo)
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // Use controller values if searching, else fixed scale for success
                double scale = isSuccess ? 1.0 : _scaleAnimation.value;
                double opacity = isSuccess ? 1.0 : _opacityAnimation.value;
                Color haloColor = const Color(0xFF22C55E);

                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSuccess ? haloColor : const Color(0x9922C55E), // Solid green on success, 0.6 opacity otherwise
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSuccess ? const Color(0x9922C55E) : haloColor.withAlpha((opacity * 127).toInt()), // 0.5 * 255 = 127.5
                          blurRadius: 20, // Heavy blur for "soft glow"
                          spreadRadius: isSuccess ? 5 : 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: isSuccess
                          ? const Icon(Icons.check, color: Color(0xFF22C55E), size: 48)
                          : Container( // Empty center or subtle pulse for searching
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0x1A22C55E), // 0.1 opacity
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 4. Content Logic
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Top Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Text(
                        "Finding your rhythm.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isSuccess ? "Sensor connected successfully." : "Listening for your garden’s sensors...",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: const Color(0xB3FFFFFF), // Light grey, italic
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Feedback Message
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    isSuccess 
                        ? "Your garden is ready to bloom."
                        : "Ensure your Breathe Again hub is plugged in and nearby.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: const Color(0xB3FFFFFF), // 70% opacity white
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Footer (Pagination + CTA)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // Pagination Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDot(isActive: false),
                          const SizedBox(width: 8),
                          _buildDot(isActive: false),
                          const SizedBox(width: 8),
                          _buildDot(isActive: true),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Primary CTA
                      EditorialCTA(
                        label: isSuccess ? "Begin Journey" : "Searching...",
                        onPressed: isSuccess 
                          ? () {
                              Navigator.of(context).push(_createRoute());
                            } 
                          : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8, // "pill-shaped/wider" for active
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF22C55E) : const Color(0x66FFFFFF), // White with 0.4 opacity
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }


  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const PersonalizationScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var slideTween = Tween(begin: const Offset(0.0, 0.1), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOut));
        var fadeTween = Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn));

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: SlideTransition(
            position: animation.drive(slideTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 800),
    );
  }
}
