import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(createFactory: false)
class LoginRequest {
  final String phoneNumber;

  LoginRequest({required this.phoneNumber});

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
