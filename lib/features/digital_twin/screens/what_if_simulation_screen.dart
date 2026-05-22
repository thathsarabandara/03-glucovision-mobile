import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class WhatIfSimulationScreen extends StatefulWidget {
  const WhatIfSimulationScreen({super.key});

  @override
  State<WhatIfSimulationScreen> createState() => _WhatIfSimulationScreenState();
}

class _WhatIfSimulationScreenState extends State<WhatIfSimulationScreen> {
  double _mealCarbs = 60;
  double _activityMinutes = 0;
  bool _isRunning = false;
  bool _hasResult = false;

  void _runSimulation() {
    setState(() => _isRunning = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() { _isRunning = false; _hasResult = true; });
    });
  }

  @override
  Widget build(BuildContext context) {
    final predictedPeak = (180 - (_activityMinutes * 1.5) - ((_mealCarbs < 60) ? (60 - _mealCarbs) * 0.8 : 0)).clamp(80.0, 240.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('What-If Simulation'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.flaskConical, color: AppTheme.purpleAI),
                      const SizedBox(width: 8),
                      Text('AI Scenario Simulator', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Adjust variables to predict how your glucose will respond.', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 32),

                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Meal Carbs', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('${_mealCarbs.round()}g', style: const TextStyle(color: AppTheme.warning, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        Slider(
                          value: _mealCarbs,
                          min: 10,
                          max: 150,
                          divisions: 14,
                          activeColor: AppTheme.warning,
                          inactiveColor: AppTheme.surfaceHighlight,
                          onChanged: (v) => setState(() { _mealCarbs = v; _hasResult = false; }),
                        ),
                        const Divider(color: AppTheme.surfaceHighlight),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Post-Meal Activity', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('${_activityMinutes.round()} min', style: const TextStyle(color: AppTheme.emeraldHealth, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        Slider(
                          value: _activityMinutes,
                          min: 0,
                          max: 60,
                          divisions: 12,
                          activeColor: AppTheme.emeraldHealth,
                          inactiveColor: AppTheme.surfaceHighlight,
                          onChanged: (v) => setState(() { _activityMinutes = v; _hasResult = false; }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Simulation Result
                  if (_hasResult)
                    GlassCard(
                      hasGlow: true,
                      glowColor: predictedPeak > 140 ? AppTheme.warning : AppTheme.emeraldHealth,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text('Predicted Peak', style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                predictedPeak.round().toString(),
                                style: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                  color: predictedPeak > 140 ? AppTheme.warning : AppTheme.emeraldHealth,
                                ),
                              ),
                              const Text(' mg/dL', style: TextStyle(color: AppTheme.textSecondary)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            predictedPeak > 160 ? 'High spike predicted. Consider reducing carbs or increasing activity.' 
                            : predictedPeak > 140 ? 'Moderate spike expected. On the boundary of your target range.'
                            : 'Within your safe target range. Good meal plan!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: predictedPeak > 140 ? AppTheme.warning : AppTheme.emeraldHealth,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isRunning ? null : _runSimulation,
                  icon: _isRunning
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Icon(LucideIcons.zap, size: 16),
                  label: Text(_isRunning ? 'Simulating...' : 'Run Simulation'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.purpleAI,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
