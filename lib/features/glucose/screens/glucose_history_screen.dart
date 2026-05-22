import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class GlucoseHistoryScreen extends StatelessWidget {
  const GlucoseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Glucose History',
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
            // 1. Weekly Summary Card
            GlassCard(
              padding: const EdgeInsets.all(20),
              borderRadius: 28,
              hasGlow: true,
              glowColor: AppTheme.cyanAccent.withOpacity(0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Snapshot',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isDark ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Snapshot stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMiniStat(context, 'Avg', '114', AppTheme.textPrimary),
                      _buildMiniStat(context, 'TIR', '87%', AppTheme.emeraldHealth),
                      _buildMiniStat(context, 'Highs', '3', AppTheme.warning),
                      _buildMiniStat(context, 'Lows', '1', AppTheme.cyanAccent),
                    ],
                  ),
                  const SizedBox(height: 28),
                  
                  // Custom Mini Capsule Bar Chart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBar('M', 88, AppTheme.emeraldHealth),
                      _buildBar('T', 70, AppTheme.emeraldHealth),
                      _buildBar('W', 95, AppTheme.emeraldHealth),
                      _buildBar('T', 50, AppTheme.warning),
                      _buildBar('F', 100, AppTheme.emeraldHealth),
                      _buildBar('S', 40, AppTheme.error),
                      _buildBar('S', 75, AppTheme.emeraldHealth),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Day Labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Mon', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('Tue', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('Wed', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('Thu', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('Fri', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('Sat', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                      Text('Sun', style: TextStyle(fontSize: 9, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 2. Log Entries Title
            Text(
              'Log Entries',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // 3. Entries list
            _buildEntryRow(context, 'Today, 8:15 PM', '158 mg/dL', 'Before Meal', AppTheme.warning),
            const SizedBox(height: 12),
            _buildEntryRow(context, 'Today, 12:30 PM', '118 mg/dL', 'After Meal', AppTheme.emeraldHealth),
            const SizedBox(height: 12),
            _buildEntryRow(context, 'Today, 7:00 AM', '95 mg/dL', 'Fasting', AppTheme.emeraldHealth),
            const SizedBox(height: 12),
            _buildEntryRow(context, 'Yesterday, 9:00 PM', '175 mg/dL', 'After Meal', AppTheme.warning),
            const SizedBox(height: 12),
            _buildEntryRow(context, 'Yesterday, 6:30 AM', '88 mg/dL', 'Fasting', AppTheme.emeraldHealth),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(BuildContext context, String label, String value, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: color == AppTheme.textPrimary ? (isDark ? Colors.white : AppTheme.textPrimary) : color,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBar(String label, double percent, Color color) {
    return Container(
      width: 20,
      height: 70 * percent / 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildEntryRow(BuildContext context, String timestamp, String value, String context_, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      borderRadius: 20,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timestamp,
                  style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  context_,
                  style: TextStyle(fontSize: 13, color: isDark ? Colors.white : AppTheme.textPrimary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: color),
          ),
        ],
      ),
    );
  }
}
