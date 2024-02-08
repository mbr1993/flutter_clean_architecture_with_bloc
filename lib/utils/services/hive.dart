import 'package:hive_flutter/adapters.dart';

mixin class HiveService {
  static Box<dynamic>? box;
  static const _hiveBox = 'hiveBox';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    box = await Hive.openBox<dynamic>(_hiveBox);
  }

  /// Token
  Future<void> saveToken(String token) async => await box?.put('token', token);

  Future<void> deleteToken() async => box?.delete('token');

  bool hasToken() => box?.containsKey('token') ?? false;
}
