import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class FoodContributionScreen extends StatelessWidget {
  const FoodContributionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Contribute Food Data',
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
                  // Upload Zone
                  GestureDetector(
                    onTap: () {},
                    child: GlassCard(
                      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
                      borderRadius: 28,
                      hasGlow: true,
                      glowColor: AppTheme.emeraldHealth.withOpacity(0.08),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.emeraldHealth.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(LucideIcons.cameraOff, color: AppTheme.emeraldHealth, size: 28),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Upload Food Photo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: isDark ? Colors.white : AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Supports PNG, JPG, or HEIC format',
                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Inputs
                  TextField(
                    style: TextStyle(color: isDark ? Colors.white : AppTheme.textPrimary, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Food Name (e.g. Rice Kottu Roti)',
                      prefixIcon: const Icon(LucideIcons.tag, color: AppTheme.textSecondary, size: 18),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.cyanAccent, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    style: TextStyle(color: isDark ? Colors.white : AppTheme.textPrimary, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Country / Region of Origin',
                      prefixIcon: const Icon(LucideIcons.globe2, color: AppTheme.textSecondary, size: 18),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.cyanAccent, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    maxLines: 3,
                    style: TextStyle(color: isDark ? Colors.white : AppTheme.textPrimary, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Main Ingredients (comma-separated)',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: Icon(LucideIcons.list, color: AppTheme.textSecondary, size: 18),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.cyanAccent, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 22,
                    child: Row(
                      children: [
                        const Icon(LucideIcons.award, color: AppTheme.cyanAccent, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Each approved contribution earns +50 XP and helps train custom local AI models for metabolic health.',
                            style: TextStyle(
                              color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                              fontSize: 10,
                              height: 1.45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Actions
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/dataset-validation'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.cyanAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(LucideIcons.send, color: Colors.black, size: 16),
                  label: const Text(
                    'Submit Contribution',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
