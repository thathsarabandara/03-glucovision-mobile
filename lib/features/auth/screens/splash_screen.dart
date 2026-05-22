import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glucovision_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoCtrl;
  late AnimationController _textCtrl;
  late AnimationController _loadingCtrl;
  late Animation<double> _textOpacity;
  late Animation<double> _textTranslateY;
  late Animation<double> _textLetterSpacing;
  late Animation<double> _subLetterSpacing;

  @override
  void initState() {
    super.initState();

    // Infinite loop for the logo graphic & background animations
    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..repeat();

    // One-time entrance animation for the text
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4080),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(
          3240 / 4080, // starts at 54% of 6000ms loop
          1.0,         // finishes at 68% of 6000ms loop
          curve: Curves.easeInOut,
        ),
      ),
    );

    _textTranslateY = Tween<double>(begin: 8.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(
          3240 / 4080,
          1.0,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    _textLetterSpacing = Tween<double>(
      begin: 16 * 0.12, // compressed letter-spacing
      end: 16 * 0.28,   // target letter-spacing (.28em)
    ).animate(
      CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(
          3240 / 4080,
          1.0,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    _subLetterSpacing = Tween<double>(
      begin: 10 * 0.08,
      end: 10 * 0.18,
    ).animate(
      CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(
          3240 / 4080,
          1.0,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    _textCtrl.forward();

    // 12-second loading animation driving the top blue loading strips
    _loadingCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    _loadingCtrl.forward().then((_) {
      if (mounted) {
        context.go('/welcome');
      }
    });
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _textCtrl.dispose();
    _loadingCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppTheme.backgroundDark : AppTheme.background;
    final Color brandGlucoColor = isDark ? const Color(0xFFE2E8F0) : const Color(0xFF334155);
    final Color brandVisionColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);
    final Color subtitleColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF94A3B8);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // ── Pulsating Ambient Glow 1 (Cyan/Blue) ──
          Positioned(
            top: -100,
            left: -100,
            child: AnimatedBuilder(
              animation: _logoCtrl,
              builder: (context, _) {
                final pulse = 1.0 + 0.12 * math.sin(_logoCtrl.value * 2 * math.pi);
                return Container(
                  width: 320 * pulse,
                  height: 320 * pulse,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isDark ? const Color(0xFF1E3A8A) : const Color(0xFFDBEAFE)).withOpacity(isDark ? 0.25 : 0.4),
                    boxShadow: [
                      BoxShadow(
                        color: (isDark ? const Color(0xFF3B82F6) : const Color(0xFF93C5FD)).withOpacity(isDark ? 0.2 : 0.3),
                        blurRadius: 120,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ── Pulsating Ambient Glow 2 (Emerald/Green) ──
          Positioned(
            bottom: -120,
            right: -120,
            child: AnimatedBuilder(
              animation: _logoCtrl,
              builder: (context, _) {
                final pulse = 1.0 + 0.1 * math.sin((_logoCtrl.value + 0.5) * 2 * math.pi);
                return Container(
                  width: 300 * pulse,
                  height: 300 * pulse,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isDark ? const Color(0xFF0F766E) : const Color(0xFFCCFBF1)).withOpacity(isDark ? 0.2 : 0.35),
                    boxShadow: [
                      BoxShadow(
                        color: (isDark ? const Color(0xFF14B8A6) : const Color(0xFF99F6E4)).withOpacity(isDark ? 0.15 : 0.25),
                        blurRadius: 100,
                        spreadRadius: 15,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ── Tech HUD Background Grid & Circular Diagnostic Scans ──
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _logoCtrl,
              builder: (context, _) {
                return CustomPaint(
                  painter: _TechBackgroundPainter(
                    animationValue: _logoCtrl.value,
                    isDark: isDark,
                  ),
                );
              },
            ),
          ),

          // ── Top Blue Loading Strips ──
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 24,
            right: 24,
            child: AnimatedBuilder(
              animation: _loadingCtrl,
              builder: (context, _) {
                return Row(
                  children: List.generate(
                    3,
                    (index) {
                      double segmentProgress;
                      if (index == 0) {
                        segmentProgress = (_loadingCtrl.value * 3).clamp(0.0, 1.0);
                      } else if (index == 1) {
                        segmentProgress = ((_loadingCtrl.value - 1 / 3) * 3).clamp(0.0, 1.0);
                      } else {
                        segmentProgress = ((_loadingCtrl.value - 2 / 3) * 3).clamp(0.0, 1.0);
                      }

                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: segmentProgress,
                              backgroundColor: isDark
                                  ? AppTheme.surfaceDark
                                  : AppTheme.surfaceHighlight,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB),
                              ),
                              minHeight: 4,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // ── Centered Logo ──
          Center(
            child: GlucoVisionLogoWidget(
              size: 220,
              controller: _logoCtrl,
            ),
          ),

          // ── Bottom Brand and Subtitle Text ──
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: AnimatedBuilder(
                animation: _textCtrl,
                builder: (context, _) {
                  return Opacity(
                    opacity: _textOpacity.value.clamp(0.0, 1.0),
                    child: Transform.translate(
                      offset: Offset(0, _textTranslateY.value),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Brand text: GLUCO and VISION
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'GLUCO',
                                  style: GoogleFonts.inter(
                                    color: brandGlucoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'VISION',
                                  style: GoogleFonts.inter(
                                    color: brandVisionColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              letterSpacing: _textLetterSpacing.value,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 3),
                          // Subtitle text: Connect.Protect.Care
                          Text(
                            'CONNECT.PROTECT.CARE',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: subtitleColor,
                              letterSpacing: _subLetterSpacing.value,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TechBackgroundPainter extends CustomPainter {
  final double animationValue;
  final bool isDark;

  _TechBackgroundPainter({required this.animationValue, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw subtle grid lines
    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)).withOpacity(isDark ? 0.08 : 0.12)
      ..strokeWidth = 0.8;

    final double gridSpacing = 48.0;
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw concentric tech circles
    final techColor = isDark ? const Color(0xFF3B82F6) : const Color(0xFF2563EB);
    final techPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = techColor.withOpacity(isDark ? 0.08 : 0.05)
      ..strokeWidth = 1.0;

    // Draw central crosshair
    final crossLength = 12.0;
    canvas.drawLine(center - Offset(crossLength, 0), center + Offset(crossLength, 0), techPaint);
    canvas.drawLine(center - Offset(0, crossLength), center + Offset(0, crossLength), techPaint);

    final rotationAngle = animationValue * 2 * math.pi;

    // Tech Ring 1 (Dashed)
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationAngle * 0.12);
    _drawDashedCircle(canvas, Offset.zero, 130, 24, techPaint);
    canvas.restore();

    // Tech Ring 2 (Dashed, wider, rotating counter-clockwise)
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-rotationAngle * 0.06);
    _drawDashedCircle(canvas, Offset.zero, 175, 16, techPaint);
    canvas.restore();
    
    // Outer solid faint ring (bounds)
    canvas.drawCircle(center, 210, Paint()
      ..style = PaintingStyle.stroke
      ..color = techColor.withOpacity(isDark ? 0.03 : 0.02)
      ..strokeWidth = 0.6);
  }

  void _drawDashedCircle(Canvas canvas, Offset center, double radius, int dashCount, Paint paint) {
    final double dashAngle = (2 * math.pi) / (dashCount * 2);
    for (int i = 0; i < dashCount; i++) {
      final double startAngle = i * 2 * dashAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TechBackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || oldDelegate.isDark != isDark;
  }
}
