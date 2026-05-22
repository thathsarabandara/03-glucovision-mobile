import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/animated_ai_fab.dart';
import '../../glucose/screens/glucose_dashboard_screen.dart';
import '../../wearable/screens/wearable_dashboard_screen.dart';
import '../../smart_glasses/screens/smart_glasses_dashboard_screen.dart';
import '../../digital_twin/screens/digital_twin_screen.dart';
import '../widgets/framer_drawer.dart';
import 'home_dashboard_screen.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeDashboardScreen(),
    const GlucoseDashboardScreen(),
    const WearableDashboardScreen(),
    const SmartGlassesDashboardScreen(),
    const DigitalTwinScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MainNavigationShell.scaffoldKey,
      extendBody: true, // Crucial for floating bottom bar overlay effect
      drawerScrimColor: Colors.black.withOpacity(0.15),
      drawer: const FuturisticDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 72,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            borderRadius: 36,
            hasGlow: true,
            glowColor: AppTheme.purpleAI.withOpacity(0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, LucideIcons.home, 'Home'),
                _buildNavItem(1, LucideIcons.activity, 'Glucose'),
                _buildNavItem(2, LucideIcons.footprints, 'Wearables'),
                _buildNavItem(3, LucideIcons.glasses, 'Glasses'),
                _buildNavItem(4, LucideIcons.cpu, 'Digital Twin'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _currentIndex == 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 72.0), // Raise to clear bottom bar
              child: AnimatedAIFab(
                onPressed: () {
                  context.push('/ai-assistant');
                },
              ),
            )
          : null,
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final activeColor = index == 4 
        ? AppTheme.purpleAI 
        : (index == 1 ? AppTheme.emeraldHealth : AppTheme.cyanAccent);

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? Border.all(color: activeColor.withOpacity(0.2), width: 1.5)
              : null,
        ),
        child: AnimatedScale(
          scale: isSelected ? 1.05 : 0.95,
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? activeColor : AppTheme.textSecondary,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? activeColor : AppTheme.textSecondary,
                  fontSize: 9,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
