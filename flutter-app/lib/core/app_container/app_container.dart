import 'package:dio/dio.dart';
import 'package:flutter_app/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_app/features/authentication/services/authentication_service.dart';
import 'package:flutter_app/features/authentication/view_models/authentication_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

// AuthenticationRepository(AuthenticationService(Dio()))

void appContainerConfig() {
  getIt.registerFactory<Dio>(() => Dio());
  getIt.registerFactory<AuthenticationService>(() => AuthenticationService(getIt<Dio>()));
  getIt.registerFactory<AuthenticationRepository>(() => AuthenticationRepository(getIt<AuthenticationService>()));
  getIt.registerFactory<AuthenticationViewModel>(() => AuthenticationViewModel(getIt<AuthenticationRepository>()));
}
