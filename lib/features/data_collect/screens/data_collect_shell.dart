import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';

class DataCollectShell extends StatelessWidget {
  const DataCollectShell({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.backgroundDark.withOpacity(0.9) : Colors.white.withOpacity(0.9),
          border: Border(top: BorderSide(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05))),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => _onTap(context, index),
          backgroundColor: Colors.transparent,
          indicatorColor: AppTheme.cyanAccent.withOpacity(0.15),
          elevation: 0,
          destinations: [
            NavigationDestination(
              icon: Icon(LucideIcons.layoutDashboard, color: AppTheme.textSecondary),
              selectedIcon: const Icon(LucideIcons.layoutDashboard, color: AppTheme.cyanAccent),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.database, color: AppTheme.textSecondary),
              selectedIcon: const Icon(LucideIcons.database, color: AppTheme.cyanAccent),
              label: 'Database',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.library, color: AppTheme.textSecondary),
              selectedIcon: const Icon(LucideIcons.library, color: AppTheme.cyanAccent),
              label: 'Gallery',
            ),
          ],
        ),
      ),
    );
  }
}
