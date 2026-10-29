import 'package:dio/dio.dart';
import 'package:flutter_app/features/authentication/models/login_request.dart';
import 'package:flutter_app/features/authentication/models/login_response.dart';

class AuthenticationService {
  final Dio _dio;

  AuthenticationService(this._dio);

  Future<LoginResponse> login(String phoneNumber) async {
    final response = await _dio.post("/auth/login", data: LoginRequest(phoneNumber: phoneNumber).toJson());
    return LoginResponse.fromJson(response.data);
  }
}
