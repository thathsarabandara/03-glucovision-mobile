import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class SmartGlassesPairingScreen extends StatefulWidget {
  const SmartGlassesPairingScreen({super.key});

  @override
  State<SmartGlassesPairingScreen> createState() => _SmartGlassesPairingScreenState();
}

class _SmartGlassesPairingScreenState extends State<SmartGlassesPairingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isScanning = true;
  bool _deviceFound = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Mock scanning delay
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _deviceFound = true;
        });
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Glasses Pairing'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'AR Overlay Setup',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 28),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Power on your smart glasses and ensure Bluetooth is enabled.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              
              // Radar Animation
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isScanning)
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Container(
                            width: 200 * _controller.value,
                            height: 200 * _controller.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.purpleAI.withOpacity(1 - _controller.value),
                                width: 2,
                              ),
                            ),
                          );
                        },
                      ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.surfaceHighlight,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.purpleAI.withOpacity(0.3),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        LucideIcons.glasses,
                        size: 48,
                        color: _isScanning ? AppTheme.textPrimary : AppTheme.emeraldHealth,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              
              if (_isScanning) ...[
                const CircularProgressIndicator(color: AppTheme.purpleAI),
                const SizedBox(height: 16),
                const Text('Scanning for devices...'),
              ] else if (_deviceFound) ...[
                GlassCard(
                  padding: const EdgeInsets.all(16),
                  hasGlow: true,
                  glowColor: AppTheme.emeraldHealth,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.emeraldHealth.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(LucideIcons.bluetooth, color: AppTheme.emeraldHealth),
                    ),
                    title: const Text('GlucoVision AR Frame', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Ready to pair'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to dashboard after successful pairing
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text('Pair'),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.wifi, color: AppTheme.cyanAccent),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Wi-Fi streaming setup will be completed after pairing to enable live food recognition.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const Spacer(),
              
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Skip and go to main dashboard
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
