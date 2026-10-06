# Setup guide

This guide shows how to install the tools, run each project, and fix common problems. For a short version, see the [README](../README.md).

## What you need

| Project | Tools |
| --- | --- |
| `flutter-messenger` | A Flutter SDK that ships with Dart `^3.13.5`. An Android emulator or an iOS simulator. |
| `android-messenger` | Android Studio and a JDK for Gradle. Android Gradle Plugin `9.0.1`, Kotlin `2.3.20`, `compileSdk` 36, `minSdk` 24. |
| `ios-messenger` | macOS and Xcode. The deployment target is iOS `27.0`. |
| `backend` | Node.js and [pnpm](https://pnpm.io/). |

Run `flutter doctor` to check your Flutter setup.

## Flutter

```bash
cd flutter-messenger
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

- `build_runner` creates the `*.g.dart` files (for example `login_request_dto.g.dart`). You need to run it again after you change a class that uses `@JsonSerializable`.
- While you work on models, `dart run build_runner watch --delete-conflicting-outputs` rebuilds the files for you.
- The app opens on the login screen (`/login`).

Run the tests:

```bash
flutter test
```

## Android

Option 1: open the `android-messenger/` folder in Android Studio, wait for the Gradle sync, choose a device, and press Run.

Option 2: use the command line.

```bash
cd android-messenger
./gradlew assembleDebug
```

Run the tests:

```bash
./gradlew test                  # unit tests (MainScreenViewModelTest)
./gradlew connectedAndroidTest  # UI tests (MainScreenTest), needs a device or emulator
```

The app id is `vn.messenger.app`.

## iOS

1. Open `ios-messenger/ios-messenger.xcodeproj` in Xcode.
2. Choose a simulator.
3. Press Run (`Cmd + R`).

The app only shows "Hello, world!" for now.

## Backend

```bash
cd backend
pnpm install
pnpm run start:dev
```

The server listens on port `3000`. To use another port:

```bash
PORT=4299 pnpm run start:dev
```

Check that it works:

```bash
curl http://localhost:3000
```

Other commands:

| Command | What it does |
| --- | --- |
| `pnpm run start` | Start the server once. |
| `pnpm run start:dev` | Start the server and restart it when a file changes. |
| `pnpm run build` | Compile the project. |
| `pnpm run lint` | Check the code with oxlint. |
| `pnpm run format` | Format the code with Prettier. |
| `pnpm run test` | Run unit tests (Vitest). |
| `pnpm run test:e2e` | Run end-to-end tests. |

## Troubleshooting

### Flutter says a `*.g.dart` file does not exist

The generated files are missing. Run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### The app cannot reach the backend

Check these points one by one:

1. **Port and prefix.** Flutter uses `http://localhost:4299/api` (see `lib/services/connection_instance.dart`). The backend uses port `3000` and has no `/api` prefix. They do not match yet. See [Known gaps](architecture.md#known-gaps).
2. **Android emulator.** Inside the emulator, `localhost` means the emulator itself, not your computer. Your computer is at `10.0.2.2`.
3. **Real phone.** Use your computer's IP address on the same Wi-Fi network, for example `http://192.168.1.10:3000`.
4. **iOS simulator.** `localhost` works, because the simulator shares the network of your Mac.

### `pnpm: command not found`

Install pnpm: see <https://pnpm.io/installation>.

### Gradle sync fails in Android Studio

- Check that Android Studio uses a JDK that is supported by Android Gradle Plugin `9.0.1`.
- Check that the SDK for API level 36 is installed (SDK Manager).
