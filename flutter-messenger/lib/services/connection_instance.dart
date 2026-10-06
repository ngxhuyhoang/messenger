import 'package:dio/dio.dart';

final dio = Dio();

Dio configureDio() {
  dio.options.baseUrl = "http://localhost:4299/api";
  dio.options.connectTimeout = Duration(seconds: 10);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) {
        return handler.next(request);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ),
  );

  return dio;
}

void setAuthHeader(String? accessToken) {
  if (accessToken != null) {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
  } else {
    dio.options.headers.remove("Authorization");
  }
}

final connectionInstance = configureDio();
