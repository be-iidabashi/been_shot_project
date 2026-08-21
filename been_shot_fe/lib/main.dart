import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:go_router/go_router.dart';

import 'providers/initial_route.dart';
import 'routes.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: BeEnShotApp(),
    ),    
  );
}

class BeEnShotApp extends ConsumerWidget {
  const BeEnShotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'BeEn Shot',
      routerConfig: GoRouter(
        routes: routes,
        initialLocation:
            ref.watch(initialRouteProvider).value ?? Routes.loading,
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(83, 226, 103, 1),
          brightness: Brightness.light,
        ),
      ),
    );
  }
}