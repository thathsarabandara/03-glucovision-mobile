import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class CookingAnalysisScreen extends StatelessWidget {
  const CookingAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Cooking Analysis',
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
            // Alert Card
            GlassCard(
              padding: const EdgeInsets.all(24),
              borderRadius: 28,
              hasGlow: true,
              glowColor: AppTheme.warning.withOpacity(0.08),
              child: Column(
                children: [
                  const Icon(LucideIcons.alertTriangle, color: AppTheme.warning, size: 40),
                  const SizedBox(height: 16),
                  Text(
                    'High Heat Detected',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The olive oil in the pan is approaching its smoke point (410°F). Heating oil beyond this point degrades its healthy monounsaturated fat properties.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                      fontSize: 11,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.warning,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Reduce Heat Now',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            
            Text(
              'Cooking Suggestions',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildSuggestionCard(
              context: context,
              icon: LucideIcons.droplet,
              title: 'Oil Quantity Alert',
              description: 'Approximately 2.5 tbsp of oil detected (~300 kcal). Consider using 1 tbsp and adding a splash of bone broth if the pan gets dry.',
              color: AppTheme.error,
            ),
            const SizedBox(height: 12),
            
            _buildSuggestionCard(
              context: context,
              icon: LucideIcons.flame,
              title: 'Optimal Searing Profile',
              description: 'For best glycemic control and nutrient preservation, sear salmon for 3 mins per side. Avoid charring surfaces.',
              color: AppTheme.emeraldHealth,
            ),
            
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () => context.push('/recipe-guidance'),
                icon: Icon(LucideIcons.bookOpen, color: isDark ? Colors.white70 : AppTheme.textPrimary, size: 16),
                label: Text(
                  'Return to Recipe Guidance',
                  style: TextStyle(color: isDark ? Colors.white70 : AppTheme.textPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.08)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
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
    );
  }
}
