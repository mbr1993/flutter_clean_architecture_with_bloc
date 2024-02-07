import 'package:hive_flutter/adapters.dart';

mixin class HiveService {
  static Box<String>? box;
  static const _hiveBoxName = 'HiveBox';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    box = await Hive.openBox<String>(_hiveBoxName);
  }

  /// Save Token
  Future<void> saveToken(String token) async => await box?.put('token', token);

  /// Delete Token
  Future<void> deleteToken() async => box?.delete('token');

  /// Check Token
  bool hasToken() => box?.containsKey('token') ?? false;
}
