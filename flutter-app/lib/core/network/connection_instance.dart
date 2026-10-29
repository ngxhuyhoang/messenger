import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class ConnectionInstance extends DioForNative {
  String? accessToken;

  ConnectionInstance() {
    options.baseUrl = "http://10.0.2.2:4299";
    options.connectTimeout = const Duration(seconds: 30);

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          if (accessToken != null) {
            request.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(request);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
      ),
    );
  }

  void setAuthToken(String accessToken) {
    options.headers['Authorization'] = 'Bearer $accessToken';
  }
}
