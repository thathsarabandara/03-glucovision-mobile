import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:glucovision_mobile/core/theme/app_theme.dart';

class AnimatedAIFab extends StatefulWidget {
  final VoidCallback onPressed;

  const AnimatedAIFab({super.key, required this.onPressed});

  @override
  State<AnimatedAIFab> createState() => _AnimatedAIFabState();
}

class _AnimatedAIFabState extends State<AnimatedAIFab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 8.0, end: 24.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.cyanAccent.withOpacity(0.4),
                blurRadius: _glowAnimation.value,
                spreadRadius: _glowAnimation.value / 4,
              ),
              BoxShadow(
                color: AppTheme.purpleAI.withOpacity(0.3),
                blurRadius: _glowAnimation.value * 1.5,
                spreadRadius: _glowAnimation.value / 2,
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: widget.onPressed,
            backgroundColor: AppTheme.surfaceHighlight,
            elevation: 0,
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [AppTheme.cyanAccent, AppTheme.purpleAI],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Icon(
                LucideIcons.bot,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  }
}
