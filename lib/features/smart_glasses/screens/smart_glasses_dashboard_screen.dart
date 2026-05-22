import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class SmartGlassesDashboardScreen extends StatefulWidget {
  const SmartGlassesDashboardScreen({super.key});

  @override
  State<SmartGlassesDashboardScreen> createState() => _SmartGlassesDashboardScreenState();
}

class _SmartGlassesDashboardScreenState extends State<SmartGlassesDashboardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Smart Glasses HUD',
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
            icon: Icon(LucideIcons.settings, color: isDark ? Colors.white : AppTheme.textPrimary, size: 20),
            onPressed: () => context.push('/smart-glasses-settings'),
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
              // 1. Futuristic Smart Glasses Status Card
              GlassCard(
                hasGlow: true,
                glowColor: AppTheme.cyanAccent.withOpacity(0.12),
                borderRadius: 28,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Graphic display
                    Center(
                      child: Container(
                        width: 200,
                        height: 120,
                        alignment: Alignment.center,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return CustomPaint(
                              size: const Size(180, 100),
                              painter: _SmartGlassesPainter(progress: _controller.value),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Device info details
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'GlucoVision AR Glasses v1',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: isDark ? Colors.white : AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(LucideIcons.bluetooth, color: AppTheme.emeraldHealth, size: 14),
                                  const SizedBox(width: 4),
                                  const Text('Connected', style: TextStyle(color: AppTheme.emeraldHealth, fontSize: 11, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 16),
                                  const Icon(LucideIcons.battery, color: AppTheme.textSecondary, size: 14),
                                  const SizedBox(width: 4),
                                  const Text('82%', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.cyanAccent.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(LucideIcons.wifi, color: AppTheme.cyanAccent, size: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 2. Actions Header
              Text(
                'Actions',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // 3. Actions Grid (2 columns)
              Row(
                children: [
                  Expanded(
                    child: _buildActionTile(
                      context: context,
                      icon: LucideIcons.video,
                      title: 'Live HUD Feed',
                      color: AppTheme.cyanAccent,
                      onTap: () => context.push('/smart-glasses-live-view'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionTile(
                      context: context,
                      icon: LucideIcons.layers,
                      title: 'Overlay Preview',
                      color: AppTheme.purpleAI,
                      onTap: () => context.push('/smart-glasses-overlay-preview'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 4. AR Overlays Header
              Text(
                'Active HUD Layers',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // 5. HUD Layer Switches
              _buildOverlayToggle(context, LucideIcons.utensils, 'Food Recognition', 'Detects and labels plates in real-time', true),
              const SizedBox(height: 12),
              _buildOverlayToggle(context, LucideIcons.activity, 'Glucose Level HUD', 'Projects raw metabolic level dynamically', true),
              const SizedBox(height: 12),
              _buildOverlayToggle(context, LucideIcons.alertTriangle, 'Risk Alerts', 'Overlays critical warning flashes in line-of-sight', true),
              const SizedBox(height: 12),
              _buildOverlayToggle(context, LucideIcons.navigation, 'Metabolic Routing', 'Draws paths for active calorie burn walks', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 20),
        borderRadius: 24,
        hasGlow: true,
        glowColor: color.withOpacity(0.06),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(
              title,
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

  Widget _buildOverlayToggle(BuildContext context, IconData icon, String title, String subtitle, bool isEnabled) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 20,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (isEnabled ? AppTheme.cyanAccent : AppTheme.textSecondary).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isEnabled ? AppTheme.cyanAccent : AppTheme.textSecondary, size: 18),
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
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (val) {},
            activeColor: AppTheme.emeraldHealth,
            inactiveTrackColor: AppTheme.surfaceHighlight,
          ),
        ],
      ),
    );
  }
}

class _SmartGlassesPainter extends CustomPainter {
  final double progress;

  _SmartGlassesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);

    // Draw scanning HUD grids/dots in background
    final gridPaint = Paint()
      ..color = AppTheme.cyanAccent.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    for (int i = 0; i < 5; i++) {
      final double y = h * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }

    // Draw active scanning ray
    final double rayY = h * (0.2 + 0.6 * math.sin(progress * math.pi));
    final rayPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppTheme.cyanAccent.withOpacity(0.0),
          AppTheme.cyanAccent.withOpacity(0.4),
          AppTheme.cyanAccent.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, rayY - 5, w, 10));
    canvas.drawRect(Rect.fromLTWH(0, rayY - 4, w, 8), rayPaint);

    // Draw futuristic smart glasses frame
    final framePath = Path();
    // Left lens frame
    framePath.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(center: center - Offset(38, 5), width: 50, height: 32),
      const Radius.circular(8),
    ));
    // Right lens frame
    framePath.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(center: center + Offset(38, -5), width: 50, height: 32),
      const Radius.circular(8),
    ));
    // Bridge connection
    framePath.moveTo(center.dx - 13, center.dy - 10);
    framePath.quadraticBezierTo(center.dx, center.dy - 14, center.dx + 13, center.dy - 10);

    final framePaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppTheme.cyanAccent, AppTheme.purpleAI],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawPath(framePath, framePaint);

    // Lens tints
    final lensPaint = Paint()
      ..color = AppTheme.cyanAccent.withOpacity(0.12)
      ..style = PaintingStyle.fill;
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center - Offset(38, 5), width: 48, height: 30),
        const Radius.circular(6),
      ),
      lensPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center + Offset(38, -5), width: 48, height: 30),
        const Radius.circular(6),
      ),
      lensPaint,
    );

    // Lens glowing target markers
    final markerPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(center - Offset(38, 5), 4, markerPaint);
    canvas.drawCircle(center + Offset(38, -5), 4, markerPaint);
  }

  @override
  bool shouldRepaint(covariant _SmartGlassesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
