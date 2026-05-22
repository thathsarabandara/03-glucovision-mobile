import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/stylized_3d_icon.dart';

class DailyHealthSummaryScreen extends StatelessWidget {
  const DailyHealthSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Daily Summary',
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
            icon: Icon(LucideIcons.calendar, color: isDark ? Colors.white : AppTheme.textPrimary, size: 20),
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
              Text(
                'Today\'s Overview',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'October 24, 2026 · Vitals & Intake summary',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // 1. Glucose Overview Card
              GlassCard(
                padding: const EdgeInsets.all(20),
                borderRadius: 26,
                hasGlow: true,
                glowColor: AppTheme.cyanAccent.withOpacity(0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.activity, color: AppTheme.cyanAccent, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Glucose Balance',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isDark ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryStatItem(context, 'Average', '115', 'mg/dL', isDark ? Colors.white : AppTheme.textPrimary),
                        _buildSummaryStatItem(context, 'In Range', '88', '%', AppTheme.emeraldHealth),
                        _buildSummaryStatItem(context, 'Variability', '18', '%', AppTheme.cyanAccent),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. Nutrition Overview Card (Calories)
              GlassCard(
                padding: const EdgeInsets.all(20),
                borderRadius: 26,
                hasGlow: true,
                glowColor: AppTheme.warning.withOpacity(0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.flame, color: AppTheme.warning, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Nutrition & Macros',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isDark ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1,450',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.warning,
                                  letterSpacing: -1.0,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'kcal consumed today',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1.5,
                          height: 60,
                          color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _MacroRow(label: 'Carbs', value: '150g', percent: 0.6, color: AppTheme.cyanAccent),
                                const SizedBox(height: 10),
                                _MacroRow(label: 'Protein', value: '80g', percent: 0.8, color: AppTheme.emeraldHealth),
                                const SizedBox(height: 10),
                                _MacroRow(label: 'Fat', value: '45g', percent: 0.5, color: AppTheme.purpleAI),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 3. Grid Row: Activity & Hydration
              Row(
                children: [
                  Expanded(
                    child: _buildGridSummaryCard(
                      context: context,
                      iconType: StylizedIconType.steps,
                      title: 'Activity',
                      value: '6,540',
                      subtitle: 'steps logged',
                      color: AppTheme.emeraldHealth,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildGridSummaryCard(
                      context: context,
                      iconType: StylizedIconType.watch,
                      title: 'Hydration',
                      value: '1.5 L',
                      subtitle: 'target 2.5 L',
                      color: AppTheme.cyanAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryStatItem(BuildContext context, String label, String value, String unit, Color valueColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: valueColor,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              unit,
              style: TextStyle(
                fontSize: 10,
                color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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

  Widget _buildGridSummaryCard({
    required BuildContext context,
    required StylizedIconType iconType,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 26,
      hasGlow: true,
      glowColor: color.withOpacity(0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stylized3DIcon(
            type: iconType,
            size: 36,
            baseColor: color,
            animate: false,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MacroRow extends StatelessWidget {
  final String label;
  final String value;
  final double percent;
  final Color color;

  const _MacroRow({
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 42,
          child: Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.white.withOpacity(0.06) 
                  : Colors.black.withOpacity(0.04),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 5.0,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 32,
          child: Text(
            value,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
