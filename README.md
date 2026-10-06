# Messenger

A mobile learning repo: the same messaging app (a Messenger clone) is built on several platforms so I can compare the approaches, together with a shared backend.

All three mobile apps use the **MVVM** pattern: Flutter widgets, Jetpack Compose on Android, and SwiftUI on iOS.

> This is a learning project. Most parts are still scaffolds, and there is no complete chat feature yet.

## Repo structure

| Folder                                    | Platform                | Main technologies                                                     | Status                                 |
| ----------------------------------------- | ----------------------- | --------------------------------------------------------------------- | -------------------------------------- |
| [`flutter-messenger/`](flutter-messenger) | Flutter (Android + iOS) | Dart, `go_router`, `flutter_bloc` (Cubit), `dio`, `json_serializable` | Working on the login flow              |
| [`android-messenger/`](android-messenger) | Native Android          | Kotlin, Jetpack Compose, Navigation 3, Material 3                     | App skeleton + main screen             |
| [`ios-messenger/`](ios-messenger)         | Native iOS              | Swift, SwiftUI                                                        | New project (a "Hello, world!" screen) |
| [`backend/`](backend)                     | Server                  | NestJS 12, TypeScript, pnpm, Vitest, oxlint                           | New project (sample `GET /` route)     |
| [`documentation/`](documentation)         | Docs                    | Markdown                                                              | Architecture, setup guide, notes       |

## Requirements

- **Flutter**: a Flutter SDK that ships with Dart `^3.13.5`.
- **Android**: Android Studio and a JDK to run Gradle (Android Gradle Plugin 9.0.1, Kotlin 2.3.20).
- **iOS**: macOS and Xcode (the deployment target is currently iOS 27.0).
- **Backend**: Node.js and [pnpm](https://pnpm.io/).

## Getting started

### Flutter

```bash
cd flutter-messenger
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generates the *.g.dart files
flutter run
```

### Android

Open the `android-messenger/` folder in Android Studio and run it, or use the command line:

```bash
cd android-messenger
./gradlew assembleDebug
```

App info: `applicationId` is `vn.messenger.app`, `minSdk` is 24, and `targetSdk` is 36.

### iOS

Open `ios-messenger/ios-messenger.xcodeproj` in Xcode, choose a simulator, and press Run.

### Backend

```bash
cd backend
pnpm install
pnpm run start:dev
```

By default, the server listens on port `3000`. You can change it with the `PORT` environment variable.

Other commands:

```bash
pnpm run lint       # oxlint
pnpm run test       # unit tests (Vitest)
pnpm run test:e2e   # end-to-end tests
```

## `flutter-messenger` architecture

The code in `lib/` is organized by feature:

```
lib/
├── main.dart, app.dart
├── features/
│   ├── auth/        # cubits, models (DTOs), repositories, services, view_models, views
│   ├── home/
│   └── splash/
├── services/        # Dio setup and the shared base response
└── shared/common/   # router, colors, config, enums, exceptions
```

The login flow goes in this direction: `View` → `Cubit` → `Repository` → `Service` → `Dio`.

With MVVM, the `Cubit` plays the ViewModel role today. The folder `view_models/` already exists, but `LoginViewModel` is empty. The plan is to keep only one of them. See [architecture.md](documentation/architecture.md#pattern-mvvm-on-all-three-platforms).

## Documentation

- [Architecture overview](documentation/architecture.md): how each project is built, and the known gaps.
- [Setup guide](documentation/setup-guide.md): tools, run and test commands, and troubleshooting.
- [Cross-platform notes](documentation/cross-platform-notes.md): the same idea on Flutter, Android and iOS.

## Status and TODO

- [ ] The backend has no login API yet. The Flutter app calls `POST /auth/login`, but the backend only has `GET /`.
- [ ] The API addresses do not match. Flutter points to `http://localhost:4299/api`, but the backend listens on port `3000` by default and has no `/api` prefix.
- [ ] Decide how the Flutter ViewModel works (keep `Cubit` or use `ChangeNotifier`), then remove the unused one.
- [ ] Finish the login flow in Flutter (splash, home, token storage).
- [ ] Build the login screen with a ViewModel on Android (Compose) and iOS (SwiftUI).
- [ ] Build the chat feature on every platform.
- [x] Write the first documentation in `documentation/`.
