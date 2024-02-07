import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_with_bloc/core/route/app_router.dart';
import 'package:flutter_clean_architecture_with_bloc/dependencies_injection.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/presentation/login/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Service locator
  await serviceLocator();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (BuildContext context) => sl<AuthCubit>(),
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Demo App',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
