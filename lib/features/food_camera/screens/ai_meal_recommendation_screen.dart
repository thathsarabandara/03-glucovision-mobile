import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class AiMealRecommendationScreen extends StatelessWidget {
  const AiMealRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'AI Optimization',
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                children: [
                  Text(
                    'Smart Alternatives',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Suggestions to optimize your postprandial glucose curve.',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildRecommendationCard(
                    context: context,
                    icon: LucideIcons.arrowRightLeft,
                    title: 'Swap White Rice for Quinoa',
                    description: 'Replacing white rice with quinoa will lower the glycemic load by approximately 35% and add 8g of dietary fiber.',
                    color: AppTheme.cyanAccent,
                    badgeText: 'Better Glucose Control',
                  ),
                  const SizedBox(height: 12),
                  
                  _buildRecommendationCard(
                    context: context,
                    icon: LucideIcons.plus,
                    title: 'Add Extra Olive Oil',
                    description: 'Adding 1 tbsp of olive oil to the greens will slow down gastric emptying, preventing a sharp post-meal glucose spike.',
                    color: AppTheme.emeraldHealth,
                    badgeText: 'Reduces Spike Risk',
                  ),
                  const SizedBox(height: 12),
                  
                  _buildRecommendationCard(
                    context: context,
                    icon: LucideIcons.clock,
                    title: 'Walk After Eating',
                    description: 'Taking a 10-minute light walk after this meal will immediately utilize the ingested carbohydrates.',
                    color: AppTheme.purpleAI,
                    badgeText: 'Activity Synergy',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            
            // Accept Action CTA
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.go('/dashboard');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.emeraldHealth,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(LucideIcons.check, size: 18),
                  label: const Text(
                    'Accept & Log Meal',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required String badgeText,
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
              fontSize: 11,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: color.withOpacity(0.35), width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              badgeText,
              style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
