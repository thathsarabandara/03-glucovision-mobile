import 'dart:math' as math;
import 'package:flutter/material.dart';

/// GlucoVision "Orbital Sync" animated logo graphic.
///
/// Animation sequence (6 s loop):
///  0–30%   Blue ring draws itself in via PathMetric extraction (opacity 0-3% fade-in)
///  0–32%   Green ring draws itself in (opacity 0-6% fade-in)
///  32–48%  Eye scales + fades in from centre (ease-in-out)
///  44–58%  Medical cross scales + fades in (ease-in-out)
///  58–80%  Full logo holds
///  80–93%  Everything fades out (global alpha)
///  93–100% Blank pause before next loop
class GlucoVisionLogoWidget extends StatefulWidget {
  final double size;
  final AnimationController? controller;

  const GlucoVisionLogoWidget({
    super.key,
    this.size = 110,
    this.controller,
  });

  @override
  State<GlucoVisionLogoWidget> createState() => _GlucoVisionLogoWidgetState();
}

class _GlucoVisionLogoWidgetState extends State<GlucoVisionLogoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _isLocalController = false;

  late Animation<double> _blueRing;
  late Animation<double> _greenRing;
  late Animation<double> _eyeOpacity;
  late Animation<double> _eyeScale;
  late Animation<double> _crossOpacity;
  late Animation<double> _crossScale;
  late Animation<double> _globalAlpha;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _ctrl = widget.controller!;
    } else {
      _ctrl = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 6000),
      )..repeat();
      _isLocalController = true;
    }

    // Blue ring progress: 0 to 30% drawing
    _blueRing = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 13),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 7),
    ]).animate(_ctrl);

    // Green ring progress: 0 to 32% drawing
    _greenRing = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 32,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 48),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 13),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 7),
    ]).animate(_ctrl);

    // Eye Opacity: 32 to 48% fade-in, 80 to 93% fade-out
    _eyeOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 32),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 16,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 32),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 13,
      ),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 7),
    ]).animate(_ctrl);

    // Eye Scale: 32 to 48% scale-in (0.1 to 1.0), 80 to 93% scale-down (1.0 to 0.95), 93 to 100% reset
    _eyeScale = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.1), weight: 32),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.1, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 16,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 32),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.95)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 13,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 0.1)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 7,
      ),
    ]).animate(_ctrl);

    // Cross Opacity: 44 to 58% fade-in, 80 to 93% fade-out
    _crossOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 44),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 14,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 22),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 13,
      ),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 7),
    ]).animate(_ctrl);

    // Cross Scale: 44 to 58% scale-in (0.2 to 1.0), 80 to 93% scale-down (1.0 to 0.95), 93 to 100% reset
    _crossScale = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.2), weight: 44),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 14,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 22),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.95)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 13,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 0.2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 7,
      ),
    ]).animate(_ctrl);

    // Global Alpha: 0 to 80% hold (1.0), 80 to 93% fade-out (1.0 to 0.0), 93 to 100% blank
    _globalAlpha = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 80),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 13,
      ),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 7),
    ]).animate(_ctrl);
  }

  @override
  void dispose() {
    if (_isLocalController) {
      _ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        // Individual ring fade-in opacities based on HTML keyframes:
        // Blue ring: opacity 0 to 1 between 0% and 3%
        final double blueOpacity = (_ctrl.value / 0.03).clamp(0.0, 1.0);
        // Green ring: opacity 0 to 1 between 0% and 6%
        final double greenOpacity = (_ctrl.value / 0.06).clamp(0.0, 1.0);

        return Opacity(
          opacity: _globalAlpha.value.clamp(0.0, 1.0),
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _LogoPainter(
              blueRingProgress: _blueRing.value,
              blueRingOpacity: blueOpacity,
              greenRingProgress: _greenRing.value,
              greenRingOpacity: greenOpacity,
              eyeOpacity: _eyeOpacity.value,
              eyeScale: _eyeScale.value,
              crossOpacity: _crossOpacity.value,
              crossScale: _crossScale.value,
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CustomPainter  —  all coordinates in a 100×100 logical space
// ─────────────────────────────────────────────────────────────────────────────
class _LogoPainter extends CustomPainter {
  final double blueRingProgress;
  final double blueRingOpacity;
  final double greenRingProgress;
  final double greenRingOpacity;
  final double eyeOpacity;
  final double eyeScale;
  final double crossOpacity;
  final double crossScale;

  const _LogoPainter({
    required this.blueRingProgress,
    required this.blueRingOpacity,
    required this.greenRingProgress,
    required this.greenRingOpacity,
    required this.eyeOpacity,
    required this.eyeScale,
    required this.crossOpacity,
    required this.crossScale,
  });

  static const double _cx = 50.0;
  static const double _cy = 50.0;

  @override
  void paint(Canvas canvas, Size size) {
    // Scale 100×100 logical → widget pixel size
    canvas.scale(size.width / 100.0);

    const center = Offset(_cx, _cy);

    // ── Blue ring   rx=42, ry=15, tilt −44° ──
    _drawRing(
      canvas,
      center: center,
      rx: 42,
      ry: 15,
      angleRad: -44 * math.pi / 180,
      progress: blueRingProgress,
      opacity: blueRingOpacity,
      colors: const [
        Color(0xFF1e40af),
        Color(0xFF60a5fa),
        Color(0xFF1d4ed8),
      ],
      stops: const [0.0, 0.5, 1.0],
      strokeWidth: 6.0,
    );

    // ── Green ring  rx=43, ry=13, tilt +40° ──
    _drawRing(
      canvas,
      center: center,
      rx: 43,
      ry: 13,
      angleRad: 40 * math.pi / 180,
      progress: greenRingProgress * 0.88, // Limit to 88% to keep the gap of white space for the cross
      opacity: greenRingOpacity,
      colors: const [
        Color(0xFF0f766e),
        Color(0xFF2dd4bf),
        Color(0xFF0d9488),
      ],
      stops: const [0.0, 0.5, 1.0],
      strokeWidth: 6.0,
    );

    // ── Eye ──
    if (eyeOpacity > 0 && eyeScale > 0) {
      canvas.save();
      canvas.translate(_cx, _cy);
      canvas.scale(eyeScale);
      canvas.translate(-_cx, -_cy);
      _drawEye(canvas, center, eyeOpacity);
      canvas.restore();
    }

    // ── Medical cross ──
    if (crossOpacity > 0 && crossScale > 0) {
      const crossCx = 83.0;
      const crossCy = 69.0;
      canvas.save();
      canvas.translate(crossCx, crossCy);
      canvas.scale(crossScale);
      canvas.translate(-crossCx, -crossCy);
      _drawCross(canvas, crossOpacity);
      canvas.restore();
    }
  }

  // ── Ring draw helper ─────────────────────────────────────────────────────
  void _drawRing(
    Canvas canvas, {
    required Offset center,
    required double rx,
    required double ry,
    required double angleRad,
    required double progress,
    required double opacity,
    required List<Color> colors,
    required List<double> stops,
    required double strokeWidth,
  }) {
    if (progress <= 0 || opacity <= 0) return;

    // Build full ellipse path centred at origin (canvas is translated later)
    final fullPath = Path()
      ..addOval(
        Rect.fromCenter(center: Offset.zero, width: rx * 2, height: ry * 2),
      );

    // Extract partial path proportional to animation progress
    final metrics = fullPath.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final extracted =
        metrics.first.extractPath(0, metrics.first.length * progress);

    final gradientRect =
        Rect.fromCenter(center: Offset.zero, width: rx * 2, height: ry * 2);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angleRad);

    // Glow layer (blurred gradient matching HTML stdDeviation="1.6")
    final glowColors = colors.map((c) => c.withOpacity(0.5 * opacity)).toList();
    canvas.drawPath(
      extracted,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(colors: glowColors, stops: stops).createShader(gradientRect)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.6),
    );

    // Main stroke with gradient
    final strokeColors = colors.map((c) => c.withOpacity(opacity)).toList();
    canvas.drawPath(
      extracted,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(colors: strokeColors, stops: stops).createShader(gradientRect),
    );

    canvas.restore();
  }

  // ── Eye draw helper ──────────────────────────────────────────────────────
  void _drawEye(Canvas canvas, Offset c, double opacity) {
    // 1. Drop shadow (HTML dx="0" dy="2" stdDeviation="3" flood-color="#1e3a8a" flood-opacity=".38")
    final shadowPaint = Paint()
      ..color = const Color(0xFF1e3a8a).withOpacity(0.38 * opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
    canvas.drawCircle(c + const Offset(0, 2), 12, shadowPaint);

    // 2. Iris (HTML r="12" fill="url(#gEye)" where cx="36%" cy="32%" r="65%")
    final irisRect = Rect.fromCircle(center: c, radius: 12);
    canvas.drawCircle(
      c,
      8,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.28, -0.36),
          radius: 0.65,
          colors: [
            const Color(0xFF93c5fd).withOpacity(opacity),
            const Color(0xFF2563eb).withOpacity(opacity),
            const Color(0xFF1e3a8a).withOpacity(opacity),
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(irisRect),
    );

    // 3. Outer accent ring (HTML r="17.5" stroke="#3b82f6" stroke-width="1" opacity=".4")
    canvas.drawCircle(
      c,
      13.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = const Color(0xFF3b82f6).withOpacity(0.4 * opacity),
    );

    // 4. Pupil (HTML r="5.5" fill="url(#gPup)" where cx="40%" cy="36%" r="60%")
    final pupilRect = Rect.fromCircle(center: c, radius: 5.5);
    canvas.drawCircle(
      c,
      2.5,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.20, -0.28),
          radius: 0.60,
          colors: [
            const Color(0xFF1e40af).withOpacity(opacity),
            const Color(0xFF0f172a).withOpacity(opacity),
          ],
        ).createShader(pupilRect),
    );

    // 5. Primary specular highlight (HTML cx="44.5" cy="44" r="1.5")
    canvas.drawCircle(
      Offset(c.dx - 5.5, c.dy - 6.0),
      1.5,
      Paint()..color = Colors.white.withOpacity(0.88 * opacity),
    );

    // 6. Secondary glint (HTML cx="54" cy="54" r="1.4")
    canvas.drawCircle(
      Offset(c.dx + 4.0, c.dy + 4.0),
      1.4,
      Paint()..color = Colors.white.withOpacity(0.38 * opacity),
    );
  }

  // ── Medical cross draw helper ────────────────────────────────────────────
  void _drawCross(Canvas canvas, double opacity) {
    final horizontalPaint = Paint()
      ..color = const Color(0xFF10b900).withOpacity(opacity)
      ..style = PaintingStyle.fill;
    final verticalPaint = Paint()
      ..color = const Color(0xFF10b981).withOpacity(opacity)
      ..style = PaintingStyle.fill;
    const r = Radius.circular(1.2);

    // Horizontal bar (HTML x="78" y="68" width="10" height="4" rx="1.2")
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(78, 65, 10, 4),
        r,
      ),
      horizontalPaint,
    );
    // Vertical bar (HTML x="81" y="64" width="4" height="10" rx="1.2")
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(81, 62, 4, 10),
        r,
      ),
      verticalPaint,
    );
  }

  @override
  bool shouldRepaint(_LogoPainter old) =>
      old.blueRingProgress != blueRingProgress ||
      old.blueRingOpacity != blueRingOpacity ||
      old.greenRingProgress != greenRingProgress ||
      old.greenRingOpacity != greenRingOpacity ||
      old.eyeOpacity != eyeOpacity ||
      old.eyeScale != eyeScale ||
      old.crossOpacity != crossOpacity ||
      old.crossScale != crossScale;
}
