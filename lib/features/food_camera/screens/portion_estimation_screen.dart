import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class PortionEstimationScreen extends StatefulWidget {
  const PortionEstimationScreen({super.key});

  @override
  State<PortionEstimationScreen> createState() => _PortionEstimationScreenState();
}

class _PortionEstimationScreenState extends State<PortionEstimationScreen> {
  double _portionScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Adjust Portions',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(LucideIcons.chevronLeft, color: isDark ? Colors.white : AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                children: [
                  // 1. Portion Scale Card
                  GlassCard(
                    padding: const EdgeInsets.all(24),
                    borderRadius: 28,
                    hasGlow: true,
                    glowColor: AppTheme.emeraldHealth.withOpacity(0.08),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.scale, color: AppTheme.emeraldHealth, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Volume Assessment: 450g',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: isDark ? Colors.white : AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'x${_portionScale.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.cyanAccent,
                                letterSpacing: -1.0,
                              ),
                            ),
                            Text(
                              '${(450 * _portionScale).round()} kcal',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: isDark ? Colors.white : AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            activeTrackColor: AppTheme.cyanAccent,
                            inactiveTrackColor: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04),
                            thumbColor: AppTheme.cyanAccent,
                            overlayColor: AppTheme.cyanAccent.withOpacity(0.12),
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                          ),
                          child: Slider(
                            value: _portionScale,
                            min: 0.2,
                            max: 3.0,
                            divisions: 28,
                            onChanged: (val) {
                              setState(() {
                                _portionScale = val;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Drag slider to adjust values manually if required',
                          style: TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // 2. Scaled Macros Title
                  Text(
                    'Scaled Macronutrients',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 3. Macro Adjusters
                  _buildMacroAdjuster(context, 'Carbohydrates', 12, 'g', AppTheme.cyanAccent),
                  const SizedBox(height: 10),
                  _buildMacroAdjuster(context, 'Proteins', 42, 'g', AppTheme.emeraldHealth),
                  const SizedBox(height: 10),
                  _buildMacroAdjuster(context, 'Fats', 22, 'g', AppTheme.purpleAI),
                ],
              ),
            ),
            
            // 4. Confirm Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => context.push('/meal-nutrition-analysis'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.emeraldHealth,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Confirm Portions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroAdjuster(BuildContext context, String label, double baseValue, String unit, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaledValue = (baseValue * _portionScale).toStringAsFixed(1);
    
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      borderRadius: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: isDark ? Colors.white70 : AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          Text(
            '$scaledValue $unit',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
