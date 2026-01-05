import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightingControlScreen extends StatefulWidget {
  const LightingControlScreen({super.key});

  @override
  State<LightingControlScreen> createState() => _LightingControlScreenState();
}

class _LightingControlScreenState extends State<LightingControlScreen> {
  bool _lightsOn = true;
  double _brightness = 75.0;
  int _selectedPreset = 0; // 0: Full Sun, 1: Partial Shade, 2: Low Light, 3: Custom

  final List<Map<String, dynamic>> _presets = [
    {"name": "Full Sun", "hours": 12, "brightness": 100},
    {"name": "Partial Shade", "hours": 8, "brightness": 70},
    {"name": "Low Light", "hours": 6, "brightness": 50},
    {"name": "Custom", "hours": 10, "brightness": 75},
  ];

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
                    const Color(0xFF121212).withAlpha(204),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(26),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "LIGHTING CONTROL",
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                color: const Color(0xFF22C55E),
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Manage your garden's lighting",
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.white.withAlpha(179),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Current Status Card
                  _buildStatusCard(),

                  const SizedBox(height: 24),

                  // Manual Controls
                  _buildManualControls(),

                  const SizedBox(height: 24),

                  // Presets
                  _buildPresets(),

                  const SizedBox(height: 24),

                  // Schedule Visualization
                  _buildScheduleSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _lightsOn ? const Color(0x1AFBBF24) : const Color(0x1A6B7280),
            _lightsOn ? const Color(0x0DFBBF24) : const Color(0x0D6B7280),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _lightsOn ? const Color(0xFFFBBF24).withAlpha(51) : Colors.white.withAlpha(26),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "STATUS",
                    style: GoogleFonts.lato(
                      fontSize: 11,
                      color: Colors.white.withAlpha(128),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _lightsOn ? const Color(0xFFFBBF24) : Colors.grey,
                          boxShadow: _lightsOn
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFFBBF24).withAlpha(100),
                                    blurRadius: 8,
                                  )
                                ]
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _lightsOn ? "LIGHTS ON" : "LIGHTS OFF",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.lightbulb,
                color: _lightsOn ? const Color(0xFFFBBF24) : Colors.grey,
                size: 48,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatusMetric("Brightness", "${_brightness.toInt()}%"),
              ),
              Container(width: 1, height: 40, color: Colors.white.withAlpha(26)),
              Expanded(
                child: _buildStatusMetric("Time Left", "4h 23m"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
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

  Widget _buildManualControls() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1A0F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MANUAL CONTROL",
            style: GoogleFonts.lato(
              fontSize: 11,
              color: const Color(0xFF22C55E),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          
          // ON/OFF Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Power",
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: _lightsOn,
                onChanged: (value) => setState(() => _lightsOn = value),
                activeColor: const Color(0xFF22C55E),
                activeTrackColor: const Color(0xFF22C55E).withAlpha(102),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Brightness Slider
          Text(
            "Brightness",
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: const Color(0xFFFBBF24),
              inactiveTrackColor: Colors.white.withAlpha(26),
              thumbColor: const Color(0xFFFBBF24),
              overlayColor: const Color(0xFFFBBF24).withAlpha(51),
              trackHeight: 6,
            ),
            child: Slider(
              value: _brightness,
              min: 0,
              max: 100,
              divisions: 20,
              label: "${_brightness.toInt()}%",
              onChanged: (value) => setState(() => _brightness = value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PRESETS",
          style: GoogleFonts.lato(
            fontSize: 11,
            color: const Color(0xFF22C55E),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(_presets.length, (index) {
            final isSelected = _selectedPreset == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedPreset = index),
                child: Container(
                  margin: EdgeInsets.only(right: index < _presets.length - 1 ? 12 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0x1A22C55E), Color(0x0D22C55E)],
                          )
                        : null,
                    color: isSelected ? null : const Color(0xFF0B1A0F),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF22C55E).withAlpha(51) : Colors.transparent,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _presets[index]["name"],
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: isSelected ? const Color(0xFF22C55E) : Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${_presets[index]["hours"]}h",
                        style: GoogleFonts.lato(
                          fontSize: 10,
                          color: Colors.white.withAlpha(128),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "24-HOUR SCHEDULE",
              style: GoogleFonts.lato(
                fontSize: 11,
                color: const Color(0xFF22C55E),
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Edit",
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: const Color(0xFF22C55E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 120,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF0B1A0F),
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomPaint(
            painter: SchedulePainter(),
            size: const Size(double.infinity, 80),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTimeLabel("00:00"),
            _buildTimeLabel("06:00"),
            _buildTimeLabel("12:00"),
            _buildTimeLabel("18:00"),
            _buildTimeLabel("24:00"),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeLabel(String time) {
    return Text(
      time,
      style: GoogleFonts.lato(
        fontSize: 10,
        color: Colors.white.withAlpha(128),
      ),
    );
  }
}

// Schedule Painter
class SchedulePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background line
    final bgPaint = Paint()
      ..color = Colors.white.withAlpha(26)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      bgPaint,
    );

    // Active period (6am - 6pm = 12 hours)
    final activePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFBBF24), Color(0xFF22C55E)],
      ).createShader(Rect.fromLTWH(size.width * 0.25, 0, size.width * 0.5, size.height))
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.25, size.height / 2),
      Offset(size.width * 0.75, size.height / 2),
      activePaint,
    );

    // Glow effect
    final glowPaint = Paint()
      ..color = const Color(0xFFFBBF24).withAlpha(60)
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawLine(
      Offset(size.width * 0.25, size.height / 2),
      Offset(size.width * 0.75, size.height / 2),
      glowPaint,
    );

    // Start/End markers
    final markerPaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.25, size.height / 2), 6, markerPaint);
    canvas.drawCircle(Offset(size.width * 0.75, size.height / 2), 6, markerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
