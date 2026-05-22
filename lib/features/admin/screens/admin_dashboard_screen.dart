import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            // Admin badge
            GlassCard(
              hasGlow: true,
              glowColor: AppTheme.purpleAI,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppTheme.purpleAI, AppTheme.cyanAccent], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(LucideIcons.settings2, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Administrator Access', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Research Mode Active', style: TextStyle(color: AppTheme.purpleAI.withOpacity(0.8), fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Platform Stats
            Text('Platform Overview', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard(context, 'Total Users', '3,241', LucideIcons.users, AppTheme.cyanAccent)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, 'Active Today', '847', LucideIcons.activity, AppTheme.emeraldHealth)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard(context, 'Food Items', '14,820', LucideIcons.utensils, AppTheme.warning)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, 'AI Queries', '52.4k', LucideIcons.messageCircle, AppTheme.purpleAI)),
              ],
            ),
            const SizedBox(height: 32),

            // Admin Actions
            Text('Admin Actions', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20)),
            const SizedBox(height: 16),
            _buildAdminAction(context, LucideIcons.database, 'Dataset Management', 'Review, approve or reject food submissions', '/dataset-validation', AppTheme.emeraldHealth),
            const SizedBox(height: 12),
            _buildAdminAction(context, LucideIcons.users, 'User Management', 'View, suspend, or manage user accounts', '/admin-user-management', AppTheme.cyanAccent),
            const SizedBox(height: 12),
            _buildAdminAction(context, LucideIcons.barChart2, 'AI Performance Logs', 'Monitor model accuracy and error rates', '/admin-ai-logs', AppTheme.purpleAI),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildAdminAction(BuildContext context, IconData icon, String title, String subtitle, String route, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () => context.push(route),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, color: AppTheme.textSecondary, size: 18),
          ],
        ),
      ),
    );
  }
}
