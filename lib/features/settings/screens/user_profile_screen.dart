import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Profile & Settings',
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
            // Profile Header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.cyanAccent.withOpacity(0.6), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.cyanAccent.withOpacity(0.08),
                          blurRadius: 16,
                        )
                      ],
                      image: const DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/150?img=33'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Alex Fernando',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Type 2 Diabetes  •  Since 2021',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.emeraldHealth.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.emeraldHealth.withOpacity(0.35), width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(LucideIcons.award, color: AppTheme.emeraldHealth, size: 14),
                        SizedBox(width: 6),
                        Text(
                          'Champion Contributor',
                          style: TextStyle(color: AppTheme.emeraldHealth, fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Health Summary Stats Panel
            GlassCard(
              padding: const EdgeInsets.all(16),
              borderRadius: 26,
              hasGlow: true,
              glowColor: AppTheme.emeraldHealth.withOpacity(0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildProfileStat(context, 'HbA1c', '6.4%', AppTheme.emeraldHealth),
                  Container(width: 1, height: 32, color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
                  _buildProfileStat(context, 'Target BG', '70-140', AppTheme.cyanAccent),
                  Container(width: 1, height: 32, color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
                  _buildProfileStat(context, 'Streak', '14 days', AppTheme.warning),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Settings navigation groups
            _buildNavGroup(context, 'Health Parameters', [
              _buildNavItem(context, LucideIcons.heart, 'Health Preferences', '/health-preferences', AppTheme.emeraldHealth),
              _buildNavItem(context, LucideIcons.watch, 'Device Configurations', '/device-management', AppTheme.cyanAccent),
            ]),
            const SizedBox(height: 20),
            _buildNavGroup(context, 'Account Configuration', [
              _buildNavItem(context, LucideIcons.shield, 'Privacy & Security', '/privacy-security', AppTheme.purpleAI),
              _buildNavItem(context, LucideIcons.languages, 'Language Settings', '/language-settings', AppTheme.warning),
              _buildNavItem(context, LucideIcons.cloudOff, 'Offline Sync Database', '/offline-sync', AppTheme.cyanAccent),
            ]),
            const SizedBox(height: 28),
            
            SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(LucideIcons.logOut, size: 14, color: AppTheme.error),
                label: const Text('Sign Out', style: TextStyle(color: AppTheme.error, fontWeight: FontWeight.bold, fontSize: 13)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.error.withOpacity(0.35), width: 1.5),
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

  Widget _buildProfileStat(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color, letterSpacing: -0.5),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildNavGroup(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, String route, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 22,
        child: InkWell(
          onTap: () => context.push(route),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
              ),
              const Icon(LucideIcons.chevronRight, color: AppTheme.textSecondary, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
