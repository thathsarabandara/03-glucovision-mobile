import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/stylized_3d_icon.dart';

class AiSuggestionsFeedScreen extends StatelessWidget {
  const AiSuggestionsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'AI Suggestions',
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
            Text(
              'Personalized Insights',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Computed from your recent glucose and activity vitals.',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // 1. Critical Hypoglycemia Alert Card (Red Glow)
            _buildInsightCard(
              context: context,
              iconType: StylizedIconType.heart,
              title: 'Hypoglycemia Risk Detected',
              description: 'Your glucose trend is dropping sharply (-2 mg/dL/min). We suggest consuming 15g of fast-acting carbs immediately to prevent a low.',
              color: AppTheme.error,
              isCritical: true,
              actionText: 'Log Carbs',
              onActionTap: () => context.push('/glucose-manual-entry'),
            ),
            const SizedBox(height: 16),

            // 2. Health Sensitivity Improvement Card (Emerald Glow)
            _buildInsightCard(
              context: context,
              iconType: StylizedIconType.recovery,
              title: 'Optimal Insulin Sensitivity',
              description: 'Your morning walk has increased your insulin sensitivity. Consider reducing your lunch bolus by 10% to stay in range.',
              color: AppTheme.emeraldHealth,
              actionText: 'Adjust Bolus',
              onActionTap: () {},
            ),
            const SizedBox(height: 16),

            // 3. Streak Reward Card (Cyan Glow)
            _buildInsightCard(
              context: context,
              iconType: StylizedIconType.steps,
              title: 'Streak Maintained!',
              description: 'You\'ve stayed in your target range (70-140 mg/dL) for 85% of the day. This is 15% better than last week!',
              color: AppTheme.cyanAccent,
            ),
            const SizedBox(height: 16),

            // 4. Digital Twin Prediction Card (Purple Glow)
            _buildInsightCard(
              context: context,
              iconType: StylizedIconType.calories,
              title: 'Dinner Prediction',
              description: 'Based on your digital twin simulation, a high-carb dinner tonight might cause a spike. We recommend a protein-rich meal instead.',
              color: AppTheme.purpleAI,
              actionText: 'View AI Recipes',
              onActionTap: () => context.push('/cooking-assistant'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required BuildContext context,
    required StylizedIconType iconType,
    required String title,
    required String description,
    required Color color,
    bool isCritical = false,
    String? actionText,
    VoidCallback? onActionTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 26,
      hasGlow: true,
      glowColor: color.withOpacity(0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stylized3DIcon(
                type: iconType,
                size: 40,
                baseColor: color,
                animate: isCritical,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: isCritical ? color : (isDark ? Colors.white : AppTheme.textPrimary),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              height: 1.45,
              color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
            ),
          ),
          if (actionText != null && onActionTap != null) ...[
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: onActionTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                  side: BorderSide(color: color.withOpacity(0.4), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: const Size(0, 36),
                ),
                child: Text(
                  actionText,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
