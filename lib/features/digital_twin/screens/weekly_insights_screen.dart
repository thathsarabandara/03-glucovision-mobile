import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class WeeklyInsightsScreen extends StatelessWidget {
  const WeeklyInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Insights'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            Text('Oct 18 – Oct 24, 2026', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.cyanAccent)),
            const SizedBox(height: 8),
            Text('Weekly Summary', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 28)),
            const SizedBox(height: 24),

            // AI Summary Card
            GlassCard(
              hasGlow: true,
              glowColor: AppTheme.cyanAccent,
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LucideIcons.sparkles, color: AppTheme.cyanAccent),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This was your best week for Time-in-Range (88% TIR) in the past 2 months. Your consistent post-meal walks made the biggest impact. Keep up this pattern!',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5, color: AppTheme.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Comparison Grid
            Row(
              children: [
                Expanded(child: _buildCompareCard(context, 'Avg Glucose', '114', '121', true, AppTheme.emeraldHealth)),
                const SizedBox(width: 16),
                Expanded(child: _buildCompareCard(context, 'TIR %', '88%', '78%', true, AppTheme.cyanAccent)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildCompareCard(context, 'Active Min', '324', '290', true, AppTheme.emeraldHealth)),
                const SizedBox(width: 16),
                Expanded(child: _buildCompareCard(context, 'Avg Sleep', '7h 20m', '6h 45m', true, AppTheme.purpleAI)),
              ],
            ),
            const SizedBox(height: 32),

            Text('Progress Tracking', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20)),
            const SizedBox(height: 16),

            _buildProgressRow(context, 'Step Goal (10k/day)', 5, 7, AppTheme.emeraldHealth),
            const SizedBox(height: 12),
            _buildProgressRow(context, 'TIR Goal (>80%)', 6, 7, AppTheme.cyanAccent),
            const SizedBox(height: 12),
            _buildProgressRow(context, 'Sleep Goal (7+ hrs)', 4, 7, AppTheme.purpleAI),
            const SizedBox(height: 12),
            _buildProgressRow(context, 'Meal Logging', 7, 7, AppTheme.warning),
          ],
        ),
      ),
    );
  }

  Widget _buildCompareCard(BuildContext context, String label, String thisWeek, String lastWeek, bool improved, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
          const SizedBox(height: 8),
          Text(thisWeek, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(improved ? LucideIcons.arrowUp : LucideIcons.arrowDown, size: 12, color: improved ? AppTheme.emeraldHealth : AppTheme.error),
              const SizedBox(width: 2),
              Text('vs $lastWeek', style: TextStyle(fontSize: 10, color: improved ? AppTheme.emeraldHealth : AppTheme.error)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow(BuildContext context, String label, int achieved, int total, Color color) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text('$achieved/$total days', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: achieved / total,
            backgroundColor: AppTheme.surfaceHighlight,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
