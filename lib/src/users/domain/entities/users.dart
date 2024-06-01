import 'package:flutter_clean_architecture_with_bloc/src/users/domain/entities/user.dart';

class Users {
  Users({this.page, this.totalPages, this.userList});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        page: json['page'] as int?,
        totalPages: json['total_pages'] as int?,
        userList: (json['data'] as List<dynamic>?)?.map((e) {
          return User.fromJson(e as Map<String, dynamic>);
        }).toList(),
      );

  int? page;
  int? totalPages;
  List<User>? userList;

  Users copyWith({int? page, int? totalPages, List<User>? userList}) {
    return Users(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      userList: userList ?? this.userList,
    );
  }

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
