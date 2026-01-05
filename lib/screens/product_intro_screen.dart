import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/editorial_cta.dart';
import 'home_screen.dart';

class ProductIntroScreen extends StatefulWidget {
  const ProductIntroScreen({super.key});

  @override
  State<ProductIntroScreen> createState() => _ProductIntroScreenState();
}

class _ProductIntroScreenState extends State<ProductIntroScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/fiddle_leaf_fig_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Gradient Overlay (Darker at bottom)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0x4D000000), // Top: Semi-transparent black (0.3)
                    const Color(0xCC000000), // Middle transition (0.8)
                    const Color(0xE6000000), // Bottom: Deep charcoal/black (0.9)
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          // 3. Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                
                // --- Header ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Spacer to balance the Skip button for centering logic if needed, 
                      // but requirement says "Top Right: Skip", "Top Center: Logo".
                      // Using Stack within Row or just MainAxisAlignment.spaceBetween with a dummy sized box.
                      // Let's use a Stack for the header to perfectly center the logo.
                      
                      const SizedBox(width: 40), // Balance right side button width approx
                      
                      // Brand Logo (Center)
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Icon(
                          Icons.eco, // Leaf icon
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      // Skip Button (Right)
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Skip",
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            color: const Color(0xE6FFFFFF), // White with 0.9 opacity
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // --- Main Content ---
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Headline
                            Text(
                              "Nature, automated.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 32,
                                height: 1.2,
                                letterSpacing: -0.32, // -0.01em
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Subtext
                            Text(
                              "Experience the benefits of a living ecosystem without the effort.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                color: const Color(0xB3FFFFFF), // White with 0.7 opacity
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Benefit List (Floating Style)
                            _buildBenefitItem(Icons.air, "Purifies your air naturally"),
                            const SizedBox(height: 24),
                            _buildBenefitItem(Icons.water_drop_outlined, "Intelligent autonomous watering"),
                            const SizedBox(height: 24),
                            _buildBenefitItem(Icons.auto_awesome_outlined, "Customized ambient lighting"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // --- Footer ---
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Pagination Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDot(isActive: false),
                          const SizedBox(width: 8),
                          _buildDot(isActive: true),
                          const SizedBox(width: 8),
                          _buildDot(isActive: false),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Primary CTA
                      EditorialCTA(
                        label: "Continue",
                        onPressed: () {
                          Navigator.of(context).push(_createRoute());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // As requested "Vertical list" centered or left aligned?
      // "Vertical list of three items... centered" implies the block is centered, but text alignment?
      // "Instead of cards, create a vertical list... Item 1... Item 2..."
      // Usually these look best left-aligned in a centered block, or just centered.
      // Given the "Floating Style" and current layout, let's keep them centered or slightly left aligned.
      // Let's try Centered row for now as per "Subtext... centered".
      children: [
        Icon(icon, color: const Color(0xE6FFFFFF), size: 24), // "very thin" - outlined icons used
        const SizedBox(width: 16),
        Text(
          text,
          style: GoogleFonts.lato(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
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
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
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
