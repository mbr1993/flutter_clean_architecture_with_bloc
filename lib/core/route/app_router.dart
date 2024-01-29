import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_with_bloc/core/route/route_names.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/presentation/login/pages/auth_page.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/presentation/pages/users_page.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/helper/go_router_refresh_stream.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/services/hive.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter.setStream(BuildContext ctx) {
    context = ctx;
  }

  static late BuildContext context;

  static final router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: root,
        redirect: (context, state) => '/users',
      ),
      GoRoute(
        path: '/auth',
        name: auth,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: '/users',
        name: users,
        builder: (context, state) => const UsersPage(),
      ),
    ],
    redirect: (context, state) {
      final isLoginPage = state.matchedLocation == '/auth';

      if (!((HiveService.hiveBox?.get(HiveKey.isLogin.name) as bool?) ?? false)) {
        return isLoginPage ? null : '/auth';
      }

      if (!((HiveService.hiveBox?.get(HiveKey.isLogin.name) as bool?) ?? false)) {
        return '/users';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
  );
}
