import 'dart:convert';

import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/entities/register_entity.dart';

class RegisterResponse {
  RegisterResponse({this.id, this.token, this.error});

  factory RegisterResponse.fromRawJson(String str) {
    return RegisterResponse.fromJson(json.decode(str) as Map<String, dynamic>);
  }

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json['id'] as int?,
      token: json['token'] as String?,
      error: json['error'] as String?,
    );
  }

  int? id;
  String? token;
  String? error;

  RegisterResponse copyWith({int? id, String? token, String? error}) {
    return RegisterResponse(
      id: id ?? this.id,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    return {
      'int': id,
      'token': token,
      'error': error,
    };
  }

  RegisterEntity toEntity() => RegisterEntity(token: token);
}
