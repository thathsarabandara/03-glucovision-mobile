import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/stylized_3d_icon.dart';

class HeartRateTrendsScreen extends StatelessWidget {
  const HeartRateTrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'MY Heart',
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
            icon: Icon(LucideIcons.sliders, color: isDark ? Colors.white : AppTheme.textPrimary, size: 20),
            onPressed: () {},
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
              // 1. Centerpiece: Pulsing Heart Graphic inside glowing container
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppTheme.error.withOpacity(0.08),
                        AppTheme.error.withOpacity(0.02),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Stylized3DIcon(
                      type: StylizedIconType.heart,
                      size: 150,
                      baseColor: AppTheme.error,
                      animate: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // 2. "Your Statistic" Section
              Text(
                'Your Statistic',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              
              // Horizontal row of stats
              Row(
                children: [
                  Expanded(
                    child: _buildStatBadge(
                      context,
                      'Average',
                      '98',
                      'BPM',
                      const Color(0xFF8B5CF6), // Purple
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatBadge(
                      context,
                      'Minimum',
                      '48',
                      'BPM',
                      AppTheme.cyanAccent, // Blue
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatBadge(
                      context,
                      'Maximum',
                      '118',
                      'BPM',
                      AppTheme.error, // Red
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // 3. Heart Rate real-time trends header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Heart Rate',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  DropdownButton<String>(
                    value: 'Real Time',
                    underline: const SizedBox(),
                    icon: const Icon(LucideIcons.chevronDown, size: 14, color: AppTheme.textSecondary),
                    items: const [
                      DropdownMenuItem(
                        value: 'Real Time',
                        child: Text('Real Time', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      ),
                    ],
                    onChanged: (val) {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // 4. Custom Interactive Bar Chart
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                borderRadius: 28,
                hasGlow: true,
                glowColor: const Color(0xFF8B5CF6).withOpacity(0.08),
                child: const HeartRateChart(),
              ),
              const SizedBox(height: 24),
              
              // 5. Activity Correlation Summary
              GlassCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(LucideIcons.sparkles, color: AppTheme.cyanAccent, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Activity Correlation',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your 20-min cardio session today lowered your blood glucose by 28 mg/dL, matching our AI prediction.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 11,
                              color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBadge(BuildContext context, String label, String value, String unit, Color bulletColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      borderRadius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: bulletColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(
                  text: unit,
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeartRateChart extends StatelessWidget {
  const HeartRateChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeartRateChartPainter(
          isDark: Theme.of(context).brightness == Brightness.dark,
        ),
      ),
    );
  }
}

class _HeartRateChartPainter extends CustomPainter {
  final bool isDark;

  _HeartRateChartPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    
    // Margins
    final double leftPadding = 32.0;
    final double bottomPadding = 24.0;
    final double chartWidth = w - leftPadding;
    final double chartHeight = h - bottomPadding;

    // Draw horizontal dotted gridlines
    final gridPaint = Paint()
      ..color = (isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final yValues = [120, 100, 70, 60];
    final double maxVal = 130.0;
    final double minVal = 50.0;

    for (int i = 0; i < yValues.length; i++) {
      final double val = yValues[i].toDouble();
      final double y = chartHeight * (1.0 - (val - minVal) / (maxVal - minVal));
      
      // Draw grid line
      _drawDashedLine(canvas, Offset(leftPadding, y), Offset(w, y), gridPaint);

      // Draw label
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${yValues[i]}',
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

    // Draw columns (heart rate bars)
    final double barSpacing = chartWidth / 7;
    final barValues = [78, 92, 115, 88, 102, 70, 98];
    final barMinValues = [60, 65, 75, 68, 62, 58, 65];
    final timeLabels = ['9:10', '9:11', '9:12', '9:13', '9:14', '9:15', 'Now'];

    final barPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          const Color(0xFF8B5CF6).withOpacity(0.6),
          const Color(0xFF8B5CF6),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    for (int i = 0; i < barValues.length; i++) {
      final double x = leftPadding + (i * barSpacing) + (barSpacing / 4);
      final double yMax = chartHeight * (1.0 - (barValues[i] - minVal) / (maxVal - minVal));
      final double yMin = chartHeight * (1.0 - (barMinValues[i] - minVal) / (maxVal - minVal));

      // Draw rounded bar (capsule)
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTRB(x, yMax, x + 6.0, yMin),
        const Radius.circular(3),
      );
      canvas.drawRRect(rect, barPaint);

      // Draw smaller top/bottom dots for styled look
      canvas.drawCircle(Offset(x + 3.0, yMax), 1.5, Paint()..color = Colors.white);

      // Draw X label
      final textPainter = TextPainter(
        text: TextSpan(
          text: timeLabels[i],
          style: TextStyle(
            color: i == barValues.length - 1 ? const Color(0xFF8B5CF6) : AppTheme.textSecondary.withOpacity(0.7),
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      
      textPainter.paint(
        canvas,
        Offset(x + 3.0 - textPainter.width / 2, chartHeight + 8),
      );
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double dashWidth = 4.0;
    const double dashSpace = 4.0;
    
    double distance = (end.dx - start.dx).abs();
    int count = (distance / (dashWidth + dashSpace)).floor();
    
    for (int i = 0; i < count; i++) {
      final double xStart = start.dx + i * (dashWidth + dashSpace);
      canvas.drawLine(
        Offset(xStart, start.dy),
        Offset(xStart + dashWidth, start.dy),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HeartRateChartPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
