import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class MultimodalAssistantScreen extends StatefulWidget {
  const MultimodalAssistantScreen({super.key});

  @override
  State<MultimodalAssistantScreen> createState() => _MultimodalAssistantScreenState();
}

class _MultimodalAssistantScreenState extends State<MultimodalAssistantScreen> with TickerProviderStateMixin {
  late AnimationController _orbController;
  late AnimationController _pulseController;
  late AnimationController _transitionController;
  
  bool _isCameraActive = false;

  @override
  void initState() {
    super.initState();
    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _orbController.dispose();
    _pulseController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  void _toggleCameraMode() {
    setState(() {
      _isCameraActive = !_isCameraActive;
      if (_isCameraActive) {
        _transitionController.forward();
      } else {
        _transitionController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: Stack(
        children: [
          // 1. Camera Feed / Voice Mode Background Transition
          AnimatedBuilder(
            animation: _transitionController,
            builder: (context, child) {
              return Stack(
                children: [
                  // Clean Off-White Background for Voice Mode
                  Positioned.fill(
                    child: Container(
                      color: const Color(0xFFF7F8FC),
                    ),
                  ),
                  
                  // Camera Feed Overlay (fades in)
                  Positioned.fill(
                    child: Opacity(
                      opacity: _transitionController.value,
                      child: _isCameraActive
                          ? Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                color: Colors.black.withOpacity(0.4),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              );
            },
          ),
          
          // 2. Camera Focus Brackets
          if (_isCameraActive)
            Center(
              child: FadeTransition(
                opacity: _transitionController,
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.cyanAccent.withOpacity(0.15 + 0.15 * _pulseController.value),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildCorner(true, true),
                              _buildCorner(true, false),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildCorner(false, true),
                              _buildCorner(false, false),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

          // 3. Central Siri-like Orb / Bottom pulsing indicator
          AnimatedBuilder(
            animation: _transitionController,
            builder: (context, child) {
              final double value = _transitionController.value;
              
              final double orbSize = 240.0 - 170.0 * value;
              final double verticalOffset = 280.0 * value;

              return Center(
                child: Transform.translate(
                  offset: Offset(0, verticalOffset),
                  child: GestureDetector(
                    onTap: () {
                      if (!_isCameraActive) {
                        _toggleCameraMode();
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Soft Backing Glow
                        Container(
                          width: orbSize * 1.2,
                          height: orbSize * 1.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF52A2).withOpacity(0.15 * (1.0 - value * 0.5)),
                                blurRadius: 40,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                        
                        // Siri Orb Painter
                        SizedBox(
                          width: orbSize,
                          height: orbSize,
                          child: AnimatedBuilder(
                            animation: _orbController,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: SiriOrbPainter(
                                  progress: _orbController.value,
                                  pulse: _pulseController.value,
                                  isCompact: _isCameraActive,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // 4. Header Bar (Clean Minimal UI overlay)
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back arrow
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: AnimatedBuilder(
                          animation: _transitionController,
                          builder: (context, child) {
                            final isDark = _transitionController.value > 0.5;
                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark ? Colors.black.withOpacity(0.4) : Colors.white,
                                boxShadow: isDark
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                              ),
                              child: Icon(
                                LucideIcons.arrowLeft,
                                color: isDark ? Colors.white : Colors.black87,
                                size: 20,
                              ),
                            );
                          },
                        ),
                      ),
                      
                      // Title / Mode label (only in Voice Mode)
                      if (!_isCameraActive)
                        Text(
                          'MULTIMODAL AI',
                          style: GoogleFonts.outfit(
                            color: Colors.black45,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),

                      // Camera Toggle Button
                      GestureDetector(
                        onTap: _toggleCameraMode,
                        child: AnimatedBuilder(
                          animation: _transitionController,
                          builder: (context, child) {
                            final isDark = _transitionController.value > 0.5;
                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _isCameraActive
                                    ? AppTheme.cyanAccent
                                    : (isDark ? Colors.black.withOpacity(0.4) : Colors.white),
                                boxShadow: isDark
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                              ),
                              child: Icon(
                                _isCameraActive ? LucideIcons.mic : LucideIcons.camera,
                                color: _isCameraActive
                                    ? Colors.black87
                                    : (isDark ? Colors.white : Colors.black87),
                                size: 20,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // 5. Interactive Cards depending on the mode
                AnimatedBuilder(
                  animation: _transitionController,
                  builder: (context, child) {
                    if (_transitionController.value < 0.1) {
                      // Voice Mode Details
                      return FadeTransition(
                        opacity: ReverseAnimation(_transitionController),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 56.0, left: 32.0, right: 32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "I'm listening...",
                                style: GoogleFonts.outfit(
                                  color: Colors.black87,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Tap the camera icon above to scan your meals or environment.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  color: Colors.black38,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (_transitionController.value > 0.9) {
                      // Camera Mode Suggestions Card
                      return FadeTransition(
                        opacity: _transitionController,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          child: GlassCard(
                            padding: const EdgeInsets.all(20),
                            borderRadius: 28,
                            hasGlow: true,
                            glowColor: AppTheme.emeraldHealth.withOpacity(0.12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(LucideIcons.sparkles, color: AppTheme.emeraldHealth, size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      'AI Identifies: Quinoa Salad Bowl',
                                      style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Estimated 45g of complex carbohydrates. This features a low glycemic load, offering a slow-release response to prevent spikes.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 12,
                                    height: 1.45,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 44,
                                        child: ElevatedButton.icon(
                                          onPressed: () => context.go('/glucose-dashboard'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppTheme.emeraldHealth,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                          ),
                                          icon: const Icon(LucideIcons.plusCircle, size: 16),
                                          label: const Text(
                                            'Log Meal',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: SizedBox(
                                        height: 44,
                                        child: OutlinedButton.icon(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            side: BorderSide(color: Colors.white.withOpacity(0.18)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                          ),
                                          icon: const Icon(LucideIcons.info, size: 16),
                                          label: const Text(
                                            'Macros',
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
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                
                // Active status audio card at very bottom
                if (_isCameraActive)
                  FadeTransition(
                    opacity: _transitionController,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 28.0, top: 4.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: AppTheme.cyanAccent.withOpacity(0.35), width: 1.5),
                        ),
                        child: Row(
                          children: const [
                            Icon(LucideIcons.mic, color: AppTheme.cyanAccent, size: 18),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '"Is this choice ideal for my glucose levels?"',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(bool isTop, bool isLeft) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: AppTheme.cyanAccent, width: 3) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: AppTheme.cyanAccent, width: 3) : BorderSide.none,
          left: isLeft ? const BorderSide(color: AppTheme.cyanAccent, width: 3) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: AppTheme.cyanAccent, width: 3) : BorderSide.none,
        ),
      ),
    );
  }
}

// Custom Painter to draw a fluid, glowing translucent Siri-like energy orb
class SiriOrbPainter extends CustomPainter {
  final double progress;
  final double pulse;
  final bool isCompact;

  SiriOrbPainter({
    required this.progress,
    required this.pulse,
    required this.isCompact,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = (size.width / 2) * (0.85 + 0.05 * pulse);

    // Clip to circle so the fluid colors remain inside the spherical boundary
    final orbPath = Path()..addOval(Rect.fromCircle(center: center, radius: baseRadius));
    canvas.save();
    canvas.clipPath(orbPath);

    // 1. Draw base soft white/pink sphere volume background
    final basePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFCE4EC),
          const Color(0xFFF3E5F5),
          const Color(0xFFE8EAF6).withOpacity(0.8),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius));
    canvas.drawCircle(center, baseRadius, basePaint);

    // 2. Draw moving translucent liquid layers (pink, magenta, blue, violet)
    final double time = progress * 2 * math.pi;
    final int waveLayers = 5;

    for (int i = 0; i < waveLayers; i++) {
      final double wavePhase = i * (2 * math.pi / waveLayers);
      
      // Calculate dynamic offset for the center of each gradient layer
      final double offsetX = baseRadius * 0.28 * math.cos(time * (1.0 + i * 0.1) + wavePhase);
      final double offsetY = baseRadius * 0.28 * math.sin(time * (0.8 + i * 0.15) - wavePhase * 1.5);
      final Offset waveCenter = center + Offset(offsetX, offsetY);

      Color layerColor;
      switch (i % 4) {
        case 0:
          layerColor = const Color(0xFFFF4081); // Bright Pink/Magenta
          break;
        case 1:
          layerColor = const Color(0xFF7C4DFF); // Deep Purple/Indigo
          break;
        case 2:
          layerColor = const Color(0xFF00E5FF); // Electric Blue/Cyan
          break;
        default:
          layerColor = const Color(0xFFFF80AB); // Soft Pink
          break;
      }

      final double layerRadius = baseRadius * (0.75 + 0.1 * math.sin(time + i));
      
      final layerPaint = Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          colors: [
            layerColor.withOpacity(0.55),
            layerColor.withOpacity(0.2),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: waveCenter, radius: layerRadius))
        ..blendMode = BlendMode.srcOver;

      canvas.drawCircle(waveCenter, layerRadius, layerPaint);
    }

    // 3. Highlight layers to add a glassy 3D look
    final highlightPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.7),
          Colors.white.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius));
    canvas.drawCircle(center, baseRadius, highlightPaint);

    // Dynamic inner bright core highlight
    final coreOffset = Offset(-baseRadius * 0.1, -baseRadius * 0.15);
    final corePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: center + coreOffset, radius: baseRadius * 0.5));
    canvas.drawCircle(center + coreOffset, baseRadius * 0.5, corePaint);

    canvas.restore();

    // 4. Soft rim outer glow border (glass-like boundary outline)
    final rimPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          const Color(0xFFFF4081).withOpacity(0.2),
          const Color(0xFF00E5FF).withOpacity(0.2),
          const Color(0xFF7C4DFF).withOpacity(0.2),
          const Color(0xFFFF4081).withOpacity(0.2),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = isCompact ? 1.0 : 1.5;
    canvas.drawCircle(center, baseRadius, rimPaint);
  }

  @override
  bool shouldRepaint(covariant SiriOrbPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.pulse != pulse ||
        oldDelegate.isCompact != isCompact;
  }
}
