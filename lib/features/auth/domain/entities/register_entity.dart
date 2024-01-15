import 'dart:convert';

class RegisterEntity {
  RegisterEntity({this.token});

  factory RegisterEntity.fromRawJson(String str) {
    return RegisterEntity.fromJson(json.decode(str) as Map<String, dynamic>);
  }

  factory RegisterEntity.fromJson(Map<String, dynamic> json) {
    return RegisterEntity(token: json['token'] as String?);
  }

  String? token;

  RegisterEntity copyWith({String? token}) {
    return RegisterEntity(token: token ?? this.token);
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
