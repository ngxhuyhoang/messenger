sealed class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationVerifying extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure(this.message);
}
