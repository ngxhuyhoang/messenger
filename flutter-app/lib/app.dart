import 'package:flutter/material.dart';
import 'package:flutter_app/core/routing/router.dart';

class MessengerApp extends StatelessWidget {
  const MessengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}
