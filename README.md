# 🚀 Flutter Starter App

A **production-ready, scalable, and maintainable Flutter starter template** for rapid development, best practices, and clean architecture. Ideal for teams and individuals who want to kickstart Flutter projects with confidence and consistency.

---

## 📚 Table of Contents

- [✨ Project Intent](#-project-intent)
- [🛠️ Technology Stack](#-technology-stack)
- [🚦 Getting Started](#-getting-started)
- [🔥 Firebase Setup](#-firebase-setup)
- [🧭 Routing](#-routing)
- [🖼️ Native Splash Screen](#-native-splash-screen)
- [⚡ Usage Examples](#-usage-examples)
- [🎨 Theme Management](#-theme-management)
- [💾 Storage](#-storage)
- [🌐 Networking](#-networking)
- [🗄️ Database (Drift)](#-database-drift)
- [🌍 Localization](#-localization)
- [🌐 Network Connectivity](#-network-connectivity)
- [🧪 Testing](#-testing)
- [📈 Analytics & Monitoring](#-analytics--monitoring)
- [🔗 Useful Commands](#-useful-commands)
- [📘 Additional Notes](#-additional-notes)
- [Rebranding](#rebranding)
- [📂 Folder Structure](#-folder-structure)

---

## ✨ Project Intent

- **Accelerate project setup** with a robust, ready-to-use foundation.
- **Promote best practices** via a clean, modular, feature-first architecture.
- **Ensure consistency** across projects and teams.
- **Integrate essential tooling** (localization, networking, storage, analytics, error reporting, theming, etc.) out of the box.
- **Support scalability** for both small and large codebases.

---

## 🛠️ Technology Stack

- **State Management**: Bloc/Cubit
- **Dependency Injection**: get_it
- **Networking**: Dio, Retrofit, Pretty Dio Logger
- **Local Storage**: SharedPreferences, Drift (SQLite)
- **Secure Storage**: flutter_secure_storage
- **Localization**: Flutter's built-in localization, ARB files, l10n tool
- **Theming**: Material 3, Google Fonts
- **Environment Variables**: flutter_dotenv
- **Firebase**: Analytics, Crashlytics, Messaging
- **Splash Screen**: flutter_native_splash
- **Testing**: Unit, widget, and integration tests

---

## 🚦 Getting Started

### Prerequisites

- Flutter SDK (3.32.0+)
- Dart (latest stable)

### Installation

```sh
git clone https://github.com/yourusername/starter_app.git
cd starter_app
flutter pub get
cp .env.example .env # Fill in your keys
dart run build_runner build --delete-conflicting-outputs
flutter pub run flutter_native_splash:create
flutter run
```

---

## 🔥 Firebase Setup

1. **Create a Firebase Project** in [Firebase Console](https://console.firebase.google.com/).
2. **Register your app** and download `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS).
3. **Place files** in:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
4. **Regenerate `firebase_options.dart`**:
   ```sh
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
5. **Run the app**.

See [FlutterFire documentation](https://firebase.flutter.dev/docs/overview/) for more.

---

## 🖼️ Native Splash Screen

Customize splash in `pubspec.yaml` under `flutter_native_splash`.  
After editing, run:

```sh
flutter pub run flutter_native_splash:create
```

See [flutter_native_splash documentation](https://pub.dev/packages/flutter_native_splash) for options.

---

## ⚡ Usage Examples

### Accessing Injected Services

```dart
final simpleStorage = serviceLocator<SimpleStorageService>();
final secureStorage = serviceLocator<SecureStorageService>();
final themeCubit = serviceLocator<ThemeCubit>();
final apiClient = serviceLocator<RestApiClient>();
```

### Simple Storage

```dart
await simpleStorage.setString('username', 'mahady');
final username = await simpleStorage.getString('username');
await simpleStorage.remove('username');
final exists = await simpleStorage.containsKey('username');
```

### Secure Storage

```dart
await secureStorage.setString('access_token', 'your_token');
final token = await secureStorage.getString('access_token');
await secureStorage.remove('access_token');
```

### Drift Database

```dart
final db = serviceLocator<AppDatabase>();
final item = ExampleItemsCompanion.insert(name: 'Item 1', value: 42);
await db.exampleItemsDao.insertItem(item);
final items = await db.exampleItemsDao.getAllItems();
```

### Theme Switching

```dart
serviceLocator<ThemeCubit>().switchTheme(ThemeMode.dark);
// Or in a widget:
context.read<ThemeCubit>().switchTheme(ThemeMode.light);
```

### Localization & Language Switching

```dart
context.read<LanguageCubit>().switchLanguage(Locale('fr'));
```

---

## 🎨 Theme Management

- Define theme data in `lib/app/theme/`.
- Use `ThemeCubit` for dynamic theme switching and persistence.

---

## 💾 Storage

- **Local**: `SimpleStorageService` (SharedPreferences)
- **Secure**: `SecureStorageService` (flutter_secure_storage)

---

## 🌐 Networking (Dio & Retrofit)

- **Dio** is used as the core HTTP client for all API requests.
- **Retrofit** provides a type-safe, annotation-based API interface for networking.
- All API endpoints are defined in `lib/core/network/rest_api_client.dart`.
- The base URL and other API environment variables are managed via `.env` and loaded using `flutter_dotenv`.

### Example Usage

```dart
import 'package:starter_app/app/di/injection.dart';
import 'package:starter_app/core/network/rest_api_client.dart';

final apiClient = serviceLocator<RestApiClient>();

// Example: Call an endpoint (define your endpoints in RestApiClient)
final response = await apiClient.getSomeData();
```

- Interceptors (e.g., logging, error handling) are configured in `lib/core/network/dio_module.dart`.
- Update or add endpoints in `RestApiClient` as needed for your backend.

---

## 🌐 Network Connectivity & Internet Status

This starter app includes **real-time network connectivity and internet status checking** using [`connectivity_plus`](https://pub.dev/packages/connectivity_plus) and [`internet_connection_checker_plus`](https://pub.dev/packages/internet_connection_checker_plus). This ensures your app can reliably detect both the type of network connection (WiFi, mobile, etc.) and whether the device actually has internet access.

### How It Works

- **Connectivity Type**:  
  The app listens for changes in network type (WiFi, mobile, ethernet, etc.) using `connectivity_plus`.
- **Internet Access**:  
  It also checks for real internet access (not just local network) using `internet_connection_checker_plus`.
- **State Management**:  
  The `InternetConnectionCubit` combines both sources and exposes a unified state (`InternetConnectionState`) with:
  - `connectionType`: The current network type (WiFi, mobile, etc.)
  - `status`: Whether the device is online or offline

### Usage Example

You can access the current network status anywhere in your app using the cubit:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_app/core/network/connection_checker/internet_connection_cubit.dart';
import 'package:starter_app/core/network/connection_checker/internet_connection_state.dart';

BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
  builder: (context, state) {
    return Text(
      'Status: ${state.status.name}, Type: ${state.connectionType.name}',
    );
  },
);
```

### Why Both?

- `connectivity_plus` tells you if you're connected to a network, but not if you have actual internet access.
- `internet_connection_checker_plus` verifies that the device can reach the internet (e.g., by pinging Google).

### Customization

- The logic is implemented in `lib/core/network/connection_checker/internet_connection_cubit.dart`.
- The state is defined in `lib/core/network/connection_checker/internet_connection_state.dart`.
- The cubit is registered for dependency injection and can be accessed via `serviceLocator<InternetConnectionCubit>()`.

---

## 🗄️ Database (Drift)

- Use Drift for relational/offline-first data.
- Define tables and DAOs in `lib/core/storage/drift/`.

---

## 🌍 Localization

- Place `.arb` files in `lib/app/language/arb/` (e.g., `app_fr.arb`).
- Supported locales in `AppLocalizations.supportedLocales`.
- Generate localization code with `flutter gen-l10n`.
- Language is persisted with `SimpleStorageService` and loaded on startup.
- Use `LanguageCubit` for runtime switching and persistence.

**Add a Language:**
1. Add `.arb` file in `lib/app/language/arb/`.
2. Run `flutter pub get`.
3. (iOS) Add the language in Xcode under "Localizations".

---

## 🧪 Testing

- Place unit, widget, and integration tests in `test/`.
- Use mocks and helpers for isolated testing.

---

## 📈 Analytics & Monitoring

- Integrated with Firebase Analytics and Crashlytics.
- Custom logging via `LoggerUtil`.

---

## 🔗 Useful Commands

```sh
# Code generation (models, DI, etc.)
dart run build_runner build --delete-conflicting-outputs
# Watch for changes
dart run build_runner watch --delete-conflicting-outputs
```

---

## 📘 Additional Notes

- **Language Persistence**: User's language choice is saved and restored automatically.
- **Generated Files**: Do not edit files in `lib/app/generated/` manually.
- **State Management**: Uses Cubit/Bloc for predictable, testable state.
- **Networking**: All API calls via `RestApiClient` using Dio and Retrofit.
- **Extensibility**: Add new features in `features/` following clean architecture.

---

## Rebranding

See [REBRANDING.md](./REBRANDING.md) for instructions on changing app name, package name, etc.

---

## 📂 Folder Structure

- `lib/core/shared/`: Shared widgets, extensions, and utilities.
- `lib/core/`: Core services, storage, networking, and shared code.
- `lib/app/`: App-level configuration, routing, localization, theme, and DI.
- `lib/features/`: Feature modules (business logic, UI, etc.).

---

> For architecture details and folder structure, see [architecture.md](architecture.md) and inline code comments.

---

## 🧭 Routing

- **GoRouter** is used for declarative, type-safe navigation and deep linking.
- All routes are defined in `lib/app/router/app_router.dart`.
- The root router is provided to `MaterialApp.router` in `app.dart`.
- Supports nested navigation, error handling, and route guards.

### Example

```dart
import 'package:starter_app/app/router/app_router.dart';

MaterialApp.router(
  routerConfig: AppRouter.router,
  // ...other params
);
```

- To add a new route, update the `routes` list in `AppRouter`.
- Use `context.go('/path')` or `context.push('/path')` for navigation.

---