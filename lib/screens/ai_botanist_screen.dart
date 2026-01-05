import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glass_bottom_nav_bar.dart';
import '../services/api_service.dart';
import 'home_screen.dart';
import 'garden_screen.dart';
import 'insights_screen.dart';
import 'profile_screen.dart';

class AIBotanistScreen extends StatefulWidget {
  const AIBotanistScreen({super.key});

  @override
  State<AIBotanistScreen> createState() => _AIBotanistScreenState();
}

class _AIBotanistScreenState extends State<AIBotanistScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  final TextEditingController _textController = TextEditingController();

  // Mock Chat Data
  final List<Map<String, dynamic>> _messages = [
    {
      "isUser": false,
      "text": "Hello, I am your botanical assistant. How is your sanctuary feeling today?"
    },
  ];

  List<String> _suggestions = [
    "Diagnose leaf spots",
    "Is my Monstera happy?",
    "Watering advice",
    "Fertilizer schedule",
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => const HomeScreen(), transitionDuration: Duration.zero));
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => const GardenScreen(), transitionDuration: Duration.zero));
    } else if (index == 2) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => const InsightsScreen(), transitionDuration: Duration.zero));
    } else if (index == 4) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => const ProfileScreen(), transitionDuration: Duration.zero));
    }
    // Index 3 is current
  }

  void _sendMessage() async {
    if (_textController.text.isNotEmpty) {
      final userMessage = _textController.text;
      setState(() {
        _messages.add({"isUser": true, "text": userMessage});
        _textController.clear();
      });

      try {
        // Call real backend API
        final response = await ApiService.sendAIMessage(userMessage);
        
        if (mounted) {
          setState(() {
            _messages.add({"isUser": false, "text": response['reply']});
            // Update suggestions if provided
            if (response['suggestions'] != null) {
              _suggestions = List<String>.from(response['suggestions']);
            }
          });
        }
      } catch (e) {
        // Fallback to mock response on error
        if (mounted) {
          setState(() {
            _messages.add({
              "isUser": false, 
              "text": "I'm having trouble connecting right now. Please make sure the backend server is running. 🌿"
            });
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050F07), // Midnight Moss
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // 1. Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 24), // Spacer for centering
                      Text(
                        "AI Botanist",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(Icons.history, color: Colors.white.withAlpha(179), size: 24),
                    ],
                  ),
                ),

                // 2. Botanical Avatar (Breathing)
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: const Icon(Icons.spa, color: Color(0xFF22C55E), size: 32),
                  ),
                ),

                // Date Label
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                     decoration: BoxDecoration(
                       color: Colors.white.withAlpha(13),
                       borderRadius: BorderRadius.circular(20),
                       border: Border.all(color: Colors.white.withAlpha(26)),
                     ),
                     child: Text(
                       "TODAY, 9:41 AM",
                       style: GoogleFonts.lato(
                         fontSize: 10,
                         fontWeight: FontWeight.bold,
                         color: Colors.white.withAlpha(153),
                         letterSpacing: 1.0,
                       ),
                     ),
                  ),
                ),

                const SizedBox(height: 20),

                // 3. Chat Area
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      bool isUser = msg['isUser'];
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          padding: const EdgeInsets.all(20),
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                          decoration: BoxDecoration(
                            color: isUser ? const Color(0xFF22C55E) : const Color(0xFF1F3528), // Dark Green for AI
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(24),
                              topRight: const Radius.circular(24),
                              bottomLeft: isUser ? const Radius.circular(24) : Radius.zero,
                              bottomRight: isUser ? Radius.zero : const Radius.circular(24),
                            ),
                          ),
                          child: Text(
                            msg['text'],
                            style: isUser 
                                ? GoogleFonts.lato(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500) // Black on Green
                                : GoogleFonts.playfairDisplay(
                                    color: Colors.white, // White on Dark
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 4. Input Console & Suggestions
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 100), // Bottom padding for Nav
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF050F07).withAlpha(0),
                        const Color(0xFF050F07),
                      ],
                      stops: const [0.0, 0.2],
                    ),
                  ),
                  child: Column(
                    children: [
                      // Suggestions
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: _suggestions.map((suggestion) {
                            return GestureDetector(
                              onTap: () {
                                _textController.text = suggestion;
                                _sendMessage();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1F3528), // Dark Green Pill
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white.withAlpha(26)),
                                ),
                                child: Text(
                                  suggestion,
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(204),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      
                      const SizedBox(height: 20),

                      // Input Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F3528), // Dark Input
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.white.withAlpha(26)),
                          ),
                          child: Row(
                            children: [
                              // Camera Button
                              IconButton(
                                icon: const Icon(Icons.camera_alt_outlined, color: Colors.white70, size: 24),
                                onPressed: () {},
                              ),
                              // Text Field
                              Expanded(
                                child: TextField(
                                  controller: _textController,
                                  style: GoogleFonts.lato(color: Colors.white),
                                  cursorColor: const Color(0xFF22C55E),
                                  decoration: InputDecoration(
                                    hintText: "Ask about your garden...",
                                    hintStyle: GoogleFonts.lato(color: Colors.white38),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  onSubmitted: (_) => _sendMessage(),
                                ),
                              ),
                              // Send Button
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF22C55E),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_upward, color: Colors.black, size: 20),
                                    onPressed: _sendMessage,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Nav
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: GlassBottomNavBar(
              currentIndex: 3,
              onTap: _onNavTap,
            ),
          ),
        ],
      ),
    );
  }
}
