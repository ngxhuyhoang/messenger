import 'package:dio/dio.dart';
import 'package:flutter_messenger/features/auth/models/login_request_dto.dart';
import 'package:flutter_messenger/services/connection_instance.dart';

class AuthService {
  Future<Future<Response<dynamic>>> login(LoginRequestDto body) async {
    return connectionInstance.post("/auth/login", data: body.toJson());
  }

  Future<Response<String>> logout() {
    return connectionInstance.post("/auth/login");
  }
}
