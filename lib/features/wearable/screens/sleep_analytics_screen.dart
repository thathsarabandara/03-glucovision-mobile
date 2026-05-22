import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class SleepAnalyticsScreen extends StatelessWidget {
  const SleepAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Sleep Analytics',
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
            // 1. Sleep Score Card
            GlassCard(
              hasGlow: true,
              glowColor: AppTheme.purpleAI.withOpacity(0.08),
              borderRadius: 28,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(LucideIcons.moon, color: AppTheme.purpleAI, size: 36),
                  const SizedBox(height: 12),
                  const Text(
                    'Sleep Score',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '82',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.purpleAI,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const Text(
                    '/100 · Optimal Recovery',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSleepStat(context, 'Duration', '7h 12m', isDark ? Colors.white : AppTheme.textPrimary),
                      _buildSleepStat(context, 'Deep', '1h 44m', AppTheme.purpleAI),
                      _buildSleepStat(context, 'REM', '1h 22m', AppTheme.cyanAccent),
                      _buildSleepStat(context, 'Awake', '18m', AppTheme.warning),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. Sleep stages visual card
            GlassCard(
              padding: const EdgeInsets.all(20),
              borderRadius: 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sleep Stages Breakdown',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        Expanded(flex: 15, child: Container(height: 16, color: AppTheme.warning)),
                        Expanded(flex: 25, child: Container(height: 16, color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05))),
                        Expanded(flex: 35, child: Container(height: 16, color: AppTheme.purpleAI.withOpacity(0.75))),
                        Expanded(flex: 20, child: Container(height: 16, color: AppTheme.cyanAccent)),
                        Expanded(flex: 5, child: Container(height: 16, color: AppTheme.warning.withOpacity(0.5))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _buildStageLegend('Awake', AppTheme.warning),
                      _buildStageLegend('Light', isDark ? Colors.white24 : Colors.black26),
                      _buildStageLegend('Deep', AppTheme.purpleAI),
                      _buildStageLegend('REM', AppTheme.cyanAccent),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('11:00 PM', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('2:00 AM', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('5:00 AM', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('7:00 AM', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. Glucose-Sleep Correlation
            GlassCard(
              padding: const EdgeInsets.all(20),
              borderRadius: 28,
              hasGlow: true,
              glowColor: AppTheme.emeraldHealth.withOpacity(0.08),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LucideIcons.activity, color: AppTheme.emeraldHealth, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Glucose-Sleep Connection',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isDark ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your deep sleep duration correlates directly with lower fasting glucose levels (averaging 92 mg/dL vs 108 mg/dL on low sleep nights).',
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
            const SizedBox(height: 16),

            // 4. Weekly Sleep trend bars
            GlassCard(
              padding: const EdgeInsets.all(20),
              borderRadius: 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7-Day Trend',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildNightBar('M', 0.75),
                      _buildNightBar('T', 0.55),
                      _buildNightBar('W', 0.90),
                      _buildNightBar('T', 0.65),
                      _buildNightBar('F', 0.80),
                      _buildNightBar('S', 0.95),
                      _buildNightBar('S', 0.85, isToday: true),
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
                      Text('Sun', style: TextStyle(fontSize: 9, color: AppTheme.purpleAI, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepStat(BuildContext context, String label, String value, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: color == AppTheme.textPrimary ? (isDark ? Colors.white : AppTheme.textPrimary) : color,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStageLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildNightBar(String label, double fraction, {bool isToday = false}) {
    return Container(
      width: 22,
      height: 70 * fraction,
      decoration: BoxDecoration(
        color: isToday ? AppTheme.purpleAI : AppTheme.purpleAI.withOpacity(0.35),
        borderRadius: BorderRadius.circular(8),
        boxShadow: isToday ? [BoxShadow(color: AppTheme.purpleAI.withOpacity(0.25), blurRadius: 6)] : null,
      ),
    );
  }
}
