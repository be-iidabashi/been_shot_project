import 'package:go_router/go_router.dart';

import 'screens/home.dart';
import 'screens/loading.dart';
import 'screens/login.dart';
import 'screens/signup.dart'; 

abstract class Routes {
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const loading = '/loading';
}

final routes = <GoRoute>[
  GoRoute(
    path: Routes.login,
    builder: (ctx, state) => const LoginPage(),
  ),
  GoRoute(
    path: Routes.signup,
    builder: (ctx, state) => const SignupPage(),
  ),
  GoRoute(
    path: Routes.home,
    builder: (ctx, state) => const HomePage(),
  ),
  GoRoute(
    path: Routes.loading,
    builder: (ctx, state) => const LoadingPage(),
  ),
];