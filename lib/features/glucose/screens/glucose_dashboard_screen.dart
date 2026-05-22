import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class GlucoseDashboardScreen extends StatelessWidget {
  const GlucoseDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Glucose Monitor',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(LucideIcons.chevronLeft, color: isDark ? Colors.white : AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.history, color: isDark ? Colors.white : AppTheme.textPrimary, size: 20),
            onPressed: () => context.push('/glucose-history'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Centerpiece: Glowing Metabolic Dial
              Center(
                child: Container(
                  width: 220,
                  height: 220,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer glowing rings
                      Container(
                        width: 190,
                        height: 190,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: AppTheme.emeraldHealth.withOpacity(0.08),
                            width: 8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.emeraldHealth.withOpacity(0.05),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      // Inner Dial Graphic
                      SizedBox(
                        width: 170,
                        height: 170,
                        child: CustomPaint(
                          painter: _GlucoseDialPainter(
                            progress: 0.65, // matches 118 mg/dL in target range
                            color: AppTheme.emeraldHealth,
                          ),
                        ),
                      ),
                      // Text Values
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Current Reading',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppTheme.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '118',
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? Colors.white : AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'mg/dL',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.emeraldHealth.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(LucideIcons.arrowUpRight, color: AppTheme.emeraldHealth, size: 12),
                                const SizedBox(width: 4),
                                Text(
                                  'Normal · +2/min',
                                  style: TextStyle(
                                    color: AppTheme.emeraldHealth,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // 2. Timeline Curve Graph
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                borderRadius: 28,
                hasGlow: true,
                glowColor: AppTheme.emeraldHealth.withOpacity(0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today\'s Activity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDark ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.emeraldHealth.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Time in Range: 88%',
                            style: TextStyle(
                              color: AppTheme.emeraldHealth,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const GlucoseCurveChart(),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              
              // 3. Quick Actions Grid
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context: context,
                      icon: LucideIcons.plusCircle,
                      label: 'Log Entry',
                      color: AppTheme.cyanAccent,
                      onTap: () => context.push('/glucose-manual-entry'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionCard(
                      context: context,
                      icon: LucideIcons.scanFace,
                      label: 'Scan Meter',
                      color: AppTheme.emeraldHealth,
                      onTap: () => context.push('/glucose-ocr-scanner'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // 4. View AI Predictions CTA
              GestureDetector(
                onTap: () => context.push('/glucose-prediction'),
                child: GlassCard(
                  padding: const EdgeInsets.all(18),
                  borderRadius: 24,
                  hasGlow: true,
                  glowColor: AppTheme.purpleAI.withOpacity(0.15),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.purpleAI.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.sparkles, color: AppTheme.purpleAI, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Predictive Glucose Models',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Forecast your metabolic state up to 4 hours ahead',
                              style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      const Icon(LucideIcons.arrowUpRight, color: AppTheme.purpleAI),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 16),
        borderRadius: 20,
        hasGlow: true,
        glowColor: color.withOpacity(0.05),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlucoseDialPainter extends CustomPainter {
  final double progress;
  final Color color;

  _GlucoseDialPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background track arc
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..color = color.withOpacity(0.15);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius * 0.95), math.pi * 0.75, math.pi * 1.5, false, trackPaint);

    // Active progress arc
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [color.withOpacity(0.4), color],
        startAngle: math.pi * 0.75,
        endAngle: math.pi * 0.75 + (math.pi * 1.5 * progress),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.95),
      math.pi * 0.75,
      math.pi * 1.5 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GlucoseDialPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class GlucoseCurveChart extends StatelessWidget {
  const GlucoseCurveChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: CustomPaint(
        painter: _GlucoseChartPainter(
          isDark: Theme.of(context).brightness == Brightness.dark,
        ),
      ),
    );
  }
}

class _GlucoseChartPainter extends CustomPainter {
  final bool isDark;

  _GlucoseChartPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final double leftPadding = 32.0;
    final double bottomPadding = 24.0;
    final double chartWidth = w - leftPadding;
    final double chartHeight = h - bottomPadding;

    final double maxVal = 180.0;
    final double minVal = 50.0;

    // Draw horizontal target range background shading (70 - 140 mg/dL)
    final double y70 = chartHeight * (1.0 - (70 - minVal) / (maxVal - minVal));
    final double y140 = chartHeight * (1.0 - (140 - minVal) / (maxVal - minVal));

    final targetAreaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppTheme.emeraldHealth.withOpacity(0.08),
          AppTheme.emeraldHealth.withOpacity(0.03),
        ],
      ).createShader(Rect.fromLTRB(leftPadding, y140, w, y70));
    canvas.drawRect(Rect.fromLTRB(leftPadding, y140, w, y70), targetAreaPaint);

    // Draw target bounds borders
    final borderPaint = Paint()
      ..color = AppTheme.emeraldHealth.withOpacity(0.2)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(leftPadding, y70), Offset(w, y70), borderPaint);
    canvas.drawLine(Offset(leftPadding, y140), Offset(w, y140), borderPaint);

    // Y Axis Labels
    final yValues = [180, 140, 100, 70, 50];
    for (int val in yValues) {
      final double y = chartHeight * (1.0 - (val - minVal) / (maxVal - minVal));
      final textPainter = TextPainter(
        text: TextSpan(
          text: '$val',
          style: TextStyle(
            color: AppTheme.textSecondary.withOpacity(0.6),
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }

    // Bezier Glucose Curve points
    final points = [
      Offset(0.0, 95.0),
      Offset(0.15, 80.0),
      Offset(0.35, 145.0), // Breakfast spike
      Offset(0.55, 110.0),
      Offset(0.72, 160.0), // Lunch spike
      Offset(0.9, 118.0),
      Offset(1.0, 122.0),
    ];

    final path = Path();
    final shadowPath = Path();

    for (int i = 0; i < points.length; i++) {
      final double x = leftPadding + (points[i].dx * chartWidth);
      final double y = chartHeight * (1.0 - (points[i].dy - minVal) / (maxVal - minVal));

      if (i == 0) {
        path.moveTo(x, y);
        shadowPath.moveTo(x, y);
      } else {
        final prevX = leftPadding + (points[i - 1].dx * chartWidth);
        final prevY = chartHeight * (1.0 - (points[i - 1].dy - minVal) / (maxVal - minVal));
        final controlX1 = prevX + (x - prevX) / 2;
        final controlY1 = prevY;
        final controlX2 = prevX + (x - prevX) / 2;
        final controlY2 = y;
        path.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
        shadowPath.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
      }
    }

    // Draw Glowing Bezier Line
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [AppTheme.cyanAccent, AppTheme.emeraldHealth],
      ).createShader(Rect.fromLTWH(leftPadding, 0, chartWidth, chartHeight));
    canvas.drawPath(path, linePaint);

    // Draw Meal Nodes (utensil / coffee indicators)
    final mealIndices = [2, 4];
    final mealColors = [AppTheme.cyanAccent, AppTheme.warning];
    for (int i = 0; i < mealIndices.length; i++) {
      final idx = mealIndices[i];
      final double x = leftPadding + (points[idx].dx * chartWidth);
      final double y = chartHeight * (1.0 - (points[idx].dy - minVal) / (maxVal - minVal));
      
      canvas.drawCircle(Offset(x, y), 6, Paint()..color = mealColors[i]);
      canvas.drawCircle(Offset(x, y), 3, Paint()..color = Colors.white);
    }

    // Draw X labels
    final xLabels = ['8 AM', '12 PM', '4 PM', 'Now'];
    final xPositions = [0.15, 0.45, 0.75, 1.0];
    for (int i = 0; i < xLabels.length; i++) {
      final double x = leftPadding + (xPositions[i] * chartWidth);
      final textPainter = TextPainter(
        text: TextSpan(
          text: xLabels[i],
          style: TextStyle(
            color: AppTheme.textSecondary.withOpacity(0.7),
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, chartHeight + 8));
    }
  }

  @override
  bool shouldRepaint(covariant _GlucoseChartPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
