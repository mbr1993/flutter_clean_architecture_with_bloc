import 'dart:convert';

class LoginEntity {
  LoginEntity({this.token});

  factory LoginEntity.fromRawJson(String str) {
    return LoginEntity.fromJson(json.decode(str) as Map<String, dynamic>);
  }

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(token: json['token'] as String?);
  }

  String? token;

  LoginEntity copyWith({String? token}) {
    return LoginEntity(token: token ?? this.token);
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {'token': token};
}
