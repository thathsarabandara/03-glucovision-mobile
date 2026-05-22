import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Privacy & Security',
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
            // Shield Status Card
            GlassCard(
              padding: const EdgeInsets.all(18),
              borderRadius: 28,
              hasGlow: true,
              glowColor: AppTheme.emeraldHealth.withOpacity(0.08),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.emeraldHealth.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.shieldCheck, color: AppTheme.emeraldHealth, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Privacy Protected',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isDark ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'All health metrics are encrypted with AES-256 and processed locally.',
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
            const SizedBox(height: 24),

            _buildToggleSection(context, 'Biometrics', [
              _buildToggle(context, LucideIcons.fingerprint, 'Biometric Login', 'Use fingerprint or Face ID', true),
            ]),
            const SizedBox(height: 20),

            _buildToggleSection(context, 'Data & Sharing', [
              _buildToggle(context, LucideIcons.cloud, 'Cloud Database Sync', 'Sync data to secure cloud storage', true),
              _buildToggle(context, LucideIcons.users, 'Share with Caregiver', 'Allow authorized caregiver access', false),
              _buildToggle(context, LucideIcons.flaskConical, 'Research Participation', 'Contribute anonymized data datasets', false),
            ]),
            const SizedBox(height: 20),

            _buildToggleSection(context, 'Camera & Sensors', [
              _buildToggle(context, LucideIcons.camera, 'Food AI Camera', 'Access camera for food scanning', true),
              _buildToggle(context, LucideIcons.mic, 'Voice Assistant', 'Microphone access for voice actions', true),
              _buildToggle(context, LucideIcons.mapPin, 'Location Tracker', 'GPS access for exercise logs', false),
            ]),
            const SizedBox(height: 28),

            SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.trash2, color: AppTheme.error, size: 14),
                label: const Text('Delete All My Data', style: TextStyle(color: AppTheme.error, fontWeight: FontWeight.bold, fontSize: 13)),
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

  Widget _buildToggleSection(BuildContext context, String title, List<Widget> children) {
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

  Widget _buildToggle(BuildContext context, IconData icon, String title, String subtitle, bool value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 22,
        child: Row(
          children: [
            Icon(icon, color: value ? AppTheme.cyanAccent : AppTheme.textSecondary, size: 18),
            const SizedBox(width: 14),
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
                    subtitle,
                    style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: (v) {},
              activeColor: AppTheme.emeraldHealth,
              activeTrackColor: AppTheme.emeraldHealth.withOpacity(0.3),
              inactiveTrackColor: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04),
              inactiveThumbColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
