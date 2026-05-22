import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/stylized_3d_icon.dart';

class WearableDashboardScreen extends StatelessWidget {
  const WearableDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Wearable Hub',
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
            icon: Icon(LucideIcons.plus, color: isDark ? Colors.white : AppTheme.textPrimary),
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
              // 1. Premium Glowing Device Card
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                borderRadius: 28,
                hasGlow: true,
                glowColor: AppTheme.cyanAccent.withOpacity(0.12),
                child: Row(
                  children: [
                    Stylized3DIcon(
                      type: StylizedIconType.watch,
                      size: 64,
                      baseColor: AppTheme.cyanAccent,
                      animate: true,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Samsung Galaxy Fit 3',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: isDark ? Colors.white : AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppTheme.emeraldHealth,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Connected',
                                style: TextStyle(
                                  color: AppTheme.emeraldHealth,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Icon(LucideIcons.battery, color: AppTheme.textSecondary, size: 14),
                              const SizedBox(width: 4),
                              const Text(
                                '68%',
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(LucideIcons.chevronRight, color: AppTheme.textSecondary),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 2. Metrics Title
              Text(
                'Today\'s Metrics',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // 3. Metrics Grid (2x2) with circular progress indicators
              Row(
                children: [
                  Expanded(
                    child: _buildCircularMetricCard(
                      context: context,
                      title: 'Steps',
                      value: '6,540',
                      target: '/ 10,000',
                      progress: 0.65,
                      color: AppTheme.emeraldHealth,
                      iconType: StylizedIconType.steps,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCircularMetricCard(
                      context: context,
                      title: 'Heart Rate',
                      value: '72 bpm',
                      target: 'Resting avg',
                      progress: 0.72,
                      color: AppTheme.error,
                      iconType: StylizedIconType.heart,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildCircularMetricCard(
                      context: context,
                      title: 'Calories',
                      value: '1,840',
                      target: '/ 2,100 kcal',
                      progress: 0.87,
                      color: AppTheme.warning,
                      iconType: StylizedIconType.calories,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCircularMetricCard(
                      context: context,
                      title: 'Sleep Sync',
                      value: '7h 12m',
                      target: '8h target',
                      progress: 0.9,
                      color: AppTheme.purpleAI,
                      iconType: StylizedIconType.watch,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 4. Navigation Tiles Title
              Text(
                'Detailed Analytics',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              
              // 5. Navigation Tiles
              _buildNavTile(context, LucideIcons.activity, 'Activity Trends', '/activity-analytics', AppTheme.emeraldHealth),
              const SizedBox(height: 12),
              _buildNavTile(context, LucideIcons.moon, 'Sleep Analytics', '/sleep-analytics', AppTheme.purpleAI),
              const SizedBox(height: 12),
              _buildNavTile(context, LucideIcons.heartPulse, 'Heart Rate Trends', '/heart-rate-trends', AppTheme.error),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularMetricCard({
    required BuildContext context,
    required String title,
    required String value,
    required String target,
    required double progress,
    required Color color,
    required StylizedIconType iconType,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 24,
      hasGlow: true,
      glowColor: color.withOpacity(0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Stylized3DIcon(
                type: iconType,
                size: 28,
                baseColor: color,
                animate: false,
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Value & circular dial row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      target,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Custom mini circular dial
              SizedBox(
                width: 36,
                height: 36,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      backgroundColor: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      strokeWidth: 4.0,
                    ),
                    Icon(
                      progress >= 0.8 ? LucideIcons.check : LucideIcons.trendingUp,
                      size: 12,
                      color: color,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile(BuildContext context, IconData icon, String label, String route, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () => context.push(route),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        borderRadius: 20,
        hasGlow: true,
        glowColor: color.withOpacity(0.05),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            const Icon(LucideIcons.chevronRight, color: AppTheme.textSecondary, size: 16),
          ],
        ),
      ),
    );
  }
}
