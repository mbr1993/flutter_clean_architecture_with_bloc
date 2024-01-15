import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_with_bloc/app.dart';
import 'package:flutter_clean_architecture_with_bloc/dependencies_injection.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/app_utils.dart';

void main() {
  runZonedGuarded(
    /// Lock device orientation to portrait
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// Service locator
      await serviceLocator();
      return SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      ).then((value) => runApp(const MainApp()));
    },
    (error, stack) => AppUtils.myPrint(error),
  );
}
