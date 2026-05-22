import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class LiveCameraScreen extends StatefulWidget {
  const LiveCameraScreen({super.key});

  @override
  State<LiveCameraScreen> createState() => _LiveCameraScreenState();
}

class _LiveCameraScreenState extends State<LiveCameraScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Mock Live Camera Feed with a grid overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.15),
              ),
            ),
          ),
          
          // 2. Camera Grid Overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _CameraGridPainter(),
            ),
          ),
          
          // 3. Live AI Object Detection Overlays (with animation)
          Positioned(
            top: 250,
            left: 50,
            child: _buildDetectionOverlay(
              context: context,
              label: 'Avocado',
              confidence: '98%',
              width: 90,
              height: 90,
              color: AppTheme.emeraldHealth,
            ),
          ),
          Positioned(
            top: 400,
            left: 170,
            child: _buildDetectionOverlay(
              context: context,
              label: 'Grilled Chicken',
              confidence: '95%',
              width: 140,
              height: 100,
              color: AppTheme.warning,
            ),
          ),
          Positioned(
            top: 150,
            right: 60,
            child: _buildDetectionOverlay(
              context: context,
              label: 'Mixed Greens',
              confidence: '99%',
              width: 110,
              height: 80,
              color: AppTheme.cyanAccent,
            ),
          ),

          // 4. Interface HUD controls
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
                        icon: const Icon(LucideIcons.x, color: Colors.white, size: 22),
                        onPressed: () => context.pop(),
                      ),
                      
                      // Auto detect status tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.emeraldHealth.withOpacity(0.4), width: 1.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: AppTheme.emeraldHealth,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.emeraldHealth.withOpacity(0.8 * _pulseController.value),
                                        blurRadius: 6,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'AUTO-DETECTION',
                              style: TextStyle(
                                color: AppTheme.emeraldHealth,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      IconButton(
                        icon: const Icon(LucideIcons.history, color: Colors.white, size: 22),
                        onPressed: () => context.push('/food-history'),
                      ),
                    ],
                  ),
                ),
                
                // Bottom controls panel
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Photo library button
                      _buildRoundCameraButton(
                        icon: LucideIcons.image,
                        onTap: () {},
                      ),
                      
                      // Shutter button
                      GestureDetector(
                        onTap: () => context.push('/meal-capture-preview'),
                        child: AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Container(
                              width: 84,
                              height: 84,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4 + 0.3 * _pulseController.value),
                                  width: 4,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 62,
                                  height: 62,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      
                      // Flash settings button
                      _buildRoundCameraButton(
                        icon: LucideIcons.zap,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundCameraButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildDetectionOverlay({
    required BuildContext context,
    required String label,
    required String confidence,
    required double width,
    required double height,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                confidence,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}

class _CameraGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1.0;

    // Draw horizontal grid lines
    canvas.drawLine(Offset(0, h * 0.33), Offset(w, h * 0.33), paint);
    canvas.drawLine(Offset(0, h * 0.66), Offset(w, h * 0.66), paint);

    // Draw vertical grid lines
    canvas.drawLine(Offset(w * 0.33, 0), Offset(w * 0.33, h), paint);
    canvas.drawLine(Offset(w * 0.66, 0), Offset(w * 0.66, h), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
