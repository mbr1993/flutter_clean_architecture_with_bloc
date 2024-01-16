import 'dart:convert';

import 'package:flutter_clean_architecture_with_bloc/features/users/domain/entities/user.dart';

class Users {
  int? page;
  int? totalPages;
  List<User>? userList;

  Users({this.page, this.totalPages, this.userList});

  factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str) as Map<String, dynamic>);

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        page: json['page'] as int?,
        totalPages: json['total_pages'] as int?,
        userList: (json['data'] as List<dynamic>?)?.map((e) {
          return User.fromJson(e as Map<String, dynamic>);
        }).toList(),
      );

  Users copyWith({int? page, int? totalPages, List<User>? userList}) {
    return Users(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      userList: userList ?? this.userList,
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'total_pages': totalPages,
      'data': userList == null
          ? <dynamic>[]
          : List<dynamic>.from(
              userList!.map((x) => x.toJson()),
            ),
    };
  }
}
