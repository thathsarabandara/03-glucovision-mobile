import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class GlucosePredictionScreen extends StatelessWidget {
  const GlucosePredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'AI Prognosis',
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Prediction Chart Card
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                borderRadius: 28,
                hasGlow: true,
                glowColor: AppTheme.purpleAI.withOpacity(0.12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2-Hour Forecast',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDark ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.purpleAI.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(LucideIcons.sparkles, color: AppTheme.purpleAI, size: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Custom Painted Forecast Curve Chart
                    const SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: _ForecastChartWidget(),
                    ),
                    
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.trendingUp, color: AppTheme.warning, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            'Peak: 155 mg/dL expected at 8:30 PM',
                            style: TextStyle(
                              color: AppTheme.warning,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // 2. AI Reasoning Title
              Text(
                'AI Analysis Details',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // 3. AI Reasoning List
              _buildReasoningCard(
                context: context,
                icon: LucideIcons.utensils,
                title: 'Glycemic Load Impact',
                description: 'Your dinner (Salmon Bowl) had a moderate glycemic load, but gastric emptying is slower than normal levels today.',
                color: AppTheme.cyanAccent,
              ),
              const SizedBox(height: 12),
              _buildReasoningCard(
                context: context,
                icon: LucideIcons.moon,
                title: 'Circadian Rhythm Factor',
                description: 'Metabolic insulin sensitivity is computationally modeled to decrease during late evening cycles.',
                color: AppTheme.purpleAI,
              ),
              const SizedBox(height: 12),
              _buildReasoningCard(
                context: context,
                icon: LucideIcons.activity,
                title: 'Activity Deficit Recorded',
                description: 'Missed scheduled 15-minute walk after meals has caused the AI model to project a steeper blood glucose slope.',
                color: AppTheme.warning,
              ),
              
              const SizedBox(height: 32),
              
              // 4. View Preventive Actions CTA Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => context.push('/risk-alert'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.warning,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'View Preventive Suggestions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReasoningCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 20,
      hasGlow: true,
      glowColor: color.withOpacity(0.04),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                    height: 1.4,
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

class _ForecastChartWidget extends StatelessWidget {
  const _ForecastChartWidget();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ForecastChartPainter(
        isDark: Theme.of(context).brightness == Brightness.dark,
      ),
    );
  }
}

class _ForecastChartPainter extends CustomPainter {
  final bool isDark;

  _ForecastChartPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final double leftPadding = 32.0;
    final double bottomPadding = 20.0;
    final double chartWidth = w - leftPadding;
    final double chartHeight = h - bottomPadding;

    final double maxVal = 180.0;
    final double minVal = 70.0;

    // Target range shading (70 - 140 mg/dL)
    final double y70 = chartHeight * (1.0 - (70 - minVal) / (maxVal - minVal));
    final double y140 = chartHeight * (1.0 - (140 - minVal) / (maxVal - minVal));

    final targetPaint = Paint()
      ..color = AppTheme.emeraldHealth.withOpacity(0.04);
    canvas.drawRect(Rect.fromLTRB(leftPadding, y140, w, y70), targetPaint);

    // Target borders
    final borderPaint = Paint()
      ..color = AppTheme.emeraldHealth.withOpacity(0.15)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(leftPadding, y70), Offset(w, y70), borderPaint);
    canvas.drawLine(Offset(leftPadding, y140), Offset(w, y140), borderPaint);

    // Axis values
    final yValues = [180, 140, 100, 70];
    for (int val in yValues) {
      final double y = chartHeight * (1.0 - (val - minVal) / (maxVal - minVal));
      final textPainter = TextPainter(
        text: TextSpan(
          text: '$val',
          style: TextStyle(
            color: AppTheme.textSecondary.withOpacity(0.5),
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }

    // Historical solid line + Future dashed forecasting curve
    // Historical points: (0, 118) to (0.4, 128)
    // Future points: (0.4, 128) to (0.7, 155 peak) to (1.0, 130)
    final double xTransition = leftPadding + (0.4 * chartWidth);
    
    // Draw transition vertical indicator line
    final transitionPaint = Paint()
      ..color = AppTheme.purpleAI.withOpacity(0.2)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(xTransition, 0), Offset(xTransition, chartHeight), transitionPaint);

    final textNow = TextPainter(
      text: const TextSpan(
        text: 'NOW',
        style: TextStyle(color: AppTheme.purpleAI, fontSize: 8, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textNow.paint(canvas, Offset(xTransition - textNow.width / 2, chartHeight + 4));

    // Solid Path (Historical)
    final solidPath = Path();
    final double yStart = chartHeight * (1.0 - (118 - minVal) / (maxVal - minVal));
    final double yTrans = chartHeight * (1.0 - (128 - minVal) / (maxVal - minVal));
    solidPath.moveTo(leftPadding, yStart);
    solidPath.quadraticBezierTo(leftPadding + (xTransition - leftPadding)/2, yStart - 4, xTransition, yTrans);

    final solidPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = AppTheme.cyanAccent;
    canvas.drawPath(solidPath, solidPaint);

    // Dashed Path (Forecast)
    final double yPeak = chartHeight * (1.0 - (155 - minVal) / (maxVal - minVal));
    final double yEnd = chartHeight * (1.0 - (130 - minVal) / (maxVal - minVal));
    
    final forecastPath = Path();
    forecastPath.moveTo(xTransition, yTrans);
    
    final xPeak = leftPadding + (0.75 * chartWidth);
    final xEnd = leftPadding + chartWidth;
    forecastPath.quadraticBezierTo(xTransition + (xPeak - xTransition)/2, yPeak, xPeak, yPeak);
    forecastPath.quadraticBezierTo(xPeak + (xEnd - xPeak)/2, yPeak - 10, xEnd, yEnd);

    // Draw dashed path
    final dashPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = AppTheme.purpleAI;

    // A simple dash drawing helper
    final pathMetrics = forecastPath.computeMetrics();
    for (var metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double segmentLength = 5.0;
        final Path extract = metric.extractPath(distance, distance + segmentLength);
        canvas.drawPath(extract, dashPaint);
        distance += segmentLength * 2.0; // 5px dash, 5px space
      }
    }

    // Draw Peak Marker Dot
    canvas.drawCircle(Offset(xPeak, yPeak), 6, Paint()..color = AppTheme.warning);
    canvas.drawCircle(Offset(xPeak, yPeak), 3.5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant _ForecastChartPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
