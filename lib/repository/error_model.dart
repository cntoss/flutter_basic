// Dart imports:
import 'dart:convert';

class ErrorModel {
  ErrorModel({
    this.error,
  });

  Error? error;

  factory ErrorModel.fromRawJson(String str) =>
      ErrorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error!.toJson(),
      };
}

class Error {
  Error({
    this.message,
    this.code,
    this.detail,
  });

  String? message;
  int? code;
  dynamic detail;

  factory Error.fromRawJson(String str) => Error.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        code: json["code"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "detail": detail,
      };
}
