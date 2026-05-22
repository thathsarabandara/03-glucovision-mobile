import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class HealthSetupScreen extends StatefulWidget {
  const HealthSetupScreen({super.key});

  @override
  State<HealthSetupScreen> createState() => _HealthSetupScreenState();
}

class _HealthSetupScreenState extends State<HealthSetupScreen> {
  int _currentStep = 0;
  String _diabetesType = 'Type 2';
  
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _medicationsController = TextEditingController();
  
  double _glucoseTargetMin = 70;
  double _glucoseTargetMax = 140;

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _allergiesController.dispose();
    _medicationsController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      context.push('/wearable-setup');
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Profile'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.textPrimary),
          onPressed: _prevStep,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: index < 2 ? 8.0 : 0),
                      height: 4,
                      decoration: BoxDecoration(
                        color: index <= _currentStep ? AppTheme.cyanAccent : AppTheme.surfaceHighlight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: _buildCurrentStep(),
              ),
            ),
            
            // Bottom Actions
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  child: Text(_currentStep < 2 ? 'Next' : 'Continue Setup'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0: return _buildBasicInfoStep();
      case 1: return _buildMedicalInfoStep();
      case 2: return _buildGlucoseTargetStep();
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 8),
        Text(
          'Help the AI understand your baseline metrics.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        
        GlassCard(
          child: Column(
            children: [
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Age', prefixIcon: Icon(LucideIcons.calendar)),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Weight (kg)', prefixIcon: Icon(LucideIcons.scale)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Height (cm)', prefixIcon: Icon(LucideIcons.ruler)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Medical Profile',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 32),
        
        Text('Diabetes Type', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: ['Type 1', 'Type 2', 'Gestational', 'Prediabetes', 'None'].map((type) {
            final isSelected = _diabetesType == type;
            return ChoiceChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) setState(() => _diabetesType = type);
              },
              selectedColor: AppTheme.emeraldHealth.withOpacity(0.2),
              backgroundColor: AppTheme.surface,
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.emeraldHealth : AppTheme.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(color: isSelected ? AppTheme.emeraldHealth : AppTheme.surfaceHighlight),
            );
          }).toList(),
        ),
        
        const SizedBox(height: 24),
        GlassCard(
          child: Column(
            children: [
              TextField(
                controller: _medicationsController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Current Medications (Optional)',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 24.0),
                    child: Icon(LucideIcons.pill),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _allergiesController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Food Allergies (Optional)',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 24.0),
                    child: Icon(LucideIcons.alertTriangle),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlucoseTargetStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glucose Targets',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 8),
        Text(
          'Set your Time-in-Range (TIR) goals.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 48),
        
        GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${_glucoseTargetMin.round()} mg/dL', style: const TextStyle(fontSize: 18, color: AppTheme.cyanAccent, fontWeight: FontWeight.bold)),
                  Text('${_glucoseTargetMax.round()} mg/dL', style: const TextStyle(fontSize: 18, color: AppTheme.warning, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              RangeSlider(
                values: RangeValues(_glucoseTargetMin, _glucoseTargetMax),
                min: 40,
                max: 300,
                divisions: 26,
                activeColor: AppTheme.emeraldHealth,
                inactiveColor: AppTheme.surfaceHighlight,
                labels: RangeLabels(
                  '${_glucoseTargetMin.round()}',
                  '${_glucoseTargetMax.round()}',
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _glucoseTargetMin = values.start;
                    _glucoseTargetMax = values.end;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Standard target is 70-140 mg/dL before meals.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
