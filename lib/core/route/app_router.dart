import 'package:flutter_clean_architecture_with_bloc/core/route/not_found_screen.dart';
import 'package:flutter_clean_architecture_with_bloc/core/route/route_names.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/presentation/login/pages/auth_page.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/presentation/pages/users_page.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/services/hive.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: RouteNames.root.path,
        name: RouteNames.root.name,
        redirect: (context, state) => RouteNames.users.path,
      ),
      GoRoute(
        path: RouteNames.auth.path,
        name: RouteNames.auth.name,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: RouteNames.users.path,
        name: RouteNames.users.name,
        builder: (context, state) => const UsersPage(),
      ),
    ],
    initialLocation: HiveService().hasToken() ? RouteNames.users.path : RouteNames.auth.path,
    errorBuilder: (context, state) => const NotFoundScreen(),
    // redirect: (_, state) {
    //   final isLoginPage = state.matchedLocation == RouteNames.auth.path;
    //
    //   if (HiveService().hiveBox?.get(HiveKey.token) == null) {
    //     return isLoginPage ? null : RouteNames.auth.path;
    //   }
    //
    //   if (isLoginPage && ((HiveService().hiveBox?.get(HiveKey.token) as bool?) ?? false)) {
    //     return RouteNames.root.path;
    //   }
    //   return null;
    // },
    // refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
  );
}
