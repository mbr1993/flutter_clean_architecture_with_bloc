class RegisterEntity {
  RegisterEntity({this.token});

  factory RegisterEntity.fromJson(Map<String, dynamic> json) {
    return RegisterEntity(token: json['token'] as String?);
  }

  String? token;

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
