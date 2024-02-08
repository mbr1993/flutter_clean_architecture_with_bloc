import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/entities/token_entity.dart';

class LoginResponse {
  LoginResponse({this.id, this.token, this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json['id'] as int?,
        token: json['token'] as String?,
        error: json['error'] as String?,
      );

  int? id;
  String? token;
  String? error;

  LoginResponse copyWith({int? id, String? token, String? error}) => LoginResponse(
        id: id ?? this.id,
        token: token ?? this.token,
        error: error ?? this.error,
      );

  Map<String, dynamic> toJson() => {'int': id, 'token': token, 'error': error};

  TokenEntity tokenEntity() => TokenEntity(token);
}
