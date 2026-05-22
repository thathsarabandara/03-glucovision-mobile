import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class CommunityFeedScreen extends StatelessWidget {
  const CommunityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Community Dataset',
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
          TextButton(
            onPressed: () => context.push('/contributor-leaderboard'),
            child: const Text(
              'Leaderboard',
              style: TextStyle(color: AppTheme.cyanAccent, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/food-contribution'),
        backgroundColor: AppTheme.emeraldHealth,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: const Icon(LucideIcons.upload, color: Colors.black, size: 16),
        label: const Text(
          'Contribute',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          children: [
            // Stats Banner
            GlassCard(
              padding: const EdgeInsets.all(20),
              borderRadius: 28,
              hasGlow: true,
              glowColor: AppTheme.emeraldHealth.withOpacity(0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(context, '14,820', 'Foods', AppTheme.emeraldHealth),
                  Container(width: 1, height: 32, color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
                  _buildStat(context, '2,341', 'Contributors', AppTheme.cyanAccent),
                  Container(width: 1, height: 32, color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
                  _buildStat(context, '98.2%', 'Accuracy', AppTheme.purpleAI),
                ],
              ),
            ),
            const SizedBox(height: 28),

            Text(
              'Recent Contributions',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            _buildFoodItem(context, 'Rice Kottu Roti (Sri Lanka)', 'Thathsara B.', 'Verified', AppTheme.emeraldHealth),
            const SizedBox(height: 10),
            _buildFoodItem(context, 'Idiyappam with Coconut', 'Anura K.', 'Verified', AppTheme.emeraldHealth),
            const SizedBox(height: 10),
            _buildFoodItem(context, 'Hoppers (Appam)', 'Nimal S.', 'Pending Review', AppTheme.warning),
            const SizedBox(height: 10),
            _buildFoodItem(context, 'Pol Roti', 'Chamara M.', 'Pending Votes', AppTheme.cyanAccent),
            const SizedBox(height: 10),
            _buildFoodItem(context, 'String Hoppers', 'Priya F.', 'Verified', AppTheme.emeraldHealth),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: color,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFoodItem(BuildContext context, String name, String contributor, String status, Color statusColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.04) : const Color(0xFFF0F2F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(LucideIcons.utensils, color: AppTheme.textSecondary, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'by $contributor',
                  style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: statusColor.withOpacity(0.35), width: 1.5),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 8, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
