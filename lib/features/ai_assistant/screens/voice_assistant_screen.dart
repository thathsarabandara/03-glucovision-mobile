import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

enum AssistantState {
  idle,
  listening,
  speaking,
}

class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> with TickerProviderStateMixin {
  late AnimationController _orbController;
  late AnimationController _pulseController;
  late List<AnimationController> _waveControllers;
  
  AssistantState _currentState = AssistantState.speaking;
  bool _isMuted = false;

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

    _waveControllers = List.generate(
      12,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + (index * 60)),
      )..repeat(reverse: true),
    );
  }

  @override
  void dispose() {
    _orbController.dispose();
    _pulseController.dispose();
    for (var controller in _waveControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _cycleState() {
    setState(() {
      if (_currentState == AssistantState.speaking) {
        _currentState = AssistantState.listening;
      } else if (_currentState == AssistantState.listening) {
        _currentState = AssistantState.idle;
      } else {
        _currentState = AssistantState.speaking;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String labelTag;
    final String quoteText;
    final String statusSubtitle;
    final Color accentColor;

    switch (_currentState) {
      case AssistantState.idle:
        labelTag = '/ STANDBY MODE /';
        quoteText = '"System paused. Tap microphone to wake assistant."';
        statusSubtitle = 'AWAITING USER PROMPT';
        accentColor = Colors.blueGrey.shade400;
        break;
      case AssistantState.listening:
        labelTag = '/ LISTENING INPUT /';
        quoteText = '"Listening to Sarah... Speak clearly."';
        statusSubtitle = 'REAL-TIME SPEECH ANALYSIS';
        accentColor = const Color(0xFF7C4DFF); // Violet
        break;
      case AssistantState.speaking:
        labelTag = '/ ASSISTANT ACTIVE /';
        quoteText = '"How can I assist you, Nurse Sarah?"';
        statusSubtitle = 'SYNCHRONIZED VOICE FEEDBACK';
        accentColor = const Color(0xFFFF4081); // Magenta
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back chevron
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        LucideIcons.arrowLeft,
                        color: Colors.black87,
                        size: 20,
                      ),
                    ),
                  ),
                  
                  // Screen title label
                  Text(
                    'VOICE ASSISTANT',
                    style: GoogleFonts.outfit(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  // Diagnostics status indicator
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            
            // 2. Translucent Siri-like Orb Centerpiece
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Soft backing glow
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      final scale = 1.0 + 0.1 * _pulseController.value;
                      return Container(
                        width: 260 * scale,
                        height: 260 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              accentColor.withOpacity(0.12),
                              accentColor.withOpacity(0.02),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  // Siri-like pulsing orb
                  SizedBox(
                    width: 240,
                    height: 240,
                    child: AnimatedBuilder(
                      animation: _orbController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: SiriOrbPainter(
                            progress: _orbController.value,
                            pulse: _pulseController.value,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            
            // 3. Clean Elegant Typography Below Sphere (Glass Card)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.6),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // State tag
                    Text(
                      labelTag,
                      style: GoogleFonts.outfit(
                        color: accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 14),
                    
                    // Elegant Serif Quote Text
                    Text(
                      quoteText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lora(
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.45,
                        shadows: [
                          Shadow(
                            color: accentColor.withOpacity(0.18),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    
                    // Status Subtitle
                    Text(
                      statusSubtitle,
                      style: GoogleFonts.outfit(
                        color: Colors.black38,
                        fontSize: 10,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4. Waveform Visualizer
            if (_currentState != AssistantState.idle)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                child: SizedBox(
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(12, (index) {
                      return AnimatedBuilder(
                        animation: _waveControllers[index],
                        builder: (context, child) {
                          final double scaleVal = _waveControllers[index].value;
                          final double baseHeight = _currentState == AssistantState.listening ? 6.0 : 12.0;
                          final double height = baseHeight + (20.0 * scaleVal);
                          
                          return Container(
                            width: 3.5,
                            height: height,
                            margin: const EdgeInsets.symmetric(horizontal: 2.5),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.3 + 0.7 * scaleVal),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor.withOpacity(0.15),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              )
            else
              const SizedBox(height: 56),

            // 5. Interactive Bottom Call Controls
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0, bottom: 28.0, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Mute / Unmute Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMuted = !_isMuted;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isMuted ? LucideIcons.volumeX : LucideIcons.volume2,
                        color: _isMuted ? AppTheme.error : Colors.black87,
                        size: 20,
                      ),
                    ),
                  ),
                  
                  // Central Pulsing Microphone Wake Button
                  GestureDetector(
                    onTap: _cycleState,
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            accentColor,
                            accentColor.withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        _currentState == AssistantState.listening ? LucideIcons.mic : LucideIcons.micOff,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  
                  // Diagnostics Toggle Option Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentState = AssistantState.speaking;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Siri Diagnostics Sync Complete'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        LucideIcons.sliders,
                        color: Colors.black87,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter to draw a fluid, glowing translucent Siri-like energy orb
class SiriOrbPainter extends CustomPainter {
  final double progress;
  final double pulse;

  SiriOrbPainter({
    required this.progress,
    required this.pulse,
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
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, baseRadius, rimPaint);
  }

  @override
  bool shouldRepaint(covariant SiriOrbPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.pulse != pulse;
  }
}
