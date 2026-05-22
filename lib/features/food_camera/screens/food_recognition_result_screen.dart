import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class FoodRecognitionResultScreen extends StatelessWidget {
  const FoodRecognitionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Analysis Results',
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Image Thumbnail with premium glow
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.cyanAccent.withOpacity(0.08),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              
              const Text(
                'Detected Meal',
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Grilled Chicken & Avocado Salad',
                style: TextStyle(
                  color: AppTheme.cyanAccent,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 24),

              // 2. Nutrition Summary Card
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
                          'Estimated Nutrition',
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNutritionStat('Calories', '450', 'kcal', AppTheme.warning),
                        _buildNutritionStat('Carbs', '12', 'g', AppTheme.cyanAccent),
                        _buildNutritionStat('Protein', '42', 'g', AppTheme.emeraldHealth),
                        _buildNutritionStat('Fat', '22', 'g', AppTheme.purpleAI),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 3. Detected Ingredients Card
              GlassCard(
                padding: const EdgeInsets.all(20),
                borderRadius: 26,
                hasGlow: true,
                glowColor: AppTheme.cyanAccent.withOpacity(0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(LucideIcons.listTodo, color: isDark ? Colors.white70 : AppTheme.textSecondary, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Ingredients',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: isDark ? Colors.white : AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => context.push('/ingredient-detection'),
                          child: const Text(
                            'Breakdown',
                            style: TextStyle(color: AppTheme.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildIngredientItem(context, 'Grilled Chicken Breast', '98% match'),
                    const SizedBox(height: 10),
                    _buildIngredientItem(context, 'Fresh Avocado Slice', '95% match'),
                    const SizedBox(height: 10),
                    _buildIngredientItem(context, 'Mixed Leaf Greens', '99% match'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 4. Action Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () => context.push('/meal-nutrition-analysis'),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.08)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Full Report',
                          style: TextStyle(
                            color: isDark ? Colors.white : AppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => context.go('/dashboard'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.cyanAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Log Meal',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () => context.push('/ai-meal-recommendation'),
                  icon: const Icon(LucideIcons.sparkles, color: AppTheme.purpleAI, size: 14),
                  label: const Text(
                    'See Personalized AI Suggestions',
                    style: TextStyle(
                      color: AppTheme.purpleAI,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionStat(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          unit,
          style: TextStyle(fontSize: 10, color: color.withOpacity(0.8), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildIngredientItem(BuildContext context, String name, String confidence) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white70 : AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.emeraldHealth.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            confidence,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.emeraldHealth,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
