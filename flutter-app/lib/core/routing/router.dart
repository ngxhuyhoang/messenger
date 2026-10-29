import 'package:flutter_app/features/authentication/view_models/authentication_state.dart';
import 'package:flutter_app/features/authentication/view_models/authentication_view_model.dart';
import 'package:flutter_app/features/authentication/views/login_view.dart';
import 'package:flutter_app/features/conversations/views/conversation_view.dart';
import 'package:flutter_app/features/home/views/home_view.dart';
import 'package:flutter_app/features/profile/views/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/login",
  redirect: (context, goRouterState) {
    final isLoggedIn = context.read<AuthenticationViewModel>().state is AuthenticationSuccess;
    final isOnLoginPage = goRouterState.matchedLocation == '/login';

    if (!isLoggedIn && !isOnLoginPage) return "/login";
    if (isLoggedIn && isOnLoginPage) return "/conversation";

    return null;
  },
  routes: [
    GoRoute(path: "/login", builder: (context, state) => LoginScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeView(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: "/conversation", builder: (context, state) => ConversationView())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: "/profile", builder: (context, state) => ProfileView())],
        ),
      ],
    ),
  ],
);
