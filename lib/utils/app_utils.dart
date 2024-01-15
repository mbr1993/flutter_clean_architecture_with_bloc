import 'package:flutter/foundation.dart';

class AppUtils {
  // Prevent the utility class from being instantiated.
  AppUtils._();

  static void myPrint(dynamic message) {
    if (kDebugMode) print(message);
  }
}
