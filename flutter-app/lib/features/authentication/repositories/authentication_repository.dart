import 'package:flutter_app/core/network/connection_instance.dart';
import 'package:flutter_app/core/utils/storage_key.dart';
import 'package:flutter_app/features/authentication/models/login_response.dart';
import 'package:flutter_app/features/authentication/services/authentication_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationRepository {
  final AuthenticationService _authenticationService;
  final ConnectionInstance _connectionInstance;
  final secureStorage = FlutterSecureStorage();

  AuthenticationRepository(this._authenticationService, this._connectionInstance);

  Future<void> login(String phoneNumber) async {
    LoginResponse response = await _authenticationService.login(phoneNumber);
    secureStorage.write(key: SecureStorageKey.accessToken, value: response.accessToken);
    _connectionInstance.setAuthToken(response.accessToken);
  }
}
