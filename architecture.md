# 🏗️ Flutter Starter Project Architecture

A **feature-first, clean architecture** approach for scalable, maintainable, and testable Flutter apps.

---

## 📂 Folder Structure

```text
lib/
├── app/
│   ├── app.dart                   # App root widget and setup
│   ├── di/                        # Dependency injection setup (GetIt)
│   ├── router/                    # Routing (GoRouter)
│   ├── theme/                     # Theming (light/dark/system)
│   ├── language/                  # Localization ARB files, cubit, state
│   └── generated/                 # Auto-generated (localization, assets)
│
├── core/
│   ├── shared/                    # Shared widgets, extensions, and utilities (cross-feature)
│   ├── constants/                 # App-wide constants
│   ├── errors/                    # Error handling/interceptors
│   ├── network/                   # API clients, interceptors, REST client
│   ├── services/                  # Core services (Firebase, analytics, etc.)
│   ├── storage/
│   │   ├── drift/                 # Drift (SQLite) DB, tables, DAOs
│   │   ├── secure_storage.dart    # Secure storage abstraction
│   │   └── simple_storage.dart    # SharedPreferences abstraction
│   ├── utils/                     # Utilities (logger, snackbar, locale helper, etc.)
│
├── features/
│   ├── feature1/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── screens/
│   │       ├── widgets/
│   │       └── cubit/
│   └── ...
│
├── firebase_options.dart          # Firebase config (auto-generated)
├── main.dart                      # Entry point
│
test/
├── unit/
├── widget/
├── integration/
├── mocks/
└── helpers/
```

---

## 🧠 Architectural Philosophy

### 1. **Feature-First Organization**

- Each feature is a self-contained module with its own data, domain, and presentation layers.
- Promotes separation of concerns, modularity, and easy scaling.

### 2. **Clean Architecture Layers**

- **Data Layer**: Handles data sources (API, DB, cache), models, and repository implementations.
- **Domain Layer**: Contains business logic (entities, use cases, repository interfaces).
- **Presentation Layer**: UI, widgets, and state management (Cubit/Bloc).

### 3. **Core Layer**

- Shared utilities, services, and widgets used across features.
- Centralizes networking, storage, error handling, theming, and **locale/language persistence**.

### 4. **App Layer**

- Application-wide configuration: DI, routing, theming, localization, and generated files.

---

## 🛠️ Key Principles

- **Modularity**: Features are isolated and reusable.
- **Testability**: Each layer can be tested independently.
- **Extensibility**: Add new features or swap implementations with minimal impact.
- **Maintainability**: Clear boundaries and responsibilities.
- **Scalability**: Easily add new features or refactor existing ones without breaking the app.

---

## 🧩 Example: Adding a New Feature

Suppose you want to add a "Profile" feature:

```text
features/
└── profile/
    ├── data/
    │   ├── datasources/
    │   ├── models/
    │   └── repositories/
    ├── domain/
    │   ├── entities/
    │   ├── repositories/
    │   └── usecases/
    └── presentation/
        ├── screens/
        ├── widgets/
        └── cubit/
```

---

## 🔄 Data Flow Example

1. **UI** (presentation) triggers an action (e.g., fetch profile).
2. **Cubit/Bloc** calls a **use case** (domain).
3. **Use case** interacts with a **repository** (domain).
4. **Repository** fetches data from **API/DB** (data).
5. Data is returned up the chain and displayed in the UI.

---

## 🌍 Localization & Language Management

- **Translation files**: Place `.arb` files in `lib/app/language/arb/` (e.g., `app_fr.arb` for French).
- **Supported locales**: Managed in `AppLocalizations.supportedLocales`.
- **Code generation**: Run `flutter gen-l10n` to generate localization code.
- **Persistence**: User's language choice is saved with `SimpleStorageService` and loaded on startup.
- **Runtime switching**: Use `LanguageCubit` to switch and persist language.

### Adding a New Language

1. **Create an ARB translation file**  
   Add a new `.arb` file in `lib/app/language/arb/`, e.g. `app_fr.arb`:
   ```json
   {
     "helloWorld": "Bonjour le monde",
     "welcome": "Bienvenue"
   }
   ```

2. **Regenerate localization code**  
   Run:
   ```sh
   flutter pub get
   ```

3. **(iOS Only) Add the new language to your Xcode project**  
   - Open `ios/Runner.xcworkspace` in Xcode.
   - Select the `Runner` project, then the `Runner` target.
   - Go to the "Info" tab and expand "Localizations".
   - Click the "+" button and add your new language (e.g., French).
   - Xcode will prompt you to localize `InfoPlist.strings`—you can skip or add as needed.

4. **Use the new language in the app**  
   The language dropdown and cubit will automatically pick up the new locale.

---

## 🧪 Testing Strategy

- **Unit Tests**: For business logic (use cases, Cubits, repositories).
- **Widget Tests**: For UI components.
- **Integration Tests**: For end-to-end flows.
- **Mocks/Helpers**: Place in `test/mocks/` and `test/helpers/`.

---

## 🧰 Core Services & Utilities

- **Dependency Injection**: `GetIt` via `app/di/injection.dart`.
- **Networking**: `Dio` + `Retrofit` with interceptors and logging.
- **Local Storage**: `SimpleStorageService` (SharedPreferences), `SecureStorageService` (flutter_secure_storage).
- **Database**: Drift (SQLite) for relational/offline data.
- **Firebase**: Analytics, Crashlytics, Messaging.
- **Logging**: `LoggerUtil` for structured logs.
- **Snackbar/Toast**: `SnackbarUtil` for user feedback.

---

## 🖼️ Theming

- **Theme data**: Defined in `app/theme/`.
- **Dynamic switching**: Managed by `ThemeCubit`.
- **Persistence**: User's theme choice is saved and restored.

---

## 🗂️ Generated Files

- **Localization**: `lib/app/generated/app_localizations.dart` (auto-generated).
- **Assets**: `lib/app/generated/assets.gen.dart` (auto-generated).
- **Do not edit generated files manually.**

---

## 🧩 Extending the App

- Add new features by creating a new folder in `features/` and following the clean architecture pattern.
- Add new translations by creating `.arb` files and running `flutter gen-l10n`.
- Add new services/utilities in `core/` as needed.

---

## 📘 Additional Notes

- **State Management**: Uses Cubit/Bloc for predictable, testable state.
- **Networking**: All API calls are handled via `RestApiClient` using Dio and Retrofit.
- **Extensibility**: Designed for easy addition of features and services.
- **Generated Files**: Do not edit files in `lib/app/generated/` manually.

---

> For more details, see the [README.md](README.md) and inline code comments.