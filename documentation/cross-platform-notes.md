# Cross-platform learning notes

The goal of this repo is to build the same app on Flutter, Android (Jetpack Compose) and iOS (SwiftUI), and to compare them. All three use the **MVVM** pattern, so a screen has the same three parts everywhere: a View, a ViewModel and a Model (repository, service, DTOs). See [architecture.md](architecture.md#pattern-mvvm-on-all-three-platforms) for the rules. This page maps the same idea to each platform.

How to read the tables:

- **Used here** means the code in this repo already uses it.
- **Not built yet** means the platform has no code for it yet. I list the usual tool as a hint, so you can learn it when you get there.

## Concept map

| Idea                        | Flutter                                                                 | Android (Compose)                                                                                        | iOS (SwiftUI)                                                      |
| --------------------------- | ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| A piece of UI               | `StatelessWidget` / `StatefulWidget`. Used here: `Login`, `Home`.       | `@Composable` function. Used here: `MainScreen`.                                                         | `View` struct. Used here: `ContentView`.                           |
| **ViewModel** (holder of screen state) | Not final. `LoginCubit` (`flutter_bloc`) does this job today. `LoginViewModel` exists but is empty. | `ViewModel` with `StateFlow`. Used here: `MainScreenViewModel`. | An `@Observable` class (the older style is `ObservableObject`). Not built yet. |
| Model of UI state           | `sealed class LoginState`. Used here.                                   | `sealed interface MainScreenUiState`. Used here.                                                         | An `enum` with associated values. Not built yet.                   |
| Listen to state in the UI   | `BlocListener` / `BlocBuilder`. Used here: both in `Login`.             | `collectAsStateWithLifecycle()`. Used here.                                                              | The View reads the ViewModel's properties. It owns the ViewModel with `@State` and uses `@Bindable` for input fields. Not built yet. |
| Navigation                  | `go_router`: `GoRouter`, `context.go('/home')`. Used here.              | Navigation 3: `NavDisplay`, `rememberNavBackStack`, `NavKey`. Used here.                                 | `NavigationStack`. Not built yet.                                  |
| Give objects to the screens | `RepositoryProvider` / `BlocProvider`. Used here.                       | A factory in `viewModel { ... }`. Used here.                                                             | Pass objects through `init`, or use `@Environment`. Not built yet. |
| HTTP client                 | `dio`. Used here.                                                       | Not chosen yet (for example Retrofit or Ktor).                                                           | `URLSession`. Not built yet.                                       |
| JSON                        | `json_serializable` and `build_runner`. Used here.                      | The `kotlinx.serialization` plugin is applied (it is used by `NavKey`). A JSON library is not added yet. | `Codable`. Not built yet.                                          |
| Theme and colors            | `AppColor.primary` is used here. No custom `ThemeData` is set yet.      | `MessengerTheme` with `Color.kt`, `Type.kt`. Used here.                                                  | `Assets.xcassets`, `AccentColor`. Partly used.                     |
| Unit test                   | `flutter_test`. Not used for Cubit or repository code yet.              | JUnit and `kotlinx-coroutines-test`. Used here: `MainScreenViewModelTest`.                               | Not built yet.                                                     |
| UI test                     | `testWidgets`. Used here: `test/widget_test.dart` tests the login form. | Compose UI test. Used here: `MainScreenTest`.                                                            | Not built yet.                                                     |
| Project file                | `pubspec.yaml`                                                          | `build.gradle.kts` and `gradle/libs.versions.toml`                                                       | `.xcodeproj`                                                       |
| Package manager             | `pub`                                                                   | Gradle                                                                                                   | Swift Package Manager (in Xcode)                                   |

## Same idea, three shapes

All three platforms follow the same loop: **the View shows a state, the user does something, the ViewModel changes the state, and the View shows the new state.**

| Step                       | Flutter (`LoginCubit`, which plays the ViewModel role today)   | Android (`MainScreenViewModel`)   |
| -------------------------- | -------------------------------------------------------------- | --------------------------------- |
| State type                 | `LoginInitial`, `LoginLoading`, `LoginSuccess`, `LoginFailure` | `Loading`, `Success`, `Error`     |
| How the state is published | `emit(...)`                                                    | `StateFlow` (made with `stateIn`) |
| How the UI watches it      | `BlocListener` and `context.read<LoginCubit>()`                | `collectAsStateWithLifecycle()`   |
| Where the data comes from  | `AuthRepository`                                               | `DataRepository`                  |

Differences to notice:

- In Flutter, the Cubit **pushes** new states with `emit`. In Android, the ViewModel **builds** a `StateFlow` from a `Flow` coming from the repository.
- Flutter handles one-time events (like moving to `/home`) in a listener. In the Android code, the UI only draws the state, and no one-time event exists yet.
- Flutter creates the Cubit in the router (`BlocProvider` in the `/login` route). Android creates the ViewModel in the screen (`viewModel { ... }`).

## Use the same names

To make the comparison easy, use the same names for the same parts on every platform:

| Part | Name |
| --- | --- |
| ViewModel of the login screen | `LoginViewModel` |
| State of the login screen | `LoginUiState` (Android already uses the `...UiState` style) |
| Repository | `AuthRepository` |

Flutter still names its state `LoginState`. Renaming it to `LoginUiState` is a small step toward the same names.

## What to compare next

Follow the TODO list in the [README](../README.md):

1. **ViewModel in Flutter.** Decide how `LoginViewModel` works: keep `Cubit` or use `ChangeNotifier`. Then remove the one you do not use.
2. **Login screen on Android.** Build it with Compose, a `LoginViewModel` and a `LoginUiState`. Compare it with the Flutter login.
3. **Login screen on iOS.** Build it with SwiftUI and an `@Observable` `LoginViewModel`. Compare how each platform shows an error message.
4. **Input validation.** Flutter checks the email and password inside the View. Decide where this logic should live in MVVM, and keep it in the same place on all platforms.
5. **Networking.** Pick an HTTP client on Android and iOS. Compare it with `dio` (interceptors, timeouts, the Bearer header).
6. **Token storage.** Find the secure place to save the access token on each platform.
7. **Chat list.** Compare how each platform shows a long scrolling list: `ListView`, `LazyColumn`, `List`.
