<div align="center">

# 📱 GlucoVision Mobile

**The primary patient-facing Flutter application for the GlucoVision diabetes management platform.**  
*Food logging · Glucose tracking · AI recommendations · BLE wearable sync · Digital twin*

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)](#)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart)](#)
[![Android](https://img.shields.io/badge/Android-Primary-3DDC84?style=for-the-badge&logo=android)](#)
[![iOS](https://img.shields.io/badge/iOS-Supported-000000?style=for-the-badge&logo=apple)](#)
[![Status](https://img.shields.io/badge/Status-In%20Development-f59e0b?style=for-the-badge)](#)

</div>

---

## 📌 Purpose

GlucoVision Mobile is the **patient's primary interface** to the entire GlucoVision AI platform. Diabetic patients use this app to log food via camera, track glucose levels, receive personalised Sri Lankan meal plans, talk to the AI assistant, and view their digital twin health projections.

> Every backend AI service — food recognition, glucose prediction, dietary recommendations — surfaces its output through this app.

---

## 📁 Project Structure

```
03-glucovision-mobile/
├── lib/
│   └── main.dart              # Application entry point (expanding)
├── android/                   # Android platform config
├── ios/                       # iOS platform config
├── pubspec.yaml               # Dependencies
├── analysis_options.yaml      # Lint rules
└── test/                      # Widget and unit tests
```

> **Note:** This repo is in active early development. Module structure is being expanded as services come online.

---

## ✨ Planned Features (by phase)

### Phase 1 — Auth & Dashboard UI *(Current)*
- [ ] Login / Registration (JWT via `05-auth-service`)
- [ ] User profile setup (diabetes type, preferences)
- [ ] Basic home dashboard

### Phase 2 — Food Logging
- [ ] Camera-based food capture → `09-food-recognition`
- [ ] Portion size estimation via AR overlay → `10-portion-estimation`
- [ ] Food log history view

### Phase 3 — Health Monitoring
- [ ] Manual glucose entry
- [ ] CGM sync display (Dexcom / Libre via `14-cgm-integration`)
- [ ] BLE smart band connection → `18-wearable-sync`
- [ ] Glucose forecast chart → `12-glucose-prediction`
- [ ] Real-time risk alerts via WebSocket → `13-risk-alert-engine`

### Phase 4 — Intelligence
- [ ] Personalised meal plan feed → `15-recommendation-engine`
- [ ] Voice + vision AI assistant → `16-assistant-service`
- [ ] Cooking guidance (AR step-by-step) → `11-cooking-ai`

### Phase 5 — Research
- [ ] Digital twin health projection view → `19-digital-twin`
- [ ] Federated learning opt-in → `20-federated-learning`

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `^3.11.5` — [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK `^3.x`
- Android Studio / Xcode
- A running instance of the GlucoVision backend (see [`08-api-gateway`](../01-glucovision-platform-architecture/repo-docs/08-api-gateway.md))

### Setup

```bash
# Clone the repo
git clone <repo-url>
cd 03-glucovision-mobile

# Install dependencies
flutter pub get

# Run on connected device / emulator
flutter run

# Run tests
flutter test
```

### Environment Configuration

Create `lib/config/env.dart`:

```dart
class Env {
  static const String apiBaseUrl = 'http://localhost:8080';  // API gateway
  static const String wsBaseUrl  = 'ws://localhost:8080';   // WebSocket
}
```

---

## 🏗️ Planned Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | Riverpod / Bloc *(to be decided)* |
| Navigation | GoRouter |
| HTTP Client | Dio |
| WebSocket | `web_socket_channel` |
| BLE | `flutter_blue_plus` |
| AR | ARCore (Android) / ARKit (iOS) |
| Camera | `camera` plugin |
| Push Notifications | `firebase_messaging` |
| Local Storage | Hive |
| Charts | `fl_chart` |
| Auth | `flutter_secure_storage` (JWT) |

---

## 🔗 Backend Dependencies

| Service | What The App Calls |
|---|---|
| `05` auth-service | Login, register, refresh token |
| `06` user-service | Profile, preferences, health metadata |
| `08` api-gateway | Single entry point for all API calls |
| `09` food-recognition | Food photo → food name + confidence |
| `10` portion-estimation | Food photo → portion weight (g) |
| `12` glucose-prediction | Glucose forecast curve |
| `13` risk-alert-engine | Real-time WebSocket glucose alerts |
| `14` cgm-integration | CGM sync status |
| `15` recommendation-engine | Daily meal plan + activity plan |
| `16` assistant-service | Voice + vision AI chat (WebSocket) |
| `18` wearable-sync | BLE band activity data |
| `19` digital-twin | Health projection charts |

---

## 🔐 Security Notes

- JWT stored in `flutter_secure_storage` (never SharedPreferences)
- Biometric authentication via `local_auth` plugin
- Certificate pinning on medical data endpoints
- Camera and microphone permissions with runtime checks
- Glucose values and nutrition data never logged to console

---

## 🧪 Testing

```bash
# Unit tests (state logic, data parsing)
flutter test

# Integration tests (end-to-end flows)
flutter test integration_test/

# Widget tests
flutter test test/widget_test.dart
```

---

## 📦 Building

```bash
# Debug APK
flutter build apk --debug

# Release APK (requires signing config)
flutter build apk --release

# iOS (requires Mac + Xcode)
flutter build ios --release
```

---

<div align="center">

*Part of the [GlucoVision Platform](../01-glucovision-platform-architecture) — 21-Repo AI Diabetes Management System*

</div>
