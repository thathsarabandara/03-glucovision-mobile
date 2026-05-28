import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/data_collect_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class SessionSetupScreen extends ConsumerStatefulWidget {
  const SessionSetupScreen({super.key});

  @override
  ConsumerState<SessionSetupScreen> createState() => _SessionSetupScreenState();
}

class _SessionSetupScreenState extends ConsumerState<SessionSetupScreen> {
  final List<Map<String, String>> _foods = [
    {'id': 'rice_samba', 'name': 'Samba Rice'},
    {'id': 'dhal_curry', 'name': 'Dhal Curry'},
    {'id': 'chicken_curry', 'name': 'Chicken Curry'},
  ];

  @override
  Widget build(BuildContext context) {
    final scenarioType = ref.watch(scenarioTypeProvider);
    final selectedFoodId = ref.watch(selectedFoodIdProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);
    final textColor = isDark ? Colors.white : AppTheme.textPrimary;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text('Session Setup', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select scenario and target food before capturing dataset.',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 32),

            // Scenario Type Toggle
            Text('SCENARIO TYPE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildScenarioButton(
                    context,
                    title: 'Single Dish',
                    icon: LucideIcons.layoutTemplate,
                    isSelected: scenarioType == 'single',
                    onTap: () => ref.read(scenarioTypeProvider.notifier).set('single'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildScenarioButton(
                    context,
                    title: 'Multi Dish',
                    icon: LucideIcons.layoutGrid,
                    isSelected: scenarioType == 'multi',
                    onTap: () => ref.read(scenarioTypeProvider.notifier).set('multi'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Food Selector
            Text('TARGET FOOD', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            GlassCard(
              padding: const EdgeInsets.all(4),
              borderRadius: 16,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedFoodId,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Text('Search food database...', style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
                  ),
                  dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                  isExpanded: true,
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(LucideIcons.chevronDown, color: AppTheme.textSecondary, size: 20),
                  ),
                  items: _foods.map((food) {
                    return DropdownMenuItem(
                      value: food['id'],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(food['name']!, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    ref.read(selectedFoodIdProvider.notifier).set(val);
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => context.push('/data-collect/add-food'),
                icon: const Icon(LucideIcons.plusCircle, size: 16, color: AppTheme.cyanAccent),
                label: const Text('Add New Food', style: TextStyle(color: AppTheme.cyanAccent, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),

            const Spacer(),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  backgroundColor: AppTheme.emeraldHealth,
                  elevation: 4,
                  shadowColor: AppTheme.emeraldHealth.withOpacity(0.4),
                ),
                onPressed: () {
                  if (selectedFoodId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a food first'), backgroundColor: AppTheme.error),
                    );
                    return;
                  }
                  ref.read(sessionManagerProvider).resetSession();
                  context.push('/data-collect/capture', extra: {
                    'plate_type': 'Standard',
                    'background_type': 'Table',
                  });
                },
                child: const Text('Initialize AR Capture', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioButton(BuildContext context, {required String title, required IconData icon, required bool isSelected, required VoidCallback onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected 
              ? AppTheme.cyanAccent.withOpacity(0.1) 
              : (isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02)),
            border: Border.all(
              color: isSelected ? AppTheme.cyanAccent : (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)), 
              width: 1.5
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? AppTheme.cyanAccent : AppTheme.textSecondary, size: 28),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: isSelected ? AppTheme.cyanAccent : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
