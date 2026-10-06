import 'package:flutter_messenger/features/auth/models/login_request_dto.dart';
import 'package:flutter_messenger/features/auth/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<void> login(String email, String password) async {
    final body = LoginRequestDto(email: email, password: password);
    final response = await _authService.login(body);
  }

  Future<void> logout() async {
    _authService.logout();
  }
}
