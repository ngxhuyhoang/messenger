import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BaseResponse<T> {
  bool isSuccess;
  String? message;
  T? data;

  BaseResponse({this.isSuccess = false, this.message, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);
}

typedef FetchApiResponse<T> = Future<Response<BaseResponse<T>>>;
