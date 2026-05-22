import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/stylized_3d_icon.dart';

class DigitalTwinScreen extends StatelessWidget {
  const DigitalTwinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Metabolic Clone',
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
          TextButton.icon(
            onPressed: () => context.push('/what-if-simulation'),
            icon: const Icon(LucideIcons.sparkles, size: 16, color: AppTheme.purpleAI),
            label: const Text('Simulate', style: TextStyle(color: AppTheme.purpleAI, fontWeight: FontWeight.bold)),
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
              // 1. Digital Twin Holographic Centerpiece Card
              GlassCard(
                hasGlow: true,
                glowColor: AppTheme.purpleAI.withOpacity(0.12),
                borderRadius: 28,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.cpu, color: AppTheme.purpleAI, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          'AI Digital Twin Model',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: isDark ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.emeraldHealth.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Model Active',
                            style: TextStyle(
                              color: AppTheme.emeraldHealth,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Central animated neural metabolic node network
                    Center(
                      child: Container(
                        width: 180,
                        height: 180,
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Rotating nodes backdrop
                            const SizedBox(
                              width: 160,
                              height: 160,
                              child: _MetabolicNetworkWidget(),
                            ),
                            // Profile Avatar
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTheme.purpleAI.withOpacity(0.3),
                                  width: 2.0,
                                ),
                                image: const DecorationImage(
                                  image: NetworkImage('https://i.pravatar.cc/150?img=33'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Alex Martinez',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Metabolic Version 3.2.1',
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                    ),
                    const SizedBox(height: 24),

                    // Key Twin Parameters tags
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildParamTag(context, 'Insulin Sensitivity', '72%', AppTheme.cyanAccent),
                        _buildParamTag(context, 'Gastric Emptying', 'Normal', AppTheme.emeraldHealth),
                        _buildParamTag(context, 'Liver Glucose', 'Low Out', AppTheme.emeraldHealth),
                        _buildParamTag(context, 'Beta Cell Fx', '65%', AppTheme.warning),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 2. Insights Header
              Text(
                'Clone Insights',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // 3. Insights Card
              GlassCard(
                padding: const EdgeInsets.all(20),
                borderRadius: 24,
                hasGlow: true,
                glowColor: AppTheme.cyanAccent.withOpacity(0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Model Updated', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                        Text('24h Data Window', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInsightTile(LucideIcons.trendingUp, 'Improved insulin sensitivity after today\'s walk', AppTheme.emeraldHealth),
                    const SizedBox(height: 14),
                    _buildInsightTile(LucideIcons.moon, 'Sleep debt detected — may increase tomorrow\'s fasting glucose', AppTheme.warning),
                    const SizedBox(height: 14),
                    _buildInsightTile(LucideIcons.activity, 'Stable post-prandial response pattern established', AppTheme.cyanAccent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParamTag(BuildContext context, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.18), width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 8, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightTile(IconData icon, String text, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, height: 1.4, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _MetabolicNetworkWidget extends StatefulWidget {
  const _MetabolicNetworkWidget();

  @override
  State<_MetabolicNetworkWidget> createState() => _MetabolicNetworkWidgetState();
}

class _MetabolicNetworkWidgetState extends State<_MetabolicNetworkWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _MetabolicNetworkPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _MetabolicNetworkPainter extends CustomPainter {
  final double progress;

  _MetabolicNetworkPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final double center = size.width / 2;
    final double radius = size.width / 2;
    final Offset centerOffset = Offset(center, center);

    // Draw connecting web lines
    final linePaint = Paint()
      ..color = AppTheme.purpleAI.withOpacity(0.15)
      ..strokeWidth = 1.0;

    final int numNodes = 6;
    final List<Offset> nodeOffsets = [];

    // Calculate node coordinates with slow rotation
    for (int i = 0; i < numNodes; i++) {
      final double angle = (i * 2 * math.pi / numNodes) + (progress * 2 * math.pi);
      final double x = center + radius * 0.95 * math.cos(angle);
      final double y = center + radius * 0.95 * math.sin(angle);
      nodeOffsets.add(Offset(x, y));
    }

    // Connect node ring and connect nodes to center
    for (int i = 0; i < numNodes; i++) {
      final nextIdx = (i + 1) % numNodes;
      canvas.drawLine(nodeOffsets[i], nodeOffsets[nextIdx], linePaint);
      canvas.drawLine(nodeOffsets[i], centerOffset, linePaint);
    }

    // Draw little pulsing nodes
    final nodePaint = Paint()
      ..color = AppTheme.purpleAI
      ..style = PaintingStyle.fill;

    for (int i = 0; i < numNodes; i++) {
      // breathing nodes sizes
      final double pulseSize = 4.0 + 2.0 * math.sin(progress * 4 * math.pi + i);
      canvas.drawCircle(nodeOffsets[i], pulseSize, nodePaint);

      // highlight rings
      canvas.drawCircle(
        nodeOffsets[i],
        pulseSize + 2.0,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = AppTheme.cyanAccent.withOpacity(0.4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MetabolicNetworkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
