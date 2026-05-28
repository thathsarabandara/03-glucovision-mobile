import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/otp_verify_screen.dart';
import '../../features/auth/screens/reset_password_screen.dart';
import '../../features/auth/screens/health_setup_screen.dart';
import '../../features/auth/screens/wearable_setup_screen.dart';
import '../../features/auth/screens/smart_glasses_pairing_screen.dart';
import '../../features/dashboard/screens/home_dashboard_screen.dart';
import '../../features/dashboard/screens/main_navigation_shell.dart';
import '../../features/dashboard/screens/ai_suggestions_feed_screen.dart';
import '../../features/dashboard/screens/daily_health_summary_screen.dart';
import '../../features/ai_assistant/screens/ai_chat_assistant_screen.dart';
import '../../features/ai_assistant/screens/voice_assistant_screen.dart';
import '../../features/ai_assistant/screens/ai_history_screen.dart';
import '../../features/ai_assistant/screens/multimodal_assistant_screen.dart';
import '../../features/food_camera/screens/live_camera_screen.dart';
import '../../features/food_camera/screens/meal_capture_preview_screen.dart';
import '../../features/food_camera/screens/food_recognition_result_screen.dart';
import '../../features/food_camera/screens/ingredient_detection_screen.dart';
import '../../features/food_camera/screens/portion_estimation_screen.dart';
import '../../features/food_camera/screens/meal_nutrition_analysis_screen.dart';
import '../../features/food_camera/screens/ai_meal_recommendation_screen.dart';
import '../../features/food_camera/screens/food_history_screen.dart';
import '../../features/cooking/screens/cooking_assistant_home_screen.dart';
import '../../features/cooking/screens/live_cooking_camera_screen.dart';
import '../../features/cooking/screens/cooking_analysis_screen.dart';
import '../../features/cooking/screens/recipe_guidance_screen.dart';
import '../../features/glucose/screens/glucose_dashboard_screen.dart';
import '../../features/glucose/screens/manual_glucose_entry_screen.dart';
import '../../features/glucose/screens/ocr_glucose_scanner_screen.dart';
import '../../features/glucose/screens/glucose_prediction_screen.dart';
import '../../features/glucose/screens/risk_alert_screen.dart';
import '../../features/glucose/screens/glucose_history_screen.dart';
import '../../features/wearable/screens/wearable_dashboard_screen.dart';
import '../../features/wearable/screens/activity_analytics_screen.dart';
import '../../features/wearable/screens/sleep_analytics_screen.dart';
import '../../features/wearable/screens/heart_rate_trends_screen.dart';
import '../../features/smart_glasses/screens/smart_glasses_dashboard_screen.dart';
import '../../features/smart_glasses/screens/smart_glasses_live_view_screen.dart';
import '../../features/smart_glasses/screens/smart_glasses_overlay_preview_screen.dart';
import '../../features/smart_glasses/screens/smart_glasses_settings_screen.dart';
import '../../features/digital_twin/screens/analytics_dashboard_screen.dart';
import '../../features/digital_twin/screens/weekly_insights_screen.dart';
import '../../features/digital_twin/screens/monthly_report_screen.dart';
import '../../features/digital_twin/screens/digital_twin_screen.dart';
import '../../features/digital_twin/screens/what_if_simulation_screen.dart';
import '../../features/community/screens/community_feed_screen.dart';
import '../../features/community/screens/food_contribution_screen.dart';
import '../../features/community/screens/dataset_validation_screen.dart';
import '../../features/community/screens/contributor_leaderboard_screen.dart';
import '../../features/notifications/screens/notifications_center_screen.dart';
import '../../features/settings/screens/user_profile_screen.dart';
import '../../features/settings/screens/privacy_security_screen.dart';
import '../../features/settings/screens/language_settings_screen.dart';
import '../../features/admin/screens/admin_dashboard_screen.dart';
import '../../features/data_collect/screens/dashboard_screen.dart';
import '../../features/data_collect/screens/session_setup_screen.dart';
import '../../features/data_collect/screens/guided_capture_screen.dart';
import '../../features/data_collect/screens/record_list_screen.dart';
import '../../features/data_collect/screens/food_list_screen.dart';
import '../../features/data_collect/screens/add_food_screen.dart';
import '../../features/data_collect/screens/data_collect_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // --- App Entry Routes ---
    GoRoute(path: '/',builder: (context, state) => const SplashScreen(),),
    GoRoute(path: '/welcome',builder: (context, state) => const WelcomeScreen(),),
    // --- Authentication Routes ---
    GoRoute(path: '/login',builder: (context, state) => const LoginScreen(),),
    GoRoute(path: '/register',builder: (context, state) => const RegisterScreen(),),
    GoRoute(path: '/forgot-password',builder: (context, state) => const ForgotPasswordScreen(),),
    GoRoute(path: '/otp-verify',builder: (context, state) => const OtpVerifyScreen(),),
    GoRoute(path: '/reset-password',builder: (context, state) => const ResetPasswordScreen(),),
    // --- Onboarding Routes ---
    GoRoute(path: '/health-setup',builder: (context, state) => const HealthSetupScreen(),),
    GoRoute(path: '/wearable-setup',builder: (context, state) => const WearableSetupScreen(),),
    GoRoute(path: '/smart-glasses-pairing',builder: (context, state) => const SmartGlassesPairingScreen(),),
    // --- Main App Shell ---
    GoRoute(path: '/dashboard',builder: (context, state) => const MainNavigationShell(),),
    // --- Module 1: AI Assistant ---
    GoRoute(path: '/suggestions-feed',builder: (context, state) => const AiSuggestionsFeedScreen(),),
    GoRoute(path: '/daily-summary',builder: (context, state) => const DailyHealthSummaryScreen(),),
    GoRoute(path: '/ai-assistant',builder: (context, state) => const AiChatAssistantScreen(),),
    GoRoute(path: '/voice-assistant',builder: (context, state) => const VoiceAssistantScreen(),),
    GoRoute(path: '/ai-history',builder: (context, state) => const AiHistoryScreen(),),
    GoRoute(path: '/multimodal-assistant',builder: (context, state) => const MultimodalAssistantScreen(),),
    // --- Module 2: Food & Nutrition ---
    GoRoute(path: '/food-camera',builder: (context, state) => const LiveCameraScreen(),),
    GoRoute(path: '/meal-capture-preview',builder: (context, state) => const MealCapturePreviewScreen(),),
    GoRoute(path: '/food-recognition-result',builder: (context, state) => const FoodRecognitionResultScreen(),),
    GoRoute(path: '/ingredient-detection',builder: (context, state) => const IngredientDetectionScreen(),),
    GoRoute(path: '/portion-estimation',builder: (context, state) => const PortionEstimationScreen(),),
    GoRoute(path: '/meal-nutrition-analysis',builder: (context, state) => const MealNutritionAnalysisScreen(),),
    GoRoute(path: '/ai-meal-recommendation',builder: (context, state) => const AiMealRecommendationScreen(),),
    GoRoute(path: '/food-history',builder: (context, state) => const FoodHistoryScreen(),),
    // --- Module 3: Cooking ---
    GoRoute(path: '/cooking-assistant',builder: (context, state) => const CookingAssistantHomeScreen(),),
    GoRoute(path: '/live-cooking-camera',builder: (context, state) => const LiveCookingCameraScreen(),),
    GoRoute(path: '/cooking-analysis',builder: (context, state) => const CookingAnalysisScreen(),),
    GoRoute(path: '/recipe-guidance',builder: (context, state) => const RecipeGuidanceScreen(),),
    // --- Module 4: Glucose ---
    GoRoute(path: '/glucose-dashboard', builder: (context, state) => const GlucoseDashboardScreen()),
    GoRoute(path: '/glucose-manual-entry', builder: (context, state) => const ManualGlucoseEntryScreen()),
    GoRoute(path: '/glucose-ocr-scanner', builder: (context, state) => const OcrGlucoseScannerScreen()),
    GoRoute(path: '/glucose-prediction', builder: (context, state) => const GlucosePredictionScreen()),
    GoRoute(path: '/risk-alert', builder: (context, state) => const RiskAlertScreen()),
    GoRoute(path: '/glucose-history', builder: (context, state) => const GlucoseHistoryScreen()),
    // --- Module 5: Wearable ---
    GoRoute(path: '/wearable-dashboard', builder: (context, state) => const WearableDashboardScreen()),
    GoRoute(path: '/activity-analytics', builder: (context, state) => const ActivityAnalyticsScreen()),
    GoRoute(path: '/sleep-analytics', builder: (context, state) => const SleepAnalyticsScreen()),
    GoRoute(path: '/heart-rate-trends', builder: (context, state) => const HeartRateTrendsScreen()),
    // --- Module 6: Smart Glasses ---
    GoRoute(path: '/smart-glasses-dashboard', builder: (context, state) => const SmartGlassesDashboardScreen()),
    GoRoute(path: '/smart-glasses-live-view', builder: (context, state) => const SmartGlassesLiveViewScreen()),
    GoRoute(path: '/smart-glasses-overlay-preview', builder: (context, state) => const SmartGlassesOverlayPreviewScreen()),
    GoRoute(path: '/smart-glasses-settings', builder: (context, state) => const SmartGlassesSettingsScreen()),
    // --- Module 7: Analytics & Digital Twin ---
    GoRoute(path: '/analytics-dashboard', builder: (context, state) => const AnalyticsDashboardScreen()),
    GoRoute(path: '/weekly-insights', builder: (context, state) => const WeeklyInsightsScreen()),
    GoRoute(path: '/monthly-report', builder: (context, state) => const MonthlyReportScreen()),
    GoRoute(path: '/digital-twin', builder: (context, state) => const DigitalTwinScreen()),
    GoRoute(path: '/what-if-simulation', builder: (context, state) => const WhatIfSimulationScreen()),
    // --- Module 8: Community Dataset ---
    GoRoute(path: '/community-feed', builder: (context, state) => const CommunityFeedScreen()),
    GoRoute(path: '/food-contribution', builder: (context, state) => const FoodContributionScreen()),
    GoRoute(path: '/dataset-validation', builder: (context, state) => const DatasetValidationScreen()),
    GoRoute(path: '/contributor-leaderboard', builder: (context, state) => const ContributorLeaderboardScreen()),
    // --- Module 9: Notifications ---
    GoRoute(path: '/notifications', builder: (context, state) => const NotificationsCenterScreen()),
    // --- Module 10: Profile & Settings ---
    GoRoute(path: '/profile', builder: (context, state) => const UserProfileScreen()),
    GoRoute(path: '/privacy-security', builder: (context, state) => const PrivacySecurityScreen()),
    GoRoute(path: '/language-settings', builder: (context, state) => const LanguageSettingsScreen()),
    // --- Module 11: Admin ---
    GoRoute(path: '/admin-dashboard', builder: (context, state) => const AdminDashboardScreen()),
    // --- Data Collect ---
    StatefulShellRoute.indexedStack(builder: (context, state, navigationShell) {return DataCollectShell(navigationShell: navigationShell);},
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: '/data-collect',builder: (context, state) => const DashboardScreen(),),],),
        StatefulShellBranch(routes: [GoRoute(path: '/data-collect/food-list',builder: (context, state) => const FoodListScreen(),),],),
        StatefulShellBranch(routes: [GoRoute(path: '/data-collect/records',builder: (context, state) => const RecordListScreen(),),],),
      ],
    ),
    GoRoute(path: '/data-collect/session-setup', builder: (context, state) => const SessionSetupScreen()),
    GoRoute(path: '/data-collect/add-food', builder: (context, state) => const AddFoodScreen()),
    GoRoute(path: '/data-collect/capture', builder: (context, state) {final extra = state.extra as Map<String, dynamic>? ?? {}; return GuidedCaptureScreen(sessionParams: extra);}),
    GoRoute(path: '/data-collect/records', builder: (context, state) => const RecordListScreen()),
    GoRoute(path: '/data-collect/food-list', builder: (context, state) => const FoodListScreen()),
  ],
);
