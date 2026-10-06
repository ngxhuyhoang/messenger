import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_messenger/features/auth/cubits/login_state.dart';
import 'package:flutter_messenger/features/auth/repositories/auth_repository.dart';
import 'package:flutter_messenger/shared/common/app_exception.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginInitial());

  Future<void> login(String email, String password) async {
    if (state is LoginLoading) return;

    emit(const LoginLoading());

    try {
      await _authRepository.login(email, password);
      if (isClosed) return;
      emit(const LoginSuccess());
    } on AppException catch (e) {
      if (isClosed) return;
      emit(LoginFailure(e.message));
    }
  }
}
