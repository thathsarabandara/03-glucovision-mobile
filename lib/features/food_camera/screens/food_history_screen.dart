import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class FoodHistoryScreen extends StatelessWidget {
  const FoodHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Meal History',
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
            // Timeline Header 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today, Oct 24',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.calendar, size: 14),
                  label: const Text('Filter', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  style: TextButton.styleFrom(foregroundColor: AppTheme.cyanAccent),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildHistoryMealCard(
              context: context,
              time: '12:30 PM',
              type: 'Lunch',
              description: 'Grilled Chicken Salad',
              calories: '450',
              impact: 'Low Impact',
              impactColor: AppTheme.emeraldHealth,
            ),
            const SizedBox(height: 12),
            
            _buildHistoryMealCard(
              context: context,
              time: '8:00 AM',
              type: 'Breakfast',
              description: 'Oatmeal & Berries',
              calories: '320',
              impact: 'Moderate Impact',
              impactColor: AppTheme.warning,
            ),

            const SizedBox(height: 28),
            
            // Timeline Header 2
            Text(
              'Yesterday, Oct 23',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            _buildHistoryMealCard(
              context: context,
              time: '7:00 PM',
              type: 'Dinner',
              description: 'Salmon and Quinoa',
              calories: '550',
              impact: 'Low Impact',
              impactColor: AppTheme.emeraldHealth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryMealCard({
    required BuildContext context,
    required String time,
    required String type,
    required String description,
    required String calories,
    required String impact,
    required Color impactColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: isDark ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                type,
                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Container(
            width: 1.5,
            height: 48,
            color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$calories kcal',
                      style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(color: impactColor, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          impact,
                          style: TextStyle(color: impactColor, fontSize: 10, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
