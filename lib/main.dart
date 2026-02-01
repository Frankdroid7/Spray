import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spray/theme/app_theme.dart';

import 'router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Spray',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}