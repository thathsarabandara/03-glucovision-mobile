import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class CookingAssistantHomeScreen extends StatelessWidget {
  const CookingAssistantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Cooking Assistant',
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
            // Hero section for Live Cooking
            GestureDetector(
              onTap: () => context.push('/live-cooking-camera'),
              child: GlassCard(
                padding: const EdgeInsets.all(0),
                borderRadius: 28,
                hasGlow: true,
                glowColor: AppTheme.purpleAI.withOpacity(0.08),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1556910103-1c02745a872f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.85), Colors.black.withOpacity(0.2)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(LucideIcons.camera, color: AppTheme.cyanAccent, size: 16),
                            SizedBox(width: 8),
                            Text(
                              'Live Cooking AI Mode',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Point your camera at the stove for real-time guidance and glycemic diagnostics.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            Text(
              'Recommended Recipes',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            _buildRecipeCard(
              context,
              'Low-GI Salmon Bowl',
              '25 mins • 450 kcal',
              'Ideal to support evening glycemic objectives.',
              AppTheme.emeraldHealth,
            ),
            const SizedBox(height: 12),
            
            _buildRecipeCard(
              context,
              'Almond Flour Pancakes',
              '15 mins • 320 kcal',
              'Great low-carb breakfast replacement option.',
              AppTheme.cyanAccent,
            ),
            const SizedBox(height: 12),
            
            _buildRecipeCard(
              context,
              'Zucchini Noodles & Pesto',
              '20 mins • 280 kcal',
              'Fiber-dense plate that minimizes spike probability.',
              AppTheme.purpleAI,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, String title, String subtitle, String description, Color accentColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.push('/recipe-guidance'),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        borderRadius: 22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(LucideIcons.utensils, color: accentColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: accentColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
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
      ),
    );
  }
}
