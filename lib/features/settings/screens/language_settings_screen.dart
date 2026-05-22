import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selected = 'English';
  final _languages = [
    {'name': 'English', 'native': 'English', 'flag': '🇬🇧'},
    {'name': 'Sinhala', 'native': 'සිංහල', 'flag': '🇱🇰'},
    {'name': 'Tamil', 'native': 'தமிழ்', 'flag': '🇱🇰'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Language Settings',
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
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          children: [
            const Text(
              'Choose your preferred language for the AI companion responses and application UI.',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ..._languages.map((lang) {
              final isSelected = _selected == lang['name'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                  onTap: () => setState(() => _selected = lang['name']!),
                  child: GlassCard(
                    hasGlow: isSelected,
                    glowColor: AppTheme.cyanAccent.withOpacity(0.08),
                    borderRadius: 22,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Text(lang['flag']!, style: const TextStyle(fontSize: 26)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang['name']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: isDark ? Colors.white : AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                lang['native']!,
                                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: AppTheme.cyanAccent, shape: BoxShape.circle),
                            child: const Icon(LucideIcons.check, size: 10, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.cyanAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save Language Preference',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
