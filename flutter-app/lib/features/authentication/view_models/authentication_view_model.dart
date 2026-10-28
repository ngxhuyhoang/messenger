import 'package:flutter_app/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationViewModel extends Cubit<void> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationViewModel(this._authenticationRepository) : super(null);

  void handleLogin(String phoneNumber) {
    _authenticationRepository.login();
  }
}
