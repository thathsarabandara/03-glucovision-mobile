import 'dart:math' as math;
import 'package:flutter/material.dart';

enum StylizedIconType {
  heart,
  liver,
  lungs,
  steps,
  calories,
  recovery,
  watch,
  brain,
}

class Stylized3DIcon extends StatefulWidget {
  final StylizedIconType type;
  final double size;
  final Color baseColor;
  final bool animate;

  const Stylized3DIcon({
    super.key,
    required this.type,
    this.size = 80.0,
    required this.baseColor,
    this.animate = true,
  });

  @override
  State<Stylized3DIcon> createState() => _Stylized3DIconState();
}

class _Stylized3DIconState extends State<Stylized3DIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final floatOffset = widget.animate
            ? math.sin(_controller.value * 2 * math.pi) * 4.0
            : 0.0;
        final rotation = widget.animate
            ? math.sin(_controller.value * 2 * math.pi) * 0.05
            : 0.0;

        return Transform.translate(
          offset: Offset(0, floatOffset),
          child: Transform.rotate(
            angle: rotation,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.baseColor.withOpacity(0.2),
                    blurRadius: widget.size * 0.25,
                    spreadRadius: widget.size * 0.02,
                  ),
                ],
              ),
              child: CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _Stylized3DPainter(
                  type: widget.type,
                  color: widget.baseColor,
                  animValue: _controller.value,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Stylized3DPainter extends CustomPainter {
  final StylizedIconType type;
  final Color color;
  final double animValue;

  _Stylized3DPainter({
    required this.type,
    required this.color,
    required this.animValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);
    final double radius = w / 2;

    // 1. Draw glowing base backing plate (glassmorphic layer)
    final basePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.95),
          Colors.white.withOpacity(0.5),
          color.withOpacity(0.08),
        ],
        stops: const [0.0, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.9, basePaint);

    // Subtle edge highlight (emboss ring)
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          Colors.white.withOpacity(0.1),
          color.withOpacity(0.3),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius * 0.88, ringPaint);

    // 2. Draw Organ or Icon Graphic
    switch (type) {
      case StylizedIconType.heart:
        _draw3DHeart(canvas, center, radius * 0.6);
        break;
      case StylizedIconType.liver:
        _draw3DLiver(canvas, center, radius * 0.6);
        break;
      case StylizedIconType.lungs:
        _draw3DLungs(canvas, center, radius * 0.6);
        break;
      case StylizedIconType.steps:
        _draw3DSteps(canvas, center, radius * 0.6);
        break;
      case StylizedIconType.calories:
        _draw3DCalories(canvas, center, radius * 0.6);
        break;
      case StylizedIconType.recovery:
        _draw3DRecovery(canvas, center, radius * 0.6);
        break;
      case StylizedIconType.watch:
        _draw3DWatch(canvas, center, radius * 0.6);
        break;
      case StylizedIconType.brain:
        _draw3DBrain(canvas, center, radius * 0.6);
        break;
    }
  }

  void _draw3DHeart(Canvas canvas, Offset center, double size) {
    // Pulse animation based on animValue
    final double pulse = 1.0 + 0.08 * math.sin(animValue * 4 * math.pi);
    final double r = size * 0.85 * pulse;

    final path = Path();
    path.moveTo(center.dx, center.dy + r * 0.7);
    
    // Left side of heart
    path.cubicTo(
      center.dx - r, center.dy + r * 0.1,
      center.dx - r * 1.2, center.dy - r * 0.7,
      center.dx - r * 0.5, center.dy - r * 0.9,
    );
    path.cubicTo(
      center.dx - r * 0.1, center.dy - r * 1.0,
      center.dx, center.dy - r * 0.5,
      center.dx, center.dy - r * 0.4,
    );
    // Right side of heart
    path.cubicTo(
      center.dx, center.dy - r * 0.5,
      center.dx + r * 0.1, center.dy - r * 1.0,
      center.dx + r * 0.5, center.dy - r * 0.9,
    );
    path.cubicTo(
      center.dx + r * 1.2, center.dy - r * 0.7,
      center.dx + r, center.dy + r * 0.1,
      center.dx, center.dy + r * 0.7,
    );
    path.close();

    // Layer 1: Dark Backing Drop Shadow
    final shadowPaint = Paint()
      ..color = color.withOpacity(0.18)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.save();
    canvas.translate(0, 4);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // Layer 2: Main Shiny Mesh Gradient
    final heartPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color,
          color.withRed((color.red + 50).clamp(0, 255)),
          color.withBlue((color.blue + 30).clamp(0, 255)),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: r))
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, heartPaint);

    // Layer 3: Highlight Overlay (3D gloss)
    final highlightPath = Path();
    highlightPath.moveTo(center.dx - r * 0.4, center.dy - r * 0.6);
    highlightPath.cubicTo(
      center.dx - r * 0.7, center.dy - r * 0.4,
      center.dx - r * 0.6, center.dy + r * 0.1,
      center.dx - r * 0.2, center.dy + r * 0.4,
    );
    highlightPath.quadraticBezierTo(
      center.dx - r * 0.4, center.dy + r * 0.1,
      center.dx - r * 0.4, center.dy - r * 0.3,
    );
    highlightPath.close();

    final highlightPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.65),
          Colors.white.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: r))
      ..style = PaintingStyle.fill;
    canvas.drawPath(highlightPath, highlightPaint);
  }

  void _draw3DLiver(Canvas canvas, Offset center, double size) {
    final double r = size * 0.9;
    final path = Path();
    
    // Standard anatomical triangular liver shape
    path.moveTo(center.dx - r * 0.8, center.dy - r * 0.1);
    path.quadraticBezierTo(center.dx - r * 0.4, center.dy - r * 0.6, center.dx + r * 0.6, center.dy - r * 0.4);
    path.quadraticBezierTo(center.dx + r * 0.9, center.dy + r * 0.1, center.dx + r * 0.7, center.dy + r * 0.3);
    path.quadraticBezierTo(center.dx + r * 0.3, center.dy + r * 0.2, center.dx - r * 0.1, center.dy + r * 0.4);
    path.quadraticBezierTo(center.dx - r * 0.7, center.dy + r * 0.5, center.dx - r * 0.8, center.dy - r * 0.1);
    path.close();

    // Shadow
    canvas.drawPath(path, Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));

    // Base body gradient
    canvas.drawPath(path, Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.8),
          color,
          color.withRed((color.red - 40).clamp(0, 255)),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: r))
      ..style = PaintingStyle.fill);

    // Left lobe division highlight
    final divisionPath = Path();
    divisionPath.moveTo(center.dx - r * 0.1, center.dy - r * 0.5);
    divisionPath.quadraticBezierTo(center.dx - r * 0.05, center.dy, center.dx - r * 0.1, center.dy + r * 0.4);
    
    canvas.drawPath(divisionPath, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.white.withOpacity(0.4));
  }

  void _draw3DLungs(Canvas canvas, Offset center, double size) {
    final double r = size * 0.85;
    
    // Left lung path
    final leftLung = Path();
    leftLung.moveTo(center.dx - r * 0.08, center.dy - r * 0.8);
    leftLung.quadraticBezierTo(center.dx - r * 0.4, center.dy - r * 0.9, center.dx - r * 0.85, center.dy - r * 0.3);
    leftLung.quadraticBezierTo(center.dx - r * 0.95, center.dy + r * 0.3, center.dx - r * 0.6, center.dy + r * 0.8);
    leftLung.quadraticBezierTo(center.dx - r * 0.4, center.dy + r * 0.5, center.dx - r * 0.1, center.dy + r * 0.5);
    leftLung.quadraticBezierTo(center.dx - r * 0.08, center.dy + r * 0.1, center.dx - r * 0.08, center.dy - r * 0.8);
    leftLung.close();

    // Right lung path
    final rightLung = Path();
    rightLung.moveTo(center.dx + r * 0.08, center.dy - r * 0.8);
    rightLung.quadraticBezierTo(center.dx + r * 0.4, center.dy - r * 0.9, center.dx + r * 0.85, center.dy - r * 0.3);
    rightLung.quadraticBezierTo(center.dx + r * 0.95, center.dy + r * 0.3, center.dx + r * 0.6, center.dy + r * 0.8);
    rightLung.quadraticBezierTo(center.dx + r * 0.4, center.dy + r * 0.5, center.dx + r * 0.1, center.dy + r * 0.5);
    rightLung.quadraticBezierTo(center.dx + r * 0.08, center.dy + r * 0.1, center.dx + r * 0.08, center.dy - r * 0.8);
    rightLung.close();

    final shadowPaint = Paint()
      ..color = color.withOpacity(0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawPath(leftLung, shadowPaint);
    canvas.drawPath(rightLung, shadowPaint);

    final lungGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color.withOpacity(0.85), color, color.withBlue((color.blue + 40).clamp(0, 255))],
    ).createShader(Rect.fromCircle(center: center, radius: r));

    final mainPaint = Paint()
      ..shader = lungGradient
      ..style = PaintingStyle.fill;

    canvas.drawPath(leftLung, mainPaint);
    canvas.drawPath(rightLung, mainPaint);

    // Trachea branch lines in the center (drawn in white/holographic opacity)
    final trachea = Path();
    trachea.moveTo(center.dx, center.dy - r * 0.85);
    trachea.lineTo(center.dx, center.dy - r * 0.2);
    trachea.lineTo(center.dx - r * 0.3, center.dy + r * 0.1);
    trachea.moveTo(center.dx, center.dy - r * 0.2);
    trachea.lineTo(center.dx + r * 0.3, center.dy + r * 0.1);

    canvas.drawPath(trachea, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.white.withOpacity(0.5)
      ..strokeCap = StrokeCap.round);
  }

  void _draw3DSteps(Canvas canvas, Offset center, double size) {
    final double r = size * 0.8;
    
    // Draw running footprints or stylized steps arcs
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..color = color.withOpacity(0.15);
    
    // Concentric backing tracks
    canvas.drawArc(Rect.fromCircle(center: center, radius: r * 0.8), -math.pi / 2, 2 * math.pi, false, trackPaint);
    
    // Front active track gradient
    final activePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [color.withOpacity(0.1), color, color.withGreen((color.green + 50).clamp(0, 255))],
      ).createShader(Rect.fromCircle(center: center, radius: r * 0.8));
    
    final double angle = animValue * 2 * math.pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: r * 0.8), -math.pi / 2, angle, false, activePaint);

    // Draw little running/walking footstep in the middle
    final shoePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center - Offset(r * 0.15, r * 0.05), r * 0.15, shoePaint);
    canvas.drawCircle(center + Offset(r * 0.15, r * 0.15), r * 0.15, shoePaint);
  }

  void _draw3DCalories(Canvas canvas, Offset center, double size) {
    final double r = size * 0.9;
    
    // Draw stylized layered flames
    final flame = Path();
    flame.moveTo(center.dx, center.dy + r * 0.8);
    flame.quadraticBezierTo(center.dx - r * 0.7, center.dy + r * 0.6, center.dx - r * 0.6, center.dy);
    flame.quadraticBezierTo(center.dx - r * 0.6, center.dy - r * 0.5, center.dx - r * 0.1, center.dy - r * 0.8);
    flame.quadraticBezierTo(center.dx - r * 0.4, center.dy - r * 0.2, center.dx - r * 0.1, center.dy + r * 0.1);
    flame.quadraticBezierTo(center.dx + r * 0.1, center.dy - r * 0.6, center.dx + r * 0.4, center.dy - r * 0.9);
    flame.quadraticBezierTo(center.dx + r * 0.3, center.dy - r * 0.1, center.dx + r * 0.6, center.dy + r * 0.2);
    flame.quadraticBezierTo(center.dx + r * 0.7, center.dy + r * 0.6, center.dx, center.dy + r * 0.8);
    flame.close();

    canvas.drawPath(flame, Paint()
      ..color = color.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5));

    canvas.drawPath(flame, Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [color, color.withRed((color.red + 60).clamp(0, 255)), Colors.amber],
      ).createShader(Rect.fromCircle(center: center, radius: r))
      ..style = PaintingStyle.fill);
  }

  void _draw3DRecovery(Canvas canvas, Offset center, double size) {
    final double r = size * 0.9;
    
    // Stylized lightning bolt or progress
    final bolt = Path();
    bolt.moveTo(center.dx + r * 0.1, center.dy - r * 0.8);
    bolt.lineTo(center.dx - r * 0.5, center.dy + r * 0.1);
    bolt.lineTo(center.dx - r * 0.05, center.dy + r * 0.1);
    bolt.lineTo(center.dx - r * 0.15, center.dy + r * 0.8);
    bolt.lineTo(center.dx + r * 0.45, center.dy - r * 0.1);
    bolt.lineTo(center.dx + r * 0.02, center.dy - r * 0.1);
    bolt.close();

    canvas.drawPath(bolt, Paint()
      ..color = color.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));

    canvas.drawPath(bolt, Paint()
      ..shader = LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [color, color.withGreen((color.green + 40).clamp(0, 255)), Colors.cyanAccent],
      ).createShader(Rect.fromCircle(center: center, radius: r))
      ..style = PaintingStyle.fill);
  }

  void _draw3DWatch(Canvas canvas, Offset center, double size) {
    final double r = size * 0.9;
    final wrist = Path();
    
    // Draw smartwatch silhouette
    wrist.moveTo(center.dx - r * 0.35, center.dy - r * 0.85);
    wrist.lineTo(center.dx + r * 0.35, center.dy - r * 0.85);
    wrist.lineTo(center.dx + r * 0.3, center.dy + r * 0.85);
    wrist.lineTo(center.dx - r * 0.3, center.dy + r * 0.85);
    wrist.close();

    canvas.drawPath(wrist, Paint()..color = Colors.black.withOpacity(0.18));

    final body = Rect.fromCenter(center: center, width: r * 0.95, height: r * 0.95);
    canvas.drawRRect(RRect.fromRectAndRadius(body, Radius.circular(r * 0.25)), Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color, color.withBlue((color.blue - 40).clamp(0, 255))],
      ).createShader(body)
      ..style = PaintingStyle.fill);

    // Inner watch face glowing ring
    canvas.drawCircle(center, r * 0.35, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.white.withOpacity(0.4));
  }

  void _draw3DBrain(Canvas canvas, Offset center, double size) {
    final double r = size * 0.8;
    
    // Stylized cloud-like brain lobes
    final brainPath = Path();
    brainPath.moveTo(center.dx - r * 0.1, center.dy - r * 0.7);
    brainPath.cubicTo(center.dx - r * 0.6, center.dy - r * 0.8, center.dx - r * 0.9, center.dy - r * 0.3, center.dx - r * 0.7, center.dy + r * 0.1);
    brainPath.cubicTo(center.dx - r * 0.8, center.dy + r * 0.5, center.dx - r * 0.4, center.dy + r * 0.7, center.dx - r * 0.1, center.dy + r * 0.5);
    brainPath.cubicTo(center.dx + r * 0.2, center.dy + r * 0.7, center.dx + r * 0.6, center.dy + r * 0.5, center.dx + r * 0.5, center.dy + r * 0.1);
    brainPath.cubicTo(center.dx + r * 0.7, center.dy - r * 0.3, center.dx + r * 0.4, center.dy - r * 0.8, center.dx + r * 0.1, center.dy - r * 0.7);
    brainPath.close();

    canvas.drawPath(brainPath, Paint()
      ..color = color.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));

    canvas.drawPath(brainPath, Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color.withOpacity(0.9), color, color.withRed((color.red + 50).clamp(0, 255))],
      ).createShader(Rect.fromCircle(center: center, radius: r))
      ..style = PaintingStyle.fill);

    // Glowing synapse connections
    final synapsePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(center - Offset(r * 0.2, r * 0.2), center + Offset(r * 0.1, r * 0.15), synapsePaint);
    canvas.drawLine(center + Offset(r * 0.2, -r * 0.1), center - Offset(r * 0.3, -r * 0.2), synapsePaint);

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center - Offset(r * 0.2, r * 0.2), 3.0, dotPaint);
    canvas.drawCircle(center + Offset(r * 0.1, r * 0.15), 3.0, dotPaint);
    canvas.drawCircle(center + Offset(r * 0.2, -r * 0.1), 3.0, dotPaint);
    canvas.drawCircle(center - Offset(r * 0.3, -r * 0.2), 3.0, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _Stylized3DPainter oldDelegate) {
    return oldDelegate.type != type || oldDelegate.color != color || oldDelegate.animValue != animValue;
  }
}
