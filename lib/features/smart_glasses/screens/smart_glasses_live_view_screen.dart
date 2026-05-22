import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';

class SmartGlassesLiveViewScreen extends StatefulWidget {
  const SmartGlassesLiveViewScreen({super.key});

  @override
  State<SmartGlassesLiveViewScreen> createState() => _SmartGlassesLiveViewScreenState();
}

class _SmartGlassesLiveViewScreenState extends State<SmartGlassesLiveViewScreen> with SingleTickerProviderStateMixin {
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
          // 1. Mock first-person restaurant/food perspective
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.25),
              ),
            ),
          ),
          
          // HUD grid overlay
          Positioned.fill(
            child: GridPaper(
              color: Colors.white.withOpacity(0.015),
              divisions: 2,
              subdivisions: 1,
              interval: 180,
            ),
          ),

          // 2. HUD Top-Right: Glucose + Time
          Positioned(
            top: 48,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.emeraldHealth.withOpacity(0.45), width: 1.5),
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
                        '112 mg/dL',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                  ),
                  child: const Text(
                    '7:42 PM',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. HUD Center: Food Detection box
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.emeraldHealth.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.emeraldHealth.withOpacity(0.35),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Text(
                    '🥗 Mixed Green Salad  •  ~245 kcal',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 220,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.emeraldHealth.withOpacity(0.5), width: 2),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.emeraldHealth.withOpacity(0.08),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(top: 6, left: 6, child: _buildBracketCorner(true, true)),
                      Positioned(top: 6, right: 6, child: _buildBracketCorner(true, false)),
                      Positioned(bottom: 6, left: 6, child: _buildBracketCorner(false, true)),
                      Positioned(bottom: 6, right: 6, child: _buildBracketCorner(false, false)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 4. HUD Bottom-Left: Realtime AI Alert suggestion
          Positioned(
            bottom: 120,
            left: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.cyanAccent.withOpacity(0.4), width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(LucideIcons.sparkles, color: AppTheme.cyanAccent, size: 14),
                  SizedBox(width: 8),
                  Text(
                    'Glycemic Impact: Safe (Low GL)',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // 5. HUD Bottom: Recording active indicator
          Positioned(
            bottom: 60,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
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
                          color: AppTheme.error,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.error.withOpacity(0.8 * _pulseController.value),
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
                    'LIVE VIEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Close button
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(LucideIcons.x, color: Colors.white, size: 22),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBracketCorner(bool isTop, bool isLeft) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: AppTheme.emeraldHealth, width: 2) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: AppTheme.emeraldHealth, width: 2) : BorderSide.none,
          left: isLeft ? const BorderSide(color: AppTheme.emeraldHealth, width: 2) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: AppTheme.emeraldHealth, width: 2) : BorderSide.none,
        ),
      ),
    );
  }
}
