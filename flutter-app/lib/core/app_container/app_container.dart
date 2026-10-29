import 'package:flutter_app/core/network/connection_instance.dart';
import 'package:flutter_app/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_app/features/authentication/services/authentication_service.dart';
import 'package:flutter_app/features/authentication/view_models/authentication_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

// AuthenticationRepository(AuthenticationService(Dio()))

void appContainerConfig() {
  getIt.registerLazySingleton<ConnectionInstance>(() => ConnectionInstance());

  getIt.registerFactory<AuthenticationService>(() {
    final connectionInstance = getIt<ConnectionInstance>();
    return AuthenticationService(connectionInstance);
  });
  getIt.registerFactory<AuthenticationRepository>(() {
    final authenticationService = getIt<AuthenticationService>();
    final connectionInstance = getIt<ConnectionInstance>();
    return AuthenticationRepository(authenticationService, connectionInstance);
  });
  getIt.registerFactory<AuthenticationViewModel>(() {
    final authenticationRepository = getIt<AuthenticationRepository>();
    return AuthenticationViewModel(authenticationRepository);
  });
}
