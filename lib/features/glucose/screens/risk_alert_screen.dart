import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class RiskAlertScreen extends StatefulWidget {
  const RiskAlertScreen({super.key});

  @override
  State<RiskAlertScreen> createState() => _RiskAlertScreenState();
}

class _RiskAlertScreenState extends State<RiskAlertScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                children: [
                  const SizedBox(height: 24),
                  
                  // 1. Alert Hero Pulsing Centerpiece
                  Center(
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            final double scale = 1.0 + 0.1 * _pulseController.value;
                            return Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.warning.withOpacity(0.12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.warning.withOpacity(0.25 * _pulseController.value),
                                    blurRadius: 35 * scale,
                                    spreadRadius: 6,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                LucideIcons.alertTriangle,
                                color: AppTheme.warning,
                                size: 48,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Hyperglycemia Risk',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.warning,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'Your glucose is projected to exceed 180 mg/dL within 45 minutes based on telemetry forecasts.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                              fontSize: 12,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),

                  // 2. Telemetry dashboard grid block
                  GlassCard(
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    borderRadius: 24,
                    hasGlow: true,
                    glowColor: AppTheme.warning.withOpacity(0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatBlock(context, 'Current', '158', 'mg/dL', AppTheme.warning),
                        Container(
                          width: 1.5,
                          height: 32,
                          color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
                        ),
                        _buildStatBlock(context, 'Predicted', '185', 'mg/dL', AppTheme.error),
                        Container(
                          width: 1.5,
                          height: 32,
                          color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
                        ),
                        _buildStatBlock(context, 'Trend Rate', '+3.2', '/min', AppTheme.error),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 3. Recommended actions header
                  Text(
                    'Recommended Actions',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Action Cards list
                  _buildActionCard(
                    context: context,
                    icon: LucideIcons.footprints,
                    title: 'Take a 15-min Walk',
                    description: 'Light active walking helps reduce predicted glucose spikes by approximately ~25 mg/dL.',
                    color: AppTheme.emeraldHealth,
                    isPrimary: true,
                    actionLabel: 'Start Walk',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    context: context,
                    icon: LucideIcons.droplet,
                    title: 'Drink 500ml Water',
                    description: 'Optimal hydration assists metabolic systems in filtering excess systemic glucose efficiently.',
                    color: AppTheme.cyanAccent,
                    isPrimary: false,
                    actionLabel: 'Log Water',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    context: context,
                    icon: LucideIcons.pill,
                    title: 'Medication Schedule Check',
                    description: ' इवनिंग medication is mathematically forecasted as due in approximately 30 minutes.',
                    color: AppTheme.purpleAI,
                    isPrimary: false,
                    actionLabel: 'Schedule',
                    onTap: () {},
                  ),
                  const SizedBox(height: 28),

                  // 5. Emergency Option link
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.phoneCall, color: AppTheme.error, size: 14),
                      label: const Text(
                        'Contact Emergency Support',
                        style: TextStyle(
                          color: AppTheme.error,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            
            // 6. Dismiss button overlay
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.backgroundDark : Colors.white,
                border: Border(
                  top: BorderSide(
                    color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.08)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Dismiss Warning',
                      style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBlock(BuildContext context, String label, String value, String unit, Color color) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color),
            ),
            const SizedBox(width: 1),
            Text(
              unit,
              style: const TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required bool isPrimary,
    required String actionLabel,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      hasGlow: isPrimary,
      glowColor: color.withOpacity(0.08),
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: isDark ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11, height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: color,
              side: BorderSide(color: color.withOpacity(0.3), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: const Size(0, 32),
            ),
            child: Text(
              actionLabel,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
