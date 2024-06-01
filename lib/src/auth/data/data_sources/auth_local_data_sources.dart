import 'package:flutter_clean_architecture_with_bloc/utils/services/hive.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);

  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._hive);

  final HiveService _hive;

  @override
  Future<void> deleteToken() async => _hive.deleteToken();

  @override
  Future<void> saveToken(String token) async => _hive.saveToken(token);
}
