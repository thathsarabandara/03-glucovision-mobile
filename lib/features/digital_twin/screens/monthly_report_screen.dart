import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class MonthlyReportScreen extends StatelessWidget {
  const MonthlyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Report'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.download, color: AppTheme.cyanAccent),
            onPressed: () {
              // TODO: Export PDF
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            Text('October 2026', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.cyanAccent)),
            const SizedBox(height: 4),
            Text('Monthly Health Report', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 26)),
            const SizedBox(height: 24),

            // HbA1c Estimate
            GlassCard(
              hasGlow: true,
              glowColor: AppTheme.emeraldHealth,
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Estimated HbA1c', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '6.4',
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 48, color: AppTheme.emeraldHealth),
                              ),
                              const TextSpan(
                                text: ' %',
                                style: TextStyle(fontSize: 20, color: AppTheme.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('Near Non-Diabetic Range  ✓', style: TextStyle(color: AppTheme.emeraldHealth, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 80, color: AppTheme.surfaceHighlight),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMonthStat('Avg Glucose', '112 mg/dL', AppTheme.textPrimary),
                      const SizedBox(height: 8),
                      _buildMonthStat('Avg TIR', '85%', AppTheme.cyanAccent),
                      const SizedBox(height: 8),
                      _buildMonthStat('Low Events', '4', AppTheme.warning),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 30-day mini bar chart
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('30-Day Glucose Stability', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 80,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(30, (i) {
                        final heights = [0.7, 0.6, 0.8, 0.5, 0.9, 0.7, 0.8, 0.6, 0.75, 0.85, 0.55, 0.9, 0.7, 0.65, 0.8, 0.9, 0.7, 0.85, 0.6, 0.75, 0.8, 0.9, 0.7, 0.65, 0.85, 0.8, 0.9, 0.7, 0.75, 0.88];
                        final h = heights[i];
                        final c = h > 0.8 ? AppTheme.emeraldHealth : h > 0.6 ? AppTheme.cyanAccent : AppTheme.warning;
                        return Container(
                          width: 5,
                          height: 80 * h,
                          decoration: BoxDecoration(color: c.withOpacity(0.8), borderRadius: BorderRadius.circular(3)),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Oct 1', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                      Text('Oct 15', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                      Text('Oct 24', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Export button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.fileText, size: 16),
                label: const Text('Export PDF Report for Doctor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.cyanAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
