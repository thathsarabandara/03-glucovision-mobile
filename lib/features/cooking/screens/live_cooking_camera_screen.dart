import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';

class LiveCookingCameraScreen extends StatefulWidget {
  const LiveCookingCameraScreen({super.key});

  @override
  State<LiveCookingCameraScreen> createState() => _LiveCookingCameraScreenState();
}

class _LiveCookingCameraScreenState extends State<LiveCookingCameraScreen> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Mock Live Cooking Camera Feed
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1556910103-1c02745a872f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          
          // HUD grid overlay
          Positioned.fill(
            child: GridPaper(
              color: Colors.white.withOpacity(0.012),
              divisions: 2,
              subdivisions: 1,
              interval: 200,
            ),
          ),
          
          // 2. Live AI ingredient targeted overlays
          Positioned(
            top: 220,
            left: 60,
            child: _buildCookingOverlay(context, 'Salmon Fillet', 'Searing (Med-High)', 'Flip in 1:30', AppTheme.warning),
          ),
          
          Positioned(
            top: 140,
            right: 40,
            child: _buildCookingOverlay(context, 'Olive Oil', 'Smoke limit warning', 'Lower heat slightly', AppTheme.error),
          ),

          // 3. User Controls Overlay
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top controls toolbar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.x, color: Colors.white, size: 22),
                        onPressed: () => context.pop(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.purpleAI.withOpacity(0.4), width: 1.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Icon(
                                  LucideIcons.flame,
                                  color: AppTheme.warning.withOpacity(0.6 + 0.4 * _pulseController.value),
                                  size: 14,
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'ANALYSIS ACTIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.clipboardList, color: Colors.white, size: 22),
                        onPressed: () => context.push('/cooking-analysis'),
                      ),
                    ],
                  ),
                ),
                
                // Bottom Cooking Timer & Instructions Panel
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.12), width: 1.5),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'STEP 3 OF 5',
                                style: TextStyle(
                                  color: AppTheme.purpleAI,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Sear the Salmon',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppTheme.warning, width: 1.5),
                            ),
                            child: const Text(
                              '1:30',
                              style: TextStyle(
                                color: AppTheme.warning,
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Sear skin-side down for 3 minutes until crispy, then flip. The AI is tracking pan surface heat to ensure healthy monounsaturated fats do not break down.',
                        style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.45),
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
                                  side: BorderSide(color: Colors.white.withOpacity(0.18)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text('Previous', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () => context.push('/cooking-analysis'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.purpleAI,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text(
                                  'Next Step',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
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

  Widget _buildCookingOverlay(BuildContext context, String item, String state, String action, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.4), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
              ),
              const SizedBox(height: 2),
              Text(
                state,
                style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 1),
              Text(
                action,
                style: const TextStyle(color: Colors.white54, fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.7), width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }
}
