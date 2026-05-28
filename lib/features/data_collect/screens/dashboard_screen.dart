import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/data_collect_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Map<String, String>> _suggestions = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) async {
    if (query.length < 2) {
      setState(() {
        _suggestions = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);
    
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (mounted) {
      setState(() {
        _isSearching = false;
        // Dummy search logic
        _suggestions = [
          {'id': 'food_1', 'name': '$query Rice'},
          {'id': 'food_2', 'name': 'Chicken $query'},
        ];
      });
    }
  }

  void _handleQuickSelect(String foodId) {
    ref.read(selectedFoodIdProvider.notifier).set(foodId);
    ref.read(sessionManagerProvider).resetSession();
    // Route directly to capture, skipping setup
    context.push('/data-collect/capture', extra: {
      'plate_type': 'Standard White Plate', // defaults
      'background_type': 'Kitchen Counter',
    });
  }

  @override
  Widget build(BuildContext context) {
    final metricsAsync = ref.watch(metricsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);
    final textColor = isDark ? Colors.white : AppTheme.textPrimary;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text('Dataset Collector', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        children: [
          // Metrics Card
          GlassCard(
            padding: const EdgeInsets.all(20.0),
            borderRadius: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(LucideIcons.barChart2, color: AppTheme.emeraldHealth, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Database Metrics', 
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: textColor
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                metricsAsync.when(
                  data: (metrics) => GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.6,
                    children: [
                      _buildMetricBox(context, 'TOTAL FOODS', metrics.totalFoods.toString(), AppTheme.cyanAccent),
                      _buildMetricBox(context, 'COLLECTED', metrics.collectedFoods.toString(), AppTheme.emeraldHealth),
                      _buildMetricBox(context, 'REMAINING', metrics.remainingFoods.toString(), AppTheme.warning),
                      _buildMetricBox(context, 'IMAGES', metrics.totalImages.toString(), AppTheme.purpleAI),
                    ],
                  ),
                  loading: () => const Center(child: CircularProgressIndicator(color: AppTheme.cyanAccent)),
                  error: (err, stack) => Text('Error: $err', style: const TextStyle(color: AppTheme.error)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Quick Start Capture
          GlassCard(
            padding: const EdgeInsets.all(20.0),
            borderRadius: 24,
            hasGlow: true,
            glowColor: AppTheme.cyanAccent.withOpacity(0.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(LucideIcons.zap, color: AppTheme.cyanAccent, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'QUICK START CAPTURE',
                      style: TextStyle(
                        color: textColor.withOpacity(0.9),
                        letterSpacing: 1.2,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  style: TextStyle(color: textColor, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Search food to start...',
                    hintStyle: TextStyle(color: AppTheme.textSecondary),
                    prefixIcon: const Icon(LucideIcons.search, color: AppTheme.textSecondary, size: 18),
                    filled: true,
                    fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppTheme.cyanAccent, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    suffixIcon: _isSearching
                        ? const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.cyanAccent),
                            ),
                          )
                        : null,
                  ),
                ),
                if (_suggestions.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text('TOP SUGGESTIONS', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  ..._suggestions.map((food) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Material(
                          color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02),
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => _handleQuickSelect(food['id']!),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(food['name']!, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14)),
                                      const SizedBox(height: 4),
                                      Text(food['id']!, style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontFamily: 'monospace')),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(LucideIcons.arrowRight, color: AppTheme.cyanAccent, size: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ]
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          ElevatedButton.icon(
            onPressed: () => context.push('/data-collect/session-setup'),
            icon: const Icon(LucideIcons.settings, size: 18, color: Colors.white),
            label: const Text('Configure Custom Session', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              backgroundColor: AppTheme.purpleAI,
              elevation: 4,
              shadowColor: AppTheme.purpleAI.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/data-collect/session-setup'),
        icon: const Icon(LucideIcons.plus, color: Colors.white),
        label: const Text('New Session', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.emeraldHealth,
      ),
    );
  }

  Widget _buildMetricBox(BuildContext context, String title, String value, Color accentColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: accentColor)),
        ],
      ),
    );
  }
}
