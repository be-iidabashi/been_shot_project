import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../routes.dart';
import '../services/account.dart';

part 'initial_route.g.dart';

@Riverpod(keepAlive: true)
class InitialRoute extends _$InitialRoute {
  @override
  Future<String> build() async {
    try {
      final isVerified = await AccountService().verify();
      return isVerified ? Routes.home : Routes.login;
    } catch (e) {
      return Routes.login;
    }
  }
}