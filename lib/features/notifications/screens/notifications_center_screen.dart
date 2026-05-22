import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class NotificationsCenterScreen extends StatelessWidget {
  const NotificationsCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Notifications',
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
          TextButton(
            onPressed: () {},
            child: Text(
              'Clear All',
              style: TextStyle(
                color: isDark ? Colors.white70 : AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          children: [
            _buildSection(context, 'Critical Medical Warnings', [
              _NotifItem(
                icon: LucideIcons.alertTriangle,
                color: AppTheme.error,
                title: 'Hyperglycemia Risk',
                body: 'Predicted glucose levels approaching 185 mg/dL in 45 min.',
                time: '2m ago',
                route: '/risk-alert',
              ),
            ]),
            const SizedBox(height: 20),
            _buildSection(context, 'Metabolic Performance', [
              _NotifItem(icon: LucideIcons.activity, color: AppTheme.cyanAccent, title: 'Daily TIR Achieved', body: 'You\'ve stayed in optimal target range for 88% of today.', time: '1h ago', route: '/glucose-dashboard'),
              _NotifItem(icon: LucideIcons.moon, color: AppTheme.purpleAI, title: 'Optimal Sleep Quality', body: '7h 12m recorded. Sleep efficiency score: 82/100.', time: '8h ago', route: '/sleep-analytics'),
            ]),
            const SizedBox(height: 20),
            _buildSection(context, 'AI Meal & Med Assistance', [
              _NotifItem(icon: LucideIcons.utensils, color: AppTheme.emeraldHealth, title: 'Glycemic Timing Suggestion', body: 'AI recommends a high-fiber snack before 1 PM to balance curves.', time: '30m ago', route: '/ai-assistant'),
              _NotifItem(icon: LucideIcons.pill, color: AppTheme.warning, title: 'Prescription Schedule', body: 'Evening medication window opens in 30 minutes.', time: '5m ago', route: '/ai-assistant'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<_NotifItem> items) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: GestureDetector(
            onTap: () => context.push(item.route),
            child: GlassCard(
              hasGlow: item.color == AppTheme.error,
              glowColor: item.color.withOpacity(0.08),
              borderRadius: 22,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: item.color, size: 18),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: isDark ? Colors.white : AppTheme.textPrimary,
                                ),
                              ),
                            ),
                            Text(
                              item.time,
                              style: const TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.body,
                          style: TextStyle(
                            color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ],
    );
  }
}

class _NotifItem {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  final String route;
  const _NotifItem({required this.icon, required this.color, required this.title, required this.body, required this.time, required this.route});
}
