import 'package:flutter/material.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_app/core/app_container/app_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  appContainerConfig();
  runApp(const MessengerApp());
}
