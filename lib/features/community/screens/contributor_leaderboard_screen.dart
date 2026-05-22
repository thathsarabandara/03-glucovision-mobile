import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class ContributorLeaderboardScreen extends StatelessWidget {
  const ContributorLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    final List<Map<String, dynamic>> leaders = [
      {'name': 'Thathsara B.', 'xp': '4,850', 'badge': 'Champion', 'color': AppTheme.warning},
      {'name': 'Anura K.', 'xp': '3,620', 'badge': 'Expert', 'color': AppTheme.cyanAccent},
      {'name': 'Priya F.', 'xp': '2,910', 'badge': 'Expert', 'color': AppTheme.cyanAccent},
      {'name': 'Nimal S.', 'xp': '1,540', 'badge': 'Contributor', 'color': AppTheme.purpleAI},
      {'name': 'Chamara M.', 'xp': '1,200', 'badge': 'Contributor', 'color': AppTheme.purpleAI},
    ];

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Health Contributors',
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
            const SizedBox(height: 12),
            // Top 3 Podium
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildPodiumItem(context, '2nd', leaders[1]['name']!, leaders[1]['xp']!, AppTheme.cyanAccent, 70),
                _buildPodiumItem(context, '1st', leaders[0]['name']!, leaders[0]['xp']!, AppTheme.warning, 100),
                _buildPodiumItem(context, '3rd', leaders[2]['name']!, leaders[2]['xp']!, AppTheme.purpleAI, 50),
              ],
            ),
            const SizedBox(height: 36),

            Text(
              'Leaderboard Standings',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            ...leaders.asMap().entries.map((entry) {
              final i = entry.key;
              final l = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  borderRadius: 22,
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        alignment: Alignment.center,
                        child: Text(
                          '#${i + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: i == 0 
                                ? AppTheme.warning 
                                : (isDark ? Colors.white60 : AppTheme.textSecondary),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: isDark ? Colors.white : AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: (l['color'] as Color).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                l['badge']!,
                                style: TextStyle(
                                  color: l['color'] as Color,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${l['xp']} XP',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppTheme.cyanAccent,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumItem(BuildContext context, String rank, String name, String xp, Color color, double height) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.6), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.08),
                blurRadius: 10,
              ),
            ],
          ),
          child: Icon(LucideIcons.user, color: color, size: 18),
        ),
        const SizedBox(height: 8),
        Text(
          name.split(' ').first,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppTheme.textPrimary,
          ),
        ),
        Text(
          '$xp XP',
          style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          width: 72,
          height: height,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            border: Border(
              top: BorderSide(color: color, width: 2),
              left: BorderSide(color: color.withOpacity(0.2)),
              right: BorderSide(color: color.withOpacity(0.2)),
            ),
          ),
          child: Center(
            child: Text(
              rank,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 14,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
