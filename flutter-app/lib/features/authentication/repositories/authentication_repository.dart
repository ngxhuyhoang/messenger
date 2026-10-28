import 'package:flutter_app/features/authentication/services/authentication_service.dart';

class AuthenticationRepository {
  final AuthenticationService _authenticationService;

  AuthenticationRepository(this._authenticationService);

  Future<void> login() async {
    final response = await _authenticationService.login();
  }
}
