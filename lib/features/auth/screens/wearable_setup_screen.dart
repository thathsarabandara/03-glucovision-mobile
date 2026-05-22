import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class WearableSetupScreen extends StatelessWidget {
  const WearableSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wearable Integration'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Connect Devices',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 8),
              Text(
                'Sync your wearables for real-time AI health insights.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              
              _IntegrationCard(
                icon: LucideIcons.watch,
                title: 'Samsung Galaxy Fit 3',
                subtitle: 'Heart rate, sleep, and activity tracking.',
                color: AppTheme.cyanAccent,
                isConnected: false,
                onTap: () {
                  // TODO: Galaxy Fit 3 connection logic
                },
              ),
              const SizedBox(height: 16),
              
              _IntegrationCard(
                icon: LucideIcons.heartPulse,
                title: 'Health Connect',
                subtitle: 'Sync with Google Fit and other health apps.',
                color: AppTheme.emeraldHealth,
                isConnected: true,
                onTap: () {
                  // TODO: Health Connect logic
                },
              ),
              const SizedBox(height: 16),
              
              _IntegrationCard(
                icon: LucideIcons.activity,
                title: 'Continuous Glucose Monitor (CGM)',
                subtitle: 'Sync Dexcom, Libre, or manual sensors.',
                color: AppTheme.warning,
                isConnected: false,
                onTap: () {
                  // TODO: CGM Sync logic
                },
              ),
              
              const Spacer(),
              
              GlassCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(LucideIcons.shieldCheck, color: AppTheme.emeraldHealth, size: 24),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Your health data is encrypted and processed locally where possible to ensure maximum privacy.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/smart-glasses-pairing');
                  },
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.push('/smart-glasses-pairing');
                  },
                  child: const Text('Skip for now', style: TextStyle(color: AppTheme.textSecondary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntegrationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isConnected;
  final VoidCallback onTap;

  const _IntegrationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isConnected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isConnected ? AppTheme.emeraldHealth.withOpacity(0.1) : AppTheme.surfaceHighlight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isConnected ? AppTheme.emeraldHealth.withOpacity(0.5) : Colors.transparent,
                ),
              ),
              child: Text(
                isConnected ? 'Connected' : 'Connect',
                style: TextStyle(
                  color: isConnected ? AppTheme.emeraldHealth : AppTheme.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
