import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            // Health Score
            GlassCard(
              hasGlow: true,
              glowColor: AppTheme.emeraldHealth,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('AI Health Score', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const Icon(LucideIcons.sparkles, color: AppTheme.purpleAI),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: CircularProgressIndicator(
                          value: 0.82,
                          strokeWidth: 12,
                          backgroundColor: AppTheme.surfaceHighlight,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.emeraldHealth),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        children: [
                          Text('82', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40, color: AppTheme.emeraldHealth)),
                          const Text('/100', style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildScorePillar('Glucose\nControl', '88%', AppTheme.cyanAccent),
                      _buildScorePillar('Nutrition\nBalance', '74%', AppTheme.warning),
                      _buildScorePillar('Activity\nLevel', '85%', AppTheme.emeraldHealth),
                      _buildScorePillar('Sleep\nQuality', '80%', AppTheme.purpleAI),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Navigation Cards
            Row(
              children: [
                Expanded(
                  child: _buildNavCard(
                    context,
                    icon: LucideIcons.calendarDays,
                    label: 'Weekly\nInsights',
                    route: '/weekly-insights',
                    color: AppTheme.cyanAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNavCard(
                    context,
                    icon: LucideIcons.fileBarChart,
                    label: 'Monthly\nReport',
                    route: '/monthly-report',
                    color: AppTheme.emeraldHealth,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildNavCard(
                    context,
                    icon: LucideIcons.cpu,
                    label: 'Digital\nTwin',
                    route: '/digital-twin',
                    color: AppTheme.purpleAI,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNavCard(
                    context,
                    icon: LucideIcons.flaskConical,
                    label: 'What-If\nSimulation',
                    route: '/what-if-simulation',
                    color: AppTheme.warning,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Insight
            GlassCard(
              padding: const EdgeInsets.all(16),
              hasGlow: true,
              glowColor: AppTheme.purpleAI,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LucideIcons.trendingUp, color: AppTheme.purpleAI),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Trend Observation', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          'Your glucose stability has improved by 18% over the last 30 days. Your digital twin predicts continued improvement if your sleep goal is maintained.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12, height: 1.4),
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

  Widget _buildScorePillar(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, height: 1.3)),
      ],
    );
  }

  Widget _buildNavCard(BuildContext context, {required IconData icon, required String label, required String route, required Color color}) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 16),
            Text(label, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, height: 1.3)),
          ],
        ),
      ),
    );
  }
}
