import 'package:hive_flutter/adapters.dart';

enum HiveKey {
  token,
  isLogin,
  theme,
  language,
}

mixin class HiveService {
  static late Box<dynamic>? hiveBox;
  static const String hiveBoxName = 'hive_box';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    hiveBox = await Hive.openBox(hiveBoxName);
  }

  Future<void> addValue<T>(HiveKey key, T value) async => await hiveBox?.put(key.name, value);

  Future<void> deleteValue(HiveKey key) async => await hiveBox?.delete(key.name);

  T? getValue<T>(HiveKey key) => hiveBox?.get(key.name) as T;
}
