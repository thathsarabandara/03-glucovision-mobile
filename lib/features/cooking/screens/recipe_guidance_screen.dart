import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class RecipeGuidanceScreen extends StatefulWidget {
  const RecipeGuidanceScreen({super.key});

  @override
  State<RecipeGuidanceScreen> createState() => _RecipeGuidanceScreenState();
}

class _RecipeGuidanceScreenState extends State<RecipeGuidanceScreen> {
  int _currentStep = 0;

  final List<Map<String, dynamic>> _steps = [
    {
      'title': 'Prep Ingredients',
      'instruction': 'Wash the greens, slice the avocado, and pat the salmon fillet dry with a paper towel. Drying the salmon ensures a crispy skin.',
      'aiMod': null,
    },
    {
      'title': 'Heat the Pan',
      'instruction': 'Add 1 tbsp of olive oil to a skillet over medium-high heat.',
      'aiMod': 'AI Optimization: Reduced oil from 2 tbsp to 1 tbsp to save 120 kcal without compromising the sear.',
    },
    {
      'title': 'Sear Salmon',
      'instruction': 'Place salmon skin-side down. Sear for 3 minutes until crispy, then flip and cook for 2 more minutes.',
      'aiMod': null,
    },
    {
      'title': 'Assemble Bowl',
      'instruction': 'Place the mixed greens in a bowl. Top with quinoa, sliced avocado, and the seared salmon.',
      'aiMod': 'AI Substitution: Swapped white rice for quinoa to lower glycemic load by 35% based on your evening targets.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Recipe Guidance',
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
            icon: const Icon(LucideIcons.mic, color: AppTheme.cyanAccent, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Voice guidance activated. Speak "Next" or "Back" to navigate.'),
                  backgroundColor: AppTheme.purpleAI,
                ),
              );
            },
          ),
        ],
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
                    'Low-GI Salmon Bowl',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(LucideIcons.clock, size: 14, color: AppTheme.textSecondary),
                      const SizedBox(width: 6),
                      const Text('25 mins', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 16),
                      const Icon(LucideIcons.flame, size: 14, color: AppTheme.textSecondary),
                      const SizedBox(width: 6),
                      const Text('450 kcal', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Timeline Steps
                  ...List.generate(_steps.length, (index) {
                    return _buildStepCard(
                      index: index,
                      title: _steps[index]['title'],
                      instruction: _steps[index]['instruction'],
                      aiMod: _steps[index]['aiMod'],
                      isActive: _currentStep == index,
                      isCompleted: _currentStep > index,
                    );
                  }),
                ],
              ),
            ),
            
            // Bottom Controls
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.backgroundDark : Colors.white,
                border: Border(
                  top: BorderSide(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        onPressed: _currentStep > 0 ? () => setState(() => _currentStep--) : null,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.08)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Previous',
                          style: TextStyle(
                            color: isDark ? Colors.white70 : AppTheme.textPrimary,
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
                        onPressed: _currentStep < _steps.length - 1 
                            ? () => setState(() => _currentStep++) 
                            : () => context.go('/dashboard'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.cyanAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          _currentStep < _steps.length - 1 ? 'Next Step' : 'Finish & Log',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),
                        ),
                      ),
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

  Widget _buildStepCard({
    required int index,
    required String title,
    required String instruction,
    required String? aiMod,
    required bool isActive,
    required bool isCompleted,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color borderStatusColor = isActive ? AppTheme.cyanAccent : (isCompleted ? AppTheme.emeraldHealth : Colors.transparent);
    
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left status lines & markers
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCompleted 
                      ? AppTheme.emeraldHealth 
                      : (isActive ? AppTheme.cyanAccent : (isDark ? Colors.white.withOpacity(0.04) : Colors.white)),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted 
                        ? AppTheme.emeraldHealth 
                        : (isActive ? AppTheme.cyanAccent : (isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.06))),
                    width: 2,
                  ),
                ),
                child: isCompleted 
                    ? const Icon(LucideIcons.check, size: 12, color: Colors.white) 
                    : Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isActive ? Colors.black : AppTheme.textSecondary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              if (index < _steps.length - 1)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted 
                        ? AppTheme.emeraldHealth 
                        : (isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04)),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Step content GlassCard
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: GlassCard(
                padding: const EdgeInsets.all(18),
                borderRadius: 22,
                hasGlow: isActive,
                glowColor: AppTheme.cyanAccent.withOpacity(0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: isActive 
                            ? AppTheme.cyanAccent 
                            : (isCompleted ? AppTheme.emeraldHealth : (isDark ? Colors.white60 : AppTheme.textPrimary)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      instruction,
                      style: TextStyle(
                        color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                        fontSize: 11,
                        height: 1.45,
                      ),
                    ),
                    if (aiMod != null) ...[
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.purpleAI.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.purpleAI.withOpacity(0.35)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(LucideIcons.sparkles, color: AppTheme.purpleAI, size: 14),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                aiMod,
                                style: const TextStyle(color: AppTheme.purpleAI, fontSize: 10, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
