import 'package:flutter/material.dart'; 
import 'package:go_router/go_router.dart';

import 'screens/home.dart';
import 'screens/loading.dart';
import 'screens/login.dart';
import 'screens/post_form.dart';
import 'screens/signup.dart'; 

abstract class Routes {
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const loading = '/loading';
  static const postCreate = '/post/create';
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
  GoRoute(
    path: Routes.postCreate,
    pageBuilder: (ctx, state) => const MaterialPage(
      fullscreenDialog: true,
      child: PostFormPage(),
    ),
  ),
];