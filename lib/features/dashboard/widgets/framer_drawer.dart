import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class FuturisticDrawer extends StatelessWidget {
  const FuturisticDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final drawerBg = isDark
        ? const Color(0xFF131127).withOpacity(0.9)
        : Colors.white.withOpacity(0.95);
    final borderColor = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.05);

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: drawerBg,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          border: Border(
            right: BorderSide(color: borderColor, width: 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            
            // Profile Area Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GlassCard(
                padding: const EdgeInsets.all(12),
                borderRadius: 24,
                hasGlow: true,
                glowColor: AppTheme.cyanAccent.withOpacity(0.1),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.cyanAccent, width: 2),
                        image: const DecorationImage(
                          image: NetworkImage('https://i.pravatar.cc/150?img=33'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Alex Martinez',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.emeraldHealth.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'TIR: 85%',
                              style: TextStyle(
                                color: AppTheme.emeraldHealth,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'METABOLIC MODULES',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textSecondary,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Expandable Module list
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: const [
                  DrawerModuleGroup(
                    title: 'AI Assistant',
                    icon: LucideIcons.bot,
                    accentColor: AppTheme.purpleAI,
                    subItems: [
                      DrawerSubItem(label: 'Suggestions Feed', route: '/suggestions-feed'),
                      DrawerSubItem(label: 'Daily Summary', route: '/daily-summary'),
                      DrawerSubItem(label: 'Chat Companion', route: '/ai-assistant'),
                      DrawerSubItem(label: 'Voice Assistant', route: '/voice-assistant'),
                      DrawerSubItem(label: 'Multimodal Scan', route: '/multimodal-assistant'),
                      DrawerSubItem(label: 'Interaction History', route: '/ai-history', isLast: true),
                    ],
                  ),
                  DrawerModuleGroup(
                    title: 'Glucose Management',
                    icon: LucideIcons.activity,
                    accentColor: AppTheme.emeraldHealth,
                    subItems: [
                      DrawerSubItem(label: 'Glucose Dashboard', route: '/glucose-dashboard'),
                      DrawerSubItem(label: 'Manual Entry', route: '/glucose-manual-entry'),
                      DrawerSubItem(label: 'OCR Scanner', route: '/glucose-ocr-scanner'),
                      DrawerSubItem(label: 'AI Forecast', route: '/glucose-prediction'),
                      DrawerSubItem(label: 'Risk Alerts', route: '/risk-alert'),
                      DrawerSubItem(label: 'Glucose History', route: '/glucose-history', isLast: true),
                    ],
                  ),
                  DrawerModuleGroup(
                    title: 'Food & Nutrition',
                    icon: LucideIcons.scale,
                    accentColor: AppTheme.cyanAccent,
                    subItems: [
                      DrawerSubItem(label: 'Food Camera', route: '/food-camera'),
                      DrawerSubItem(label: 'Capture Preview', route: '/meal-capture-preview'),
                      DrawerSubItem(label: 'Recognition Detail', route: '/food-recognition-result'),
                      DrawerSubItem(label: 'Ingredient Detection', route: '/ingredient-detection'),
                      DrawerSubItem(label: 'Portion Estimation', route: '/portion-estimation'),
                      DrawerSubItem(label: 'Nutrition Analysis', route: '/meal-nutrition-analysis'),
                      DrawerSubItem(label: 'AI Recommendation', route: '/ai-meal-recommendation'),
                      DrawerSubItem(label: 'Dietary History', route: '/food-history', isLast: true),
                    ],
                  ),
                  DrawerModuleGroup(
                    title: 'Cooking AI',
                    icon: LucideIcons.chefHat,
                    accentColor: AppTheme.purpleAI,
                    subItems: [
                      DrawerSubItem(label: 'Cooking Assistant', route: '/cooking-assistant'),
                      DrawerSubItem(label: 'Live Stove Camera', route: '/live-cooking-camera'),
                      DrawerSubItem(label: 'Cooking Analysis', route: '/cooking-analysis'),
                      DrawerSubItem(label: 'Recipe Guidance', route: '/recipe-guidance', isLast: true),
                    ],
                  ),
                  DrawerModuleGroup(
                    title: 'Wearables & Vitals',
                    icon: LucideIcons.footprints,
                    accentColor: AppTheme.emeraldHealth,
                    subItems: [
                      DrawerSubItem(label: 'Wearable Dashboard', route: '/wearable-dashboard'),
                      DrawerSubItem(label: 'Galaxy Fit 3 Sync', route: '/wearable-setup'),
                      DrawerSubItem(label: 'Activity Analytics', route: '/activity-analytics'),
                      DrawerSubItem(label: 'Sleep Analytics', route: '/sleep-analytics'),
                      DrawerSubItem(label: 'Heart Rate Trends', route: '/heart-rate-trends', isLast: true),
                    ],
                  ),
                  DrawerModuleGroup(
                    title: 'Smart Glasses',
                    icon: LucideIcons.glasses,
                    accentColor: AppTheme.cyanAccent,
                    subItems: [
                      DrawerSubItem(label: 'Glasses Dashboard', route: '/smart-glasses-dashboard'),
                      DrawerSubItem(label: 'Pairing Setup', route: '/smart-glasses-pairing'),
                      DrawerSubItem(label: 'Live HUD View', route: '/smart-glasses-live-view'),
                      DrawerSubItem(label: 'Overlay Preview', route: '/smart-glasses-overlay-preview'),
                      DrawerSubItem(label: 'Settings Configuration', route: '/smart-glasses-settings', isLast: true),
                    ],
                  ),
                  DrawerModuleGroup(
                    title: 'Twin & Simulation',
                    icon: LucideIcons.cpu,
                    accentColor: AppTheme.purpleAI,
                    subItems: [
                      DrawerSubItem(label: 'Analytics Panel', route: '/analytics-dashboard'),
                      DrawerSubItem(label: 'Weekly Insights', route: '/weekly-insights'),
                      DrawerSubItem(label: 'Monthly Report', route: '/monthly-report'),
                      DrawerSubItem(label: 'Digital Twin Model', route: '/digital-twin'),
                      DrawerSubItem(label: 'What-If Forecast', route: '/what-if-simulation', isLast: true),
                    ],
                  ),
                  DrawerModuleGroup(
                    title: 'Community Dataset',
                    icon: LucideIcons.users,
                    accentColor: AppTheme.emeraldHealth,
                    subItems: [
                      DrawerSubItem(label: 'Health Feed', route: '/community-feed'),
                      DrawerSubItem(label: 'Contribute Data', route: '/food-contribution'),
                      DrawerSubItem(label: 'Dataset Validation', route: '/dataset-validation'),
                      DrawerSubItem(label: 'Contributor Leaderboard', route: '/contributor-leaderboard', isLast: true),
                    ],
                  ),
                  DrawerModuleGroup(
                    title: 'Settings & System',
                    icon: LucideIcons.settings,
                    accentColor: Colors.blueGrey,
                    subItems: [
                      DrawerSubItem(label: 'User Profile', route: '/profile'),
                      DrawerSubItem(label: 'Notifications Center', route: '/notifications'),
                      DrawerSubItem(label: 'Privacy & Security', route: '/privacy-security'),
                      DrawerSubItem(label: 'Language Configuration', route: '/language-settings'),
                      DrawerSubItem(label: 'Admin Research Desk', route: '/admin-dashboard', isLast: true),
                    ],
                  ),
                ],
              ),
            ),
            
            // Sign Out Option
            const Divider(color: AppTheme.surfaceHighlight),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                context.pop(); // Close drawer
                context.go('/welcome');
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: const [
                    Icon(LucideIcons.logOut, color: AppTheme.error, size: 20),
                    SizedBox(width: 16),
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        color: AppTheme.error,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Collapsible Module Group Widget
class DrawerModuleGroup extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color accentColor;
  final List<DrawerSubItem> subItems;

  const DrawerModuleGroup({
    super.key,
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.subItems,
  });

  @override
  State<DrawerModuleGroup> createState() => _DrawerModuleGroupState();
}

class _DrawerModuleGroupState extends State<DrawerModuleGroup> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: _isExpanded 
                    ? widget.accentColor.withOpacity(0.08) 
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: _isExpanded
                    ? Border.all(color: widget.accentColor.withOpacity(0.15), width: 1)
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon, 
                    color: _isExpanded ? widget.accentColor : AppTheme.textSecondary, 
                    size: 20,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: _isExpanded ? FontWeight.bold : FontWeight.w600,
                        fontSize: 13,
                        color: _isExpanded ? AppTheme.textPrimary : AppTheme.textSecondary,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      LucideIcons.chevronRight, 
                      color: _isExpanded ? widget.accentColor : AppTheme.textSecondary.withOpacity(0.5), 
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: _isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: widget.subItems,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// Custom Sub-Item Widget representing leaf nodes in navigation tree
class DrawerSubItem extends StatelessWidget {
  final String label;
  final String route;
  final bool isLast;

  const DrawerSubItem({
    super.key,
    required this.label,
    required this.route,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lineColor = isDark 
        ? AppTheme.cyanAccent.withOpacity(0.18) 
        : AppTheme.cyanAccent.withOpacity(0.35);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(width: 28), // Indentation offset
          CustomPaint(
            size: const Size(20, double.infinity),
            painter: ConnectorLinePainter(isLast: isLast, lineColor: lineColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: () {
                context.pop(); // Close drawer
                context.push(route);
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Tree Connection Line Painter
class ConnectorLinePainter extends CustomPainter {
  final bool isLast;
  final Color lineColor;

  ConnectorLinePainter({required this.isLast, required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    // Draw vertical connection trunk
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, isLast ? size.height / 2 : size.height),
      paint,
    );

    // Draw branch connector line to the right
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    // Draw node endpoint bullet indicator
    final dotPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width, size.height / 2), 2.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant ConnectorLinePainter oldDelegate) {
    return oldDelegate.isLast != isLast || oldDelegate.lineColor != lineColor;
  }
}
