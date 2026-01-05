import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditorialCTA extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;

  const EditorialCTA({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  State<EditorialCTA> createState() => _EditorialCTAState();
}

class _EditorialCTAState extends State<EditorialCTA> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    bool isDisabled = widget.onPressed == null;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isDisabled ? 0.5 : 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text
            Text(
              widget.label,
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8), // Spacing between text and underline
            
            // Animated Underline
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: 1.5, // Thin elegant line
              width: _isPressed ? 120 : 40, // Grows from small (subtle) to wider
              color: const Color(0xFF22C55E), // Vibrant Green
            ),
          ],
        ),
      ),
    );
  }
}
