import 'package:flutter_app/core/app_container/app_container.dart';
import 'package:flutter_app/features/authentication/view_models/authentication_view_model.dart';
import 'package:flutter_app/features/authentication/views/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
      path: "/login",
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<AuthenticationViewModel>(),
        child: LoginScreen(),
      ),
    ),
  ],
);
