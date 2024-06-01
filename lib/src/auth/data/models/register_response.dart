import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/entities/register_entity.dart';

class RegisterResponse {
  RegisterResponse({this.id, this.token, this.error});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        id: json['id'] as int?,
        token: json['token'] as String?,
        error: json['error'] as String?,
      );

  int? id;
  String? token;
  String? error;

  Map<String, dynamic> toJson() => {'int': id, 'token': token, 'error': error};

  RegisterEntity toEntity() => RegisterEntity(token: token);
}
