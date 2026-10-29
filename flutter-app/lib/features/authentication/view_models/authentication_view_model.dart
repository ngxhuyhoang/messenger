import 'package:dio/dio.dart';
import 'package:flutter_app/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_app/features/authentication/view_models/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationViewModel extends Cubit<AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationViewModel(this._authenticationRepository) : super(AuthenticationInitial());

  Future<void> handleLogin(String phoneNumber) async {
    if (state is AuthenticationVerifying) return;

    emit(AuthenticationVerifying());
    try {
      await _authenticationRepository.login(phoneNumber);
      emit(AuthenticationSuccess());
    } on DioException catch (e) {
      emit(AuthenticationFailure(_getErrorMessage(e)));
    } catch (_) {
      emit(AuthenticationFailure("Something went wrong, please try again"));
    }
  }

  String _getErrorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map && data["message"] is String) return data["message"];

    if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout) {
      return "Cannot connect to server";
    }
    return "Login failed, please try again";
  }
}
