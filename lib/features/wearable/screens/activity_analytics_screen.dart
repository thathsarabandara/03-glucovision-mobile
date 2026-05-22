import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class ActivityAnalyticsScreen extends StatelessWidget {
  const ActivityAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Activity Analytics',
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
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          children: [
            // 1. Weekly Activity Chart
            GlassCard(
              padding: const EdgeInsets.all(20),
              borderRadius: 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Step Progress',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildActivityBar('M', 0.9, AppTheme.emeraldHealth),
                      _buildActivityBar('T', 0.6, AppTheme.emeraldHealth),
                      _buildActivityBar('W', 1.0, AppTheme.cyanAccent),
                      _buildActivityBar('T', 0.4, AppTheme.warning),
                      _buildActivityBar('F', 0.85, AppTheme.emeraldHealth),
                      _buildActivityBar('S', 0.3, AppTheme.error),
                      _buildActivityBar('S', 0.65, AppTheme.emeraldHealth, isToday: true),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Mon', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      const Text('Tue', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      const Text('Wed', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      const Text('Thu', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      const Text('Fri', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      const Text('Sat', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('Today', style: TextStyle(fontSize: 9, color: AppTheme.cyanAccent, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. Weekly Summary Stats Grid
            Row(
              children: [
                Expanded(child: _buildStatCard(context, 'Weekly Steps', '52,680', AppTheme.emeraldHealth, '+8% this week')),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard(context, 'Active Days', '5 / 7', AppTheme.cyanAccent, 'Target achieved')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildStatCard(context, 'Active Duration', '324 min', AppTheme.warning, 'Daily average: 46m')),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard(context, 'Calories Burned', '12,450', AppTheme.purpleAI, '+12% vs last week')),
              ],
            ),
            const SizedBox(height: 28),

            // 3. AI Movement Insight
            Text(
              'AI Movement Insights',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(20),
              borderRadius: 28,
              hasGlow: true,
              glowColor: AppTheme.cyanAccent.withOpacity(0.08),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LucideIcons.sparkles, color: AppTheme.cyanAccent, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Glycemic Regulation Success',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isDark ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your post-meal walks have reduced average glucose spikes by 22 mg/dL. Keep it up! You are on track to exceed last week\'s active recovery target.',
                          style: TextStyle(
                            color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                            fontSize: 11,
                            height: 1.45,
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
    );
  }

  Widget _buildActivityBar(String day, double fraction, Color color, {bool isToday = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 22,
          height: 90 * fraction,
          decoration: BoxDecoration(
            color: isToday ? color : color.withOpacity(0.45),
            borderRadius: BorderRadius.circular(8),
            boxShadow: isToday ? [BoxShadow(color: color.withOpacity(0.25), blurRadius: 6)] : null,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, Color color, String sub) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: TextStyle(
              fontSize: 9,
              color: isDark ? Colors.white38 : Colors.black38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
