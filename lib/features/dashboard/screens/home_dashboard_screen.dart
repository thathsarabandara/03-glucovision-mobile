import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/animated_ai_fab.dart';
import '../../../core/widgets/stylized_3d_icon.dart';
import '../widgets/framer_drawer.dart'; // We'll write this drawer next

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF6F5FA);

    return Scaffold(
      backgroundColor: scaffoldBg,
      drawerScrimColor: Colors.black.withOpacity(0.15),
      drawer: const FuturisticDrawer(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Upper Header Banner (Violet-Blue Gradient Panel) ──
              _buildHeaderSection(context, isDark),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── 2x2 Grid Metrics Cards ──
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            context: context,
                            title: 'Muscle Recovery',
                            value: '72%',
                            trend: '↑ 100%  ↓ 53%',
                            trendColor: AppTheme.emeraldHealth,
                            iconType: StylizedIconType.recovery,
                            color: AppTheme.cyanAccent,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMetricCard(
                            context: context,
                            title: 'Steps',
                            value: '1,524',
                            trend: '↓ 50% This day',
                            trendColor: AppTheme.warning,
                            iconType: StylizedIconType.steps,
                            color: AppTheme.emeraldHealth,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            context: context,
                            title: 'Heart',
                            value: '122 bpm',
                            trend: 'Normal 200 bpm',
                            trendColor: AppTheme.textSecondary,
                            iconType: StylizedIconType.heart,
                            color: AppTheme.error,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMetricCard(
                            context: context,
                            title: 'Calory Burned',
                            value: '129 kcal',
                            trend: '↑ 50% This day',
                            trendColor: AppTheme.emeraldHealth,
                            iconType: StylizedIconType.calories,
                            color: AppTheme.warning,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // ── "Check Your Health" Section ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Check Your Health',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/suggestions-feed');
                          },
                          child: const Text(
                            'Show More',
                            style: TextStyle(
                              color: AppTheme.cyanAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Horizontal scroll for organ cards
                    SizedBox(
                      height: 140,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildOrganCard(
                            context: context,
                            title: 'Liver Health',
                            date: 'Last check 12 March 2024',
                            iconType: StylizedIconType.liver,
                            color: const Color(0xFF8B5CF6), // Indigo
                          ),
                          const SizedBox(width: 16),
                          _buildOrganCard(
                            context: context,
                            title: 'Cardiovascular Health',
                            date: 'Last check 12 March 2024',
                            iconType: StylizedIconType.lungs,
                            color: AppTheme.error,
                          ),
                          const SizedBox(width: 16),
                          _buildOrganCard(
                            context: context,
                            title: 'Brain Activity Twin',
                            date: 'Last check 10 March 2024',
                            iconType: StylizedIconType.brain,
                            color: AppTheme.cyanAccent,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Log meal quick access bar
                    GestureDetector(
                      onTap: () => context.push('/food-camera'),
                      child: GlassCard(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        borderRadius: 24,
                        hasGlow: true,
                        glowColor: AppTheme.purpleAI.withOpacity(0.15),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.purpleAI.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(LucideIcons.camera, color: AppTheme.purpleAI),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Quick Volumetric Meal Scanner',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Point camera to automatically estimate calories',
                                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(LucideIcons.chevronRight, color: AppTheme.textSecondary),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 120), // Padding to clear bottom navigation shell
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 72.0),
        child: AnimatedAIFab(
          onPressed: () {
            context.push('/ai-assistant');
          },
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, bool isDark) {
    final Color topBarColor = isDark ? const Color(0xFF1E1B4B) : const Color(0xFF7C3AED); // existing violet accents
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: topBarColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: topBarColor.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            topBarColor,
            topBarColor.withOpacity(0.85),
            topBarColor.withBlue((topBarColor.blue + 30).clamp(0, 255)),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: Menu, Avatar and Top Right icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(LucideIcons.menu, color: Colors.white, size: 24),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                      image: const DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/150?img=33'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning,',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 11,
                        ),
                      ),
                      const Text(
                        'Rucas Bryan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Notification icons
              Row(
                children: [
                  _buildHeaderIconButton(LucideIcons.mail, () {}),
                  const SizedBox(width: 8),
                  _buildHeaderIconButton(LucideIcons.bell, () {
                    context.push('/notifications');
                  }),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Question text
          const Text(
            'How Are You Feeling On\nThis Day?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              height: 1.25,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          
          // Interactive Chat Input Search bar
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(LucideIcons.sparkles, color: Colors.white.withOpacity(0.7), size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    onTap: () => context.push('/ai-assistant'),
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Tell Me About Your Health',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Icon(LucideIcons.mic, color: Colors.white.withOpacity(0.8), size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildMetricCard({
    required BuildContext context,
    required String title,
    required String value,
    required String trend,
    required Color trendColor,
    required StylizedIconType iconType,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 24,
      hasGlow: true,
      glowColor: color.withOpacity(0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Stylized3DIcon(
                type: iconType,
                size: 32,
                baseColor: color,
                animate: true,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            trend,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: trendColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrganCard({
    required BuildContext context,
    required String title,
    required String date,
    required StylizedIconType iconType,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      width: 180,
      padding: const EdgeInsets.all(14),
      borderRadius: 24,
      hasGlow: true,
      glowColor: color.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stylized3DIcon(
                type: iconType,
                size: 40,
                baseColor: color,
                animate: false,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.activity, color: color, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 12,
              color: isDark ? Colors.white : AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
