import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../widgets/glass_bottom_nav_bar.dart';
import 'home_screen.dart';
import 'garden_screen.dart';
import 'ai_botanist_screen.dart';
import 'profile_screen.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  int _selectedTimeframe = 0; // 0: Week, 1: Month, 2: Year
  int _currentTrendPage = 0; // For swipeable trends

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const GardenScreen(),
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
    // Index 2 is current
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050F07),
      body: Stack(
        children: [
          // Body Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header
                  Center(
                    child: Text(
                      "ENVIRONMENT",
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        letterSpacing: 2.0,
                        color: Colors.white.withAlpha(128),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(13), // 0.05 opacity
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: ["Week", "Month", "Year"].asMap().entries.map((entry) {
                          bool isActive = _selectedTimeframe == entry.key;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedTimeframe = entry.key),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: isActive ? const Color(0xFF22C55E) : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                entry.value,
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                  color: isActive ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Real-time Sensor Data",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 2. Air Quality Card (Hero)
                  _buildAirQualityCard(),

                  const SizedBox(height: 32),

                  // 3. Environmental Metrics Grid (2x2)
                  _buildSensorGrid(),

                  const SizedBox(height: 32),


                  // 4. 24-Hour Trends
                  _buildTrendsCard(),
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
              currentIndex: 2,
              onTap: _onNavTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required double height, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: height,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(13),
            border: Border.all(color: Colors.white.withAlpha(13)),
          ),
          child: child,
        ),
      ),
    );
  }

  // Air Quality Card - Beautiful Hero Element
  Widget _buildAirQualityCard() {
    const int aqi = 42;
    const Color aqiColor = Color(0xFF22C55E); // Good = Green
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            aqiColor.withAlpha(26),
            aqiColor.withAlpha(13),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: aqiColor.withAlpha(51), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: aqiColor.withAlpha(26),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Air Quality Index",
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.white.withAlpha(179),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: aqiColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "GOOD",
                  style: GoogleFonts.lato(
                    fontSize: 11,
                    color: aqiColor,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "$aqi",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 64,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "AQI",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.white.withAlpha(128),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Beautiful Line Graph
          SizedBox(
            height: 100,
            child: CustomPaint(
              painter: AQILineChartPainter(aqiColor),
              size: const Size(double.infinity, 100),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Excellent air quality maintained throughout the week",
            style: GoogleFonts.lato(
              fontSize: 13,
              color: Colors.white.withAlpha(179),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // Sensor Grid - 2x2 Beautiful Cards
  Widget _buildSensorGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildSensorCard(
              icon: Icons.thermostat_outlined,
              label: "Temperature",
              value: "22°C",
              status: "Optimal",
              trend: "+1°",
              color: const Color(0xFF3B82F6), // Blue
            )),
            const SizedBox(width: 16),
            Expanded(child: _buildSensorCard(
              icon: Icons.water_drop_outlined,
              label: "Humidity",
              value: "65%",
              status: "Ideal",
              trend: "-3%",
              color: const Color(0xFF8B5CF6), // Purple
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSensorCard(
              icon: Icons.wb_sunny_outlined,
              label: "Light Level",
              value: "850",
              status: "Active",
              trend: "6h left",
              color: const Color(0xFFFBBF24), // Yellow
            )),
            Expanded(child: _buildSensorCard(
              icon: Icons.opacity,
              label: "Water Usage",
              value: "2.3L",
              status: "Normal",
              trend: "This week",
              color: const Color(0xFF06B6D4), // Cyan
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildSensorCard({
    required IconData icon,
    required String label,
    required String value,
    required String status,
    required String trend,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withAlpha(26),
            color.withAlpha(13),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(51)),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(13),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(51),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 11,
              color: Colors.white.withAlpha(153),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                status,
                style: GoogleFonts.lato(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "• $trend",
                style: GoogleFonts.lato(
                  fontSize: 10,
                  color: Colors.white.withAlpha(128),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 24-Hour Trends Card - Swipeable
  Widget _buildTrendsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            "24-HOUR TRENDS",
            style: GoogleFonts.lato(
              fontSize: 11,
              color: Colors.white.withAlpha(128),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(
          height: 240,
          child: PageView(
            onPageChanged: (index) {
              setState(() => _currentTrendPage = index);
            },
            children: [
              _buildTrendCard(
                "Temperature",
                "22°C",
                "Optimal range maintained",
                const Color(0xFF3B82F6),
                [0.7, 0.65, 0.55, 0.45, 0.50, 0.55, 0.60],
              ),
              _buildTrendCard(
                "Humidity",
                "65%",
                "Ideal conditions for growth",
                const Color(0xFF8B5CF6),
                [0.5, 0.55, 0.65, 0.70, 0.65, 0.55, 0.45],
              ),
              _buildTrendCard(
                "Light Level",
                "850 lux",
                "Active lighting schedule",
                const Color(0xFFFBBF24),
                [0.3, 0.35, 0.30, 0.40, 0.50, 0.55, 0.50],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentTrendPage == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentTrendPage == index
                    ? const Color(0xFF22C55E)
                    : Colors.white.withAlpha(51),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTrendCard(
    String title,
    String value,
    String description,
    Color color,
    List<double> data,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withAlpha(26),
            color.withAlpha(13),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.white.withAlpha(179),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: CustomPaint(
              painter: SingleLineChartPainter(color, data),
              size: const Size(double.infinity, double.infinity),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.lato(
              fontSize: 12,
              color: Colors.white.withAlpha(179),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

}

// Single Line Chart Painter - For individual trend cards
class SingleLineChartPainter extends CustomPainter {
  final Color color;
  final List<double> data;

  SingleLineChartPainter(this.color, this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> dataPoints = [];
    final step = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      dataPoints.add(Offset(step * i, size.height * data[i]));
    }

    // Create smooth path
    final path = Path();
    path.moveTo(dataPoints[0].dx, dataPoints[0].dy);

    for (int i = 0; i < dataPoints.length - 1; i++) {
      final current = dataPoints[i];
      final next = dataPoints[i + 1];
      
      final controlPoint1 = Offset(
        current.dx + (next.dx - current.dx) / 3,
        current.dy,
      );
      final controlPoint2 = Offset(
        current.dx + 2 * (next.dx - current.dx) / 3,
        next.dy,
      );
      
      path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        next.dx, next.dy,
      );
    }

    // Outer glow
    final Paint outerGlowPaint = Paint()
      ..color = color.withAlpha(50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    // Inner glow
    final Paint innerGlowPaint = Paint()
      ..color = color.withAlpha(80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Main line
    final Paint linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw layers
    canvas.drawPath(path, outerGlowPaint);
    canvas.drawPath(path, innerGlowPaint);
    canvas.drawPath(path, linePaint);

    // Gradient fill
    Path fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withAlpha(60),
          color.withAlpha(30),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // Data points
    for (final point in dataPoints) {
      canvas.drawCircle(point, 4, Paint()..color = color.withAlpha(60));
      canvas.drawCircle(point, 2, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// AQI Line Chart Painter - Beautiful Smooth Curve
class AQILineChartPainter extends CustomPainter {
  final Color color;
  AQILineChartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    // Data points for smooth curve
    final List<Offset> dataPoints = [
      Offset(0, size.height * 0.65),
      Offset(size.width * 0.15, size.height * 0.55),
      Offset(size.width * 0.35, size.height * 0.45),
      Offset(size.width * 0.55, size.height * 0.40),
      Offset(size.width * 0.75, size.height * 0.35),
      Offset(size.width, size.height * 0.30),
    ];

    // Create smooth path using cubic bezier
    final path = Path();
    path.moveTo(dataPoints[0].dx, dataPoints[0].dy);

    for (int i = 0; i < dataPoints.length - 1; i++) {
      final current = dataPoints[i];
      final next = dataPoints[i + 1];
      final controlPoint1 = Offset(
        current.dx + (next.dx - current.dx) / 3,
        current.dy,
      );
      final controlPoint2 = Offset(
        current.dx + 2 * (next.dx - current.dx) / 3,
        next.dy,
      );
      path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        next.dx, next.dy,
      );
    }

    // Outer glow
    final Paint outerGlowPaint = Paint()
      ..color = color.withAlpha(40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Inner glow
    final Paint innerGlowPaint = Paint()
      ..color = color.withAlpha(80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // Main line
    final Paint linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw glow layers
    canvas.drawPath(path, outerGlowPaint);
    canvas.drawPath(path, innerGlowPaint);
    canvas.drawPath(path, linePaint);

    // Gradient fill underneath
    Path fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withAlpha(60),
          color.withAlpha(20),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // Draw data points
    for (int i = 0; i < dataPoints.length; i++) {
      // Outer ring
      canvas.drawCircle(
        dataPoints[i],
        6,
        Paint()..color = color.withAlpha(40),
      );
      // Inner dot
      canvas.drawCircle(
        dataPoints[i],
        3,
        Paint()..color = color,
      );
    }

    // Highlight endpoint
    canvas.drawCircle(
      dataPoints.last,
      8,
      Paint()..color = color.withAlpha(60),
    );
    canvas.drawCircle(
      dataPoints.last,
      4,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Multi-Line Chart Painter - Smooth Curves
class MultiLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Temperature (Blue)
    _drawSmoothLine(
      canvas,
      size,
      const Color(0xFF3B82F6),
      [0.7, 0.65, 0.55, 0.45, 0.50, 0.55, 0.60],
    );

    // Humidity (Purple)
    _drawSmoothLine(
      canvas,
      size,
      const Color(0xFF8B5CF6),
      [0.5, 0.55, 0.65, 0.70, 0.65, 0.55, 0.45],
    );

    // Light (Yellow)
    _drawSmoothLine(
      canvas,
      size,
      const Color(0xFFFBBF24),
      [0.3, 0.35, 0.30, 0.40, 0.50, 0.55, 0.50],
    );
  }

  void _drawSmoothLine(Canvas canvas, Size size, Color color, List<double> points) {
    final List<Offset> dataPoints = [];
    final step = size.width / (points.length - 1);

    for (int i = 0; i < points.length; i++) {
      dataPoints.add(Offset(step * i, size.height * points[i]));
    }

    // Create smooth path using cubic bezier
    final path = Path();
    path.moveTo(dataPoints[0].dx, dataPoints[0].dy);

    for (int i = 0; i < dataPoints.length - 1; i++) {
      final current = dataPoints[i];
      final next = dataPoints[i + 1];
      
      final controlPoint1 = Offset(
        current.dx + (next.dx - current.dx) / 3,
        current.dy,
      );
      final controlPoint2 = Offset(
        current.dx + 2 * (next.dx - current.dx) / 3,
        next.dy,
      );
      
      path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        next.dx, next.dy,
      );
    }

    // Glow effect
    final Paint glowPaint = Paint()
      ..color = color.withAlpha(60)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // Main line
    final Paint linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, linePaint);

    // Draw subtle data points
    for (final point in dataPoints) {
      canvas.drawCircle(
        point,
        2.5,
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GlowingLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0xFF22C55E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final Paint glowPaint = Paint()
      ..color = const Color(0xFF22C55E).withAlpha(100)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    // Mock Points logic
    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.cubicTo(
      size.width * 0.25, size.height * 0.9, 
      size.width * 0.5, size.height * 0.4, 
      size.width * 0.75, size.height * 0.5
    );
    path.quadraticBezierTo(
      size.width * 0.9, size.height * 0.3, 
      size.width, size.height * 0.2
    );

    // Draw Glow
    canvas.drawPath(path, glowPaint);
    // Draw Line
    canvas.drawPath(path, linePaint);

    // Gradient Fill Underneath
    Path fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF22C55E).withAlpha(51), // 0.2 opacity
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // Glowing Dot at End
    canvas.drawCircle(Offset(size.width, size.height * 0.2), 6, Paint()..color = const Color(0xFF22C55E));
    canvas.drawCircle(
      Offset(size.width, size.height * 0.2), 
      12, 
      Paint()..color = Color(0xFF22C55E).withAlpha(51)
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
