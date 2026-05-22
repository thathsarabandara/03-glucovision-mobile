import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class SmartGlassesOverlayPreviewScreen extends StatelessWidget {
  const SmartGlassesOverlayPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'AR Overlay Preview',
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
            const Text(
              'Customize your HUD layout style and AR visuals',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Mock glasses preview frame
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: AppTheme.purpleAI.withOpacity(0.35), width: 1.5),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60',
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.4),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.emeraldHealth.withOpacity(0.6), width: 1),
                      ),
                      child: const Text('112 mg/dL', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Positioned(
                    bottom: 14,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.cyanAccent.withOpacity(0.4), width: 1),
                      ),
                      child: const Text('✓ Food: Low GI', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppTheme.error,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: AppTheme.error.withOpacity(0.6), blurRadius: 6)],
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text('LIVE HUD', style: TextStyle(color: Colors.white70, fontSize: 8, letterSpacing: 1.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 90,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.emeraldHealth.withOpacity(0.5), width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text(
              'Layout Options',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            _buildOverlayOption(context, 'Glucose HUD Position', 'Top Right', AppTheme.emeraldHealth),
            const SizedBox(height: 10),
            _buildOverlayOption(context, 'Alert Banner Position', 'Bottom Left', AppTheme.warning),
            const SizedBox(height: 10),
            _buildOverlayOption(context, 'HUD Opacity', '75%', AppTheme.cyanAccent),
            const SizedBox(height: 10),
            _buildOverlayOption(context, 'Food Label Style', 'Compact + Icon', AppTheme.purpleAI),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayOption(BuildContext context, String label, String value, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: isDark ? Colors.white : AppTheme.textPrimary,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.35)),
            ),
            child: Text(
              value,
              style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
