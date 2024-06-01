class User {
  User({this.name, this.avatar, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
    );
  }

  String? name;
  String? avatar;
  String? email;

  User copyWith({String? name, String? avatar, String? email}) {
    return User(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'email': email,
    };
  }
}
