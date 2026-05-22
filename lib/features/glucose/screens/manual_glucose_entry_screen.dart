import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class ManualGlucoseEntryScreen extends StatefulWidget {
  const ManualGlucoseEntryScreen({super.key});

  @override
  State<ManualGlucoseEntryScreen> createState() => _ManualGlucoseEntryScreenState();
}

class _ManualGlucoseEntryScreenState extends State<ManualGlucoseEntryScreen> {
  final _valueController = TextEditingController();
  final _notesController = TextEditingController();
  String _mealContext = 'Fasting';

  @override
  void dispose() {
    _valueController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Log Glucose',
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
                  // 1. Numerical Entry card
                  GlassCard(
                    padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                    borderRadius: 28,
                    hasGlow: true,
                    glowColor: AppTheme.emeraldHealth.withOpacity(0.12),
                    child: Column(
                      children: [
                        const Text(
                          'Blood Glucose Level',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _valueController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.emeraldHealth,
                            letterSpacing: -2.0,
                          ),
                          decoration: InputDecoration(
                            hintText: '---',
                            hintStyle: TextStyle(
                              color: AppTheme.emeraldHealth.withOpacity(0.2),
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                          ),
                        ),
                        const Text(
                          'mg/dL',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 2. Context Toggles
                  const Text(
                    'Select Context',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Fasting', 'Before Meal', 'After Meal', 'Post Workout', 'Bedtime'].map((ctx) {
                      final isSelected = _mealContext == ctx;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _mealContext = ctx;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppTheme.cyanAccent.withOpacity(0.12) 
                                : (isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02)),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppTheme.cyanAccent : Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                          child: Text(
                            ctx,
                            style: TextStyle(
                              color: isSelected ? AppTheme.cyanAccent : (isDark ? Colors.white70 : AppTheme.textPrimary),
                              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 3. Notes Area
                  const Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    style: TextStyle(color: isDark ? Colors.white : AppTheme.textPrimary, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Add context details (e.g. ate high-carb meal, felt dizzy)',
                      contentPadding: const EdgeInsets.all(16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(color: AppTheme.cyanAccent, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Save CTA Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.emeraldHealth,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Save Entry',
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
}
