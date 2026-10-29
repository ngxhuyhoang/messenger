import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_container/app_container.dart';
import 'package:flutter_app/core/routing/router.dart';
import 'package:flutter_app/features/authentication/view_models/authentication_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessengerApp extends StatelessWidget {
  const MessengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<AuthenticationViewModel>())],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black)),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.red)),
          ),
        ),
      ),
    );
  }
}
