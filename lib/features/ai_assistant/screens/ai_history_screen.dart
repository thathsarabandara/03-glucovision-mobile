import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class AiHistoryScreen extends StatelessWidget {
  const AiHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'AI Memory',
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
              'What AI Remembers',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Key health context gathered from past AI assistant interactions.',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // AI Memory Summary
            GlassCard(
              padding: const EdgeInsets.all(20),
              borderRadius: 26,
              hasGlow: true,
              glowColor: AppTheme.purpleAI.withOpacity(0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.brainCircuit, color: AppTheme.purpleAI, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Core Personal Context',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: isDark ? Colors.white : AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildMemoryChip('Type 2 Diabetes', AppTheme.emeraldHealth),
                      _buildMemoryChip('Prefers Vegetarian Dinners', AppTheme.cyanAccent),
                      _buildMemoryChip('Morning Spikes Common', AppTheme.warning),
                      _buildMemoryChip('Allergic to Peanuts', AppTheme.error),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            Text(
              'Recent Conversations',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildHistoryTile(
              context: context,
              title: 'Post-Lunch Glucose Spike Analysis',
              date: 'Today, 2:30 PM',
              icon: LucideIcons.trendingUp,
              color: AppTheme.warning,
            ),
            const SizedBox(height: 10),
            _buildHistoryTile(
              context: context,
              title: 'Dinner Recipe Modification',
              date: 'Yesterday, 6:00 PM',
              icon: LucideIcons.utensils,
              color: AppTheme.emeraldHealth,
            ),
            const SizedBox(height: 10),
            _buildHistoryTile(
              context: context,
              title: 'Weekly Digital Twin Review',
              date: 'Oct 20, 10:00 AM',
              icon: LucideIcons.activity,
              color: AppTheme.cyanAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHistoryTile({
    required BuildContext context,
    required String title,
    required String date,
    required IconData icon,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(LucideIcons.chevronRight, color: isDark ? Colors.white38 : AppTheme.textSecondary, size: 16),
        ],
      ),
    );
  }
}
