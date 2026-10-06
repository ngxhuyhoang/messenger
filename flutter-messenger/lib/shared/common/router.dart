import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_messenger/features/auth/cubits/login_cubit.dart';
import 'package:flutter_messenger/features/auth/repositories/auth_repository.dart';
import 'package:flutter_messenger/features/auth/views/login.dart';
import 'package:flutter_messenger/features/home/views/home.dart';
import 'package:flutter_messenger/features/splash/views/splash.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(path: "/splash", builder: (context, state) => const Splash()),
    GoRoute(path: "/home", builder: (context, state) => const Home()),
    GoRoute(
      path: "/login",
      builder: (context, state) => BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(context.read<AuthRepository>()),
        child: const Login(),
      ),
    ),
  ],
);
