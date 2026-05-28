import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedFoodIdNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  
  void set(String? val) {
    state = val;
  }
}
final selectedFoodIdProvider = NotifierProvider<SelectedFoodIdNotifier, String?>(SelectedFoodIdNotifier.new);


class ScenarioTypeNotifier extends Notifier<String> {
  @override
  String build() => 'single';

  void set(String val) {
    state = val;
  }
}
final scenarioTypeProvider = NotifierProvider<ScenarioTypeNotifier, String>(ScenarioTypeNotifier.new);

// Simple metrics class
class DatabaseMetrics {
  final int totalFoods;
  final int collectedFoods;
  final int remainingFoods;
  final int totalImages;

  DatabaseMetrics({
    this.totalFoods = 0,
    this.collectedFoods = 0,
    this.remainingFoods = 0,
    this.totalImages = 0,
  });
}

// Dummy provider for metrics
final metricsProvider = FutureProvider<DatabaseMetrics>((ref) async {
  // In a real implementation, this would call the API
  await Future.delayed(const Duration(milliseconds: 500));
  return DatabaseMetrics(
    totalFoods: 120,
    collectedFoods: 45,
    remainingFoods: 75,
    totalImages: 342,
  );
});

// A provider to manage the session state and reset logic
class SessionManager {
  final Ref ref;
  SessionManager(this.ref);

  void resetSession() {
    // Reset any capture-specific state here if needed
  }
}

final sessionManagerProvider = Provider<SessionManager>((ref) {
  return SessionManager(ref);
});
