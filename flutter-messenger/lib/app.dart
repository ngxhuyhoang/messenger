import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_messenger/features/auth/repositories/auth_repository.dart';
import 'package:flutter_messenger/features/auth/services/auth_service.dart';
import 'package:flutter_messenger/shared/common/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => AuthRepository(AuthService()))],
      child: MaterialApp.router(routerConfig: router, debugShowCheckedModeBanner: false),
    );
  }
}
