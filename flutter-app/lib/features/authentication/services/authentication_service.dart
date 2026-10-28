import 'package:dio/dio.dart';

class AuthenticationService {
  final Dio _dio;

  AuthenticationService(this._dio);

  Future<Response<dynamic>> login() {
    return _dio.post("/login", data: {'phone_number': ''});
  }
}
