import 'dart:convert';

import 'package:flutter_clean_architecture_with_bloc/features/users/domain/entities/user.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/domain/entities/users.dart';

class UsersModel {
  UsersModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.dataUser,
    this.support,
  });

  factory UsersModel.fromRawJson(String str) => UsersModel.fromJson(json.decode(str) as Map<String, dynamic>);

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        page: json['page'] as int?,
        perPage: json['per_page'] as int?,
        total: json['total'] as int?,
        totalPages: json['total_pages'] as int?,
        dataUser: (json['data'] as List<dynamic>?)?.map((e) {
          return DataUser.fromJson(e as Map<String, dynamic>);
        }).toList(),
        support: json['support'] == null ? null : Support.fromJson(json['support'] as Map<String, dynamic>),
      );

  Users toEntity() {
    final listUser = dataUser!
        .map<User>(
          (model) => User(
            name: '${model.firstName} ${model.lastName}',
            avatar: model.avatar ?? '',
            email: model.email ?? '',
          ),
        )
        .toList();
    return Users(
      page: page ?? 1,
      totalPages: totalPages ?? 1,
      userList: listUser,
    );
  }

  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<DataUser>? dataUser;
  Support? support;

  UsersModel copyWith({
    int? page,
    int? perPage,
    int? total,
    int? totalPages,
    List<DataUser>? dataUser,
    Support? support,
  }) =>
      UsersModel(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        totalPages: totalPages ?? this.totalPages,
        dataUser: dataUser ?? this.dataUser,
        support: support ?? this.support,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'data': dataUser?.map((e) => e.toJson()).toList(),
      'support': support?.toJson(),
    };
  }
}

class DataUser {
  DataUser({this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory DataUser.fromRawJson(String str) => DataUser.fromJson(json.decode(str) as Map<String, dynamic>);

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      id: json['id'] as int?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  DataUser copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      DataUser(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'avatar': avatar,
      };
}

class Support {
  Support({this.url, this.text});

  factory Support.fromRawJson(String str) => Support.fromJson(json.decode(str) as Map<String, dynamic>);

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json['url'] as String?,
        text: json['text'] as String?,
      );
  String? url;
  String? text;

  Support copyWith({String? url, String? text}) => Support(
        url: url ?? this.url,
        text: text ?? this.text,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {'url': url, 'text': text};
}
