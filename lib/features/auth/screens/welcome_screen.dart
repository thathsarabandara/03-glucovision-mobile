import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/glucovision_logo_widget.dart';
import '../../../core/widgets/stylized_3d_icon.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  double _currentPageValue = 0.0;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'iconType': StylizedIconType.brain,
      'title': 'Point, Scan, Understand',
      'headline': 'Computer Vision Recognition',
      'description': 'Instantly recognize any meal on your plate with state-of-the-art volumetric visual AI. No manual logs, just pure metabolic insight.',
      'color': AppTheme.cyanAccent,
    },
    {
      'iconType': StylizedIconType.calories,
      'title': 'Precision on Your Plate',
      'headline': 'Spatial Volume Estimation',
      'description': 'Our spatial AI model calculates portion size and volume in real-time, matching your specific dietary parameters perfectly.',
      'color': AppTheme.purpleAI,
    },
    {
      'iconType': StylizedIconType.watch,
      'title': 'Synchronize Your Vitals',
      'headline': 'Wearable Health Ecosystem',
      'description': 'Connect with Galaxy Fit, Health Connect, and smart bands to track your activity, heart rate, and sleep continuously.',
      'color': AppTheme.emeraldHealth,
    },
    {
      'iconType': StylizedIconType.recovery,
      'title': 'Augment Your Reality',
      'headline': 'Smart Glasses Integration',
      'description': 'Stream real-time nutritional HUD overlays directly to your smart glasses. See health insights right before your eyes.',
      'color': const Color(0xFF8B5CF6), // Indigo
    },
    {
      'iconType': StylizedIconType.calories,
      'title': 'Demystify Your Nutrition',
      'headline': 'Automated Calorie Analytics',
      'description': 'Receive automated, detailed breakdown of macro and micronutrients. Keep your fuel clean and optimized.',
      'color': AppTheme.warning,
    },
    {
      'iconType': StylizedIconType.heart,
      'title': 'Predict the Future',
      'headline': 'Metabolic Forecasting Models',
      'description': 'Anticipate glucose spikes and crashes hours in advance with predictive analytics, keeping your metabolic health stable.',
      'color': AppTheme.error,
    },
    {
      'iconType': StylizedIconType.brain,
      'title': 'Your Metabolic Clone',
      'headline': 'Advanced Digital Twin AI',
      'description': 'Simulate meal impacts and fitness regimes on a virtual digital twin of your metabolic system before you even take a bite.',
      'color': const Color(0xFFEC4899), // Pink
    },
    {
      'iconType': StylizedIconType.recovery,
      'title': 'Meet Your AI Companion',
      'headline': '24/7 Personal Health Coach',
      'description': 'An emotionally supportive, hyper-personalized health coach available 24/7. Chat, seek recipes, or get warning triggers anytime.',
      'color': const Color(0xFF06B6D4), // Cyan
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page ?? 0.0;
        _currentPage = _currentPageValue.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Color get _activeColor {
    int index = _currentPageValue.floor();
    if (index >= _slides.length - 1) {
      return _slides[_slides.length - 1]['color'] as Color;
    }
    double fraction = _currentPageValue - index;
    final startColor = _slides[index]['color'] as Color;
    final endColor = _slides[index + 1]['color'] as Color;
    return Color.lerp(startColor, endColor, fraction) ?? startColor;
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = _activeColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Stack(
        children: [
          // Ambient glowing backdrops that move dynamically with slide transitions
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: (-50 + (math.sin(_currentPageValue * math.pi / 4) * 30)).toDouble(),
            right: (-50 - (math.cos(_currentPageValue * math.pi / 4) * 30)).toDouble(),
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activeColor.withOpacity(isDark ? 0.08 : 0.05),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withOpacity(isDark ? 0.08 : 0.05),
                    blurRadius: 100,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  
                  // App Brand Logo Banner
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const GlucoVisionLogoWidget(size: 40),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'GLUCOVISION',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              fontSize: 13,
                              color: activeColor,
                            ),
                          ),
                          Text(
                            'Connect.Protect.Care',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 8,
                              color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Sliding Onboarding visual body
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _slides.length,
                      itemBuilder: (context, index) {
                        final slide = _slides[index];
                        final slideColor = slide['color'] as Color;
                        final StylizedIconType iconType = slide['iconType'] as StylizedIconType;
                        final double position = index - _currentPageValue;
                        
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final double width = constraints.maxWidth;
                            
                            // Visual parallax translations
                            final double graphicTranslateX = position * (width * 0.4);
                            final double graphicOpacity = (1.0 - position.abs() * 1.5).clamp(0.0, 1.0);
                            final double scale = (1.0 - position.abs() * 0.15).clamp(0.85, 1.0);
                            
                            // Text block transitions
                            final double textTranslateX = position * (width * 0.25);
                            final double textOpacity = (1.0 - position.abs() * 1.2).clamp(0.0, 1.0);

                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                // 1. Central 3D Icon Presentation
                                Positioned(
                                  top: 20,
                                  height: 220,
                                  child: Opacity(
                                    opacity: graphicOpacity,
                                    child: Transform.translate(
                                      offset: Offset(graphicTranslateX, 0),
                                      child: Transform.scale(
                                        scale: scale,
                                        child: Center(
                                          child: Stylized3DIcon(
                                            type: iconType,
                                            size: 160,
                                            baseColor: slideColor,
                                            animate: index == _currentPage,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // 2. Floating Text description card
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 10,
                                  height: 280,
                                  child: Opacity(
                                    opacity: textOpacity,
                                    child: Transform.translate(
                                      offset: Offset(textTranslateX, 0),
                                      child: GlassCard(
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                        borderRadius: 28,
                                        hasGlow: true,
                                        glowColor: slideColor.withOpacity(0.1),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              slide['title'] as String,
                                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              slide['headline'] as String,
                                              style: TextStyle(
                                                color: slideColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Expanded(
                                              child: Text(
                                                slide['description'] as String,
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  height: 1.5,
                                                  fontSize: 13,
                                                  color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),

                                            // Bottom minimal navigation row
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Skip
                                                TextButton(
                                                  onPressed: () => context.push('/register'),
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                                                  ),
                                                  child: const Text(
                                                    'Skip',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                
                                                // Progress indicators
                                                Row(
                                                  children: List.generate(
                                                    _slides.length,
                                                    (index) {
                                                      final double distance = (index - _currentPageValue).abs();
                                                      final double scale = (distance <= 1.0) ? (1.0 - distance) : 0.0;
                                                      final double width = 8.0 + (12.0 * scale);
                                                      
                                                      return AnimatedContainer(
                                                        duration: const Duration(milliseconds: 150),
                                                        margin: const EdgeInsets.symmetric(horizontal: 3),
                                                        height: 8,
                                                        width: width,
                                                        decoration: BoxDecoration(
                                                          color: distance < 0.5 
                                                              ? activeColor 
                                                              : (isDark ? AppTheme.surfaceHighlightDark : AppTheme.surfaceHighlight),
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                
                                                // Next/Get Started Button
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (_currentPage < _slides.length - 1) {
                                                      _pageController.nextPage(
                                                        duration: const Duration(milliseconds: 400),
                                                        curve: Curves.easeInOutCubic,
                                                      );
                                                    } else {
                                                      context.push('/register');
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: activeColor,
                                                    foregroundColor: Colors.white,
                                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    elevation: 2,
                                                  ),
                                                  child: Text(
                                                    _currentPage < _slides.length - 1 ? 'Next' : 'Get Started',
                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            
                                            // Login redirection
                                            Center(
                                              child: TextButton(
                                                onPressed: () => context.push('/login'),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: 'Already have an account? ',
                                                    style: TextStyle(
                                                      color: isDark ? AppTheme.textSecondaryDark : AppTheme.textSecondary,
                                                      fontSize: 13,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'Log In',
                                                        style: TextStyle(
                                                          color: activeColor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
