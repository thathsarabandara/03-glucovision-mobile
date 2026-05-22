import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class OcrGlucoseScannerScreen extends StatefulWidget {
  const OcrGlucoseScannerScreen({super.key});

  @override
  State<OcrGlucoseScannerScreen> createState() => _OcrGlucoseScannerScreenState();
}

class _OcrGlucoseScannerScreenState extends State<OcrGlucoseScannerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Live Camera Feed Mock
          Positioned.fill(
            child: Container(
              color: Colors.black87,
              child: GridPaper(
                color: Colors.white.withOpacity(0.02),
                divisions: 2,
                subdivisions: 1,
                interval: 200,
              ),
            ),
          ),
          
          // 2. Custom Animated OCR Targeting Box
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Align glucometer screen in target area',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Targeting box
                Container(
                  width: 260,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.emeraldHealth.withOpacity(0.4), width: 2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.emeraldHealth.withOpacity(0.08),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Scanning laser line
                        AnimatedBuilder(
                          animation: _scannerController,
                          builder: (context, child) {
                            final double yPos = 160 * _scannerController.value;
                            return Positioned(
                              top: yPos,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 3.0,
                                decoration: BoxDecoration(
                                  color: AppTheme.emeraldHealth,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.emeraldHealth.withOpacity(0.8),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        
                        // Corner highlights
                        Positioned(
                          top: 8,
                          left: 8,
                          child: _buildCorner(isTop: true, isLeft: true),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: _buildCorner(isTop: true, isLeft: false),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: _buildCorner(isTop: false, isLeft: true),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: _buildCorner(isTop: false, isLeft: false),
                        ),
                        
                        // Mock Digit overlay detected
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.emeraldHealth.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '105',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Toolbar Overlays
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.x, color: Colors.white),
                        onPressed: () => context.pop(),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(LucideIcons.zap, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                
                // Bottom Confirmed Sheet
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.08)),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Detected Reading',
                        style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: const [
                          Text(
                            '105',
                            style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'mg/dL',
                            style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: BorderSide(color: Colors.white.withOpacity(0.15)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text('Rescan', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.go('/dashboard');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.emeraldHealth,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text('Confirm Log', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildCorner({required bool isTop, required bool isLeft}) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: AppTheme.emeraldHealth, width: 3) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: AppTheme.emeraldHealth, width: 3) : BorderSide.none,
          left: isLeft ? const BorderSide(color: AppTheme.emeraldHealth, width: 3) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: AppTheme.emeraldHealth, width: 3) : BorderSide.none,
        ),
      ),
    );
  }
}
