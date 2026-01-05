import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/editorial_cta.dart';
import 'home_screen.dart';


class PersonalizationScreen extends StatefulWidget {
  const PersonalizationScreen({super.key});

  @override
  State<PersonalizationScreen> createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends State<PersonalizationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int _selectedSpaceIndex = 0; // Default to "Home"
  final TextEditingController _nameController = TextEditingController();

  final List<String> _spaceOptions = ["Home", "Office", "Commercial"];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent background from resizing when keyboard opens
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/snake_plant_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Gradient Overlay (0.9 opacity at bottom)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0x66000000), // Top: Semi-transparent black (0.4)
                    const Color(0xE6000000), // Bottom: Deep charcoal/black (0.9)
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // 3. Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    // Headline
                    Text(
                      "Where will your \ngarden live?",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Subheadline
                    Text(
                      "We’ll optimize the ecosystem for your specific environment.",
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color(0xCCFFFFFF), // 0.8 opacity
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Editorial Selection List
                    Container(
                      height: 200, // Fixed height area for the list
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_spaceOptions.length, (index) {
                          return _buildEditorialItem(index);
                        }),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Garden Name Input
                    const Text(
                      "Garden Name",
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 14, 
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        hintText: "e.g., Living Room Garden",
                        hintStyle: TextStyle(color: Color(0x4DFFFFFF)), // 30% opacity
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0x4DFFFFFF)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF22C55E)),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),

                    const Spacer(),

                    // Primary CTA
                    Center(
                      child: EditorialCTA(
                        label: "Finalize Setup",
                        onPressed: () {
                          Navigator.of(context).push(_createRoute());
                        },
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

  Widget _buildEditorialItem(int index) {
    bool isSelected = _selectedSpaceIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSpaceIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0), // Spacing between items
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Selection Indicator (Thin Line)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 24,
                width: isSelected ? 2 : 0,
                color: const Color(0xFF22C55E),
                margin: EdgeInsets.only(right: isSelected ? 12 : 0),
              ),
              
              // Text
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: GoogleFonts.playfairDisplay(
                  fontSize: isSelected ? 32 : 24,
                  color: isSelected ? Colors.white : Colors.white.withAlpha(100), // ~0.4 opacity
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                  height: 1.0,
                ),
                child: Text(_spaceOptions[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 1000), // Slow fade
    );
  }
}
