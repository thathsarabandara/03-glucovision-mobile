import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class IngredientDetectionScreen extends StatelessWidget {
  const IngredientDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredient Breakdown'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Image with bounded boxes
            Container(
              height: 250,
              width: double.infinity,
              margin: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 80,
                    left: 40,
                    child: _buildBoundingBox('Avocado', AppTheme.emeraldHealth, 60, 50),
                  ),
                  Positioned(
                    top: 130,
                    left: 120,
                    child: _buildBoundingBox('Chicken', AppTheme.warning, 90, 60),
                  ),
                  Positioned(
                    top: 50,
                    right: 60,
                    child: _buildBoundingBox('Greens', AppTheme.cyanAccent, 70, 70),
                  ),
                ],
              ),
            ),
            
            // List of ingredients
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Detected Items',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
                        ),
                        TextButton(
                          onPressed: () => context.push('/portion-estimation'),
                          child: const Text('Estimate Portions', style: TextStyle(color: AppTheme.cyanAccent)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildIngredientDetailItem(
                            'Grilled Chicken Breast',
                            '98.5%',
                            'Protein source. Low glycemic impact.',
                            AppTheme.warning,
                          ),
                          const SizedBox(height: 12),
                          _buildIngredientDetailItem(
                            'Fresh Avocado',
                            '95.2%',
                            'Healthy fats. Slows down carb absorption.',
                            AppTheme.emeraldHealth,
                          ),
                          const SizedBox(height: 12),
                          _buildIngredientDetailItem(
                            'Mixed Greens (Spinach, Kale)',
                            '99.1%',
                            'High fiber. Excellent for glucose stability.',
                            AppTheme.cyanAccent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoundingBox(String label, Color color, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          color: color.withOpacity(0.8),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientDetailItem(String name, String confidence, String aiNote, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(confidence, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  aiNote,
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
