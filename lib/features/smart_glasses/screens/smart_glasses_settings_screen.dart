import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class SmartGlassesSettingsScreen extends StatelessWidget {
  const SmartGlassesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Glasses Settings',
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
            _buildSection(
              context,
              title: 'Display Configurations',
              children: [
                _buildSliderTile(context, 'Brightness', LucideIcons.sun, 0.7, AppTheme.warning),
                _buildSliderTile(context, 'Overlay Opacity', LucideIcons.layers, 0.75, AppTheme.purpleAI),
              ],
            ),
            const SizedBox(height: 20),

            _buildSection(
              context,
              title: 'Voice Controls',
              children: [
                _buildToggleTile(context, 'Voice Activation', '"Hey GlucoVision"', LucideIcons.mic, true),
                _buildToggleTile(context, 'Hands-free Logging', 'Log meals by speaking', LucideIcons.edit3, true),
                _buildToggleTile(context, 'Alert Read-Aloud', 'Hear health alerts', LucideIcons.volume2, false),
              ],
            ),
            const SizedBox(height: 20),

            _buildSection(
              context,
              title: 'AR Streaming Options',
              children: [
                _buildToggleTile(context, 'Auto-start on Connect', 'Stream when glasses connect', LucideIcons.zap, true),
                _buildToggleTile(context, 'Food AI Overlay', 'Real-time recognition', LucideIcons.utensils, true),
                _buildToggleTile(context, 'Wi-Fi Direct Mode', 'High-res local streaming', LucideIcons.wifi, false),
              ],
            ),
            const SizedBox(height: 28),

            SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.refreshCcw, size: 14, color: AppTheme.textSecondary),
                label: const Text('Reset Glasses to Factory', style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold, fontSize: 13)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.08)),
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

  Widget _buildSection(BuildContext context, {required String title, required List<Widget> children}) {
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

  Widget _buildToggleTile(BuildContext context, String title, String subtitle, IconData icon, bool value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 20,
        child: Row(
          children: [
            Icon(icon, color: value ? AppTheme.cyanAccent : AppTheme.textSecondary, size: 18),
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
                  Text(subtitle, style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
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

  Widget _buildSliderTile(BuildContext context, String title, IconData icon, double value, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(value * 100).round()}%',
                  style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 3,
                activeTrackColor: color,
                inactiveTrackColor: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04),
                thumbColor: color,
                overlayColor: color.withOpacity(0.12),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              ),
              child: Slider(value: value, onChanged: (v) {}),
            ),
          ],
        ),
      ),
    );
  }
}
