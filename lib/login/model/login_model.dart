// Dart imports:
import 'dart:convert';

class LoginModel {
  LoginModel({
    this.email,
    this.password,
  });

  final String? email;
  final String? password;

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null || email == "" ? null : email,
        "password": password == null || password == "" ? null : password,
      };
}
