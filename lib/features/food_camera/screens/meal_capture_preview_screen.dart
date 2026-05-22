import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class MealCapturePreviewScreen extends StatelessWidget {
  const MealCapturePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Captured Image background
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
              fit: BoxFit.cover,
            ),
          ),
          
          // Dark ambient overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          // 2. HUD Screen Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top controls bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.chevronLeft, color: Colors.white, size: 24),
                        onPressed: () => context.pop(),
                      ),
                      const Text(
                        'Confirm Scan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 48), // Spacer to balance back button
                    ],
                  ),
                ),
                
                // Detected Foods Summary Panel (Glass Card)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GlassCard(
                    padding: const EdgeInsets.all(24),
                    borderRadius: 28,
                    hasGlow: true,
                    glowColor: AppTheme.cyanAccent.withOpacity(0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(LucideIcons.checkCircle2, color: AppTheme.emeraldHealth, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'AI Analysis: 3 Items Detected',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildDetectedItem('Avocado', AppTheme.emeraldHealth),
                            _buildDetectedItem('Grilled Chicken', AppTheme.warning),
                            _buildDetectedItem('Mixed Greens', AppTheme.cyanAccent),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: OutlinedButton(
                                  onPressed: () => context.pop(),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: BorderSide(color: Colors.white.withOpacity(0.18)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text('Retake', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.push('/food-recognition-result');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.cyanAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    'Analyze',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectedItem(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
