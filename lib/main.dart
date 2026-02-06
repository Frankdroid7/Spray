import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/router/app_router.dart';
import 'package:spray/theme/app_theme.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: kDebugMode,
      builder: (_) => const ProviderScope(child: Spray()),
    ),
  );
}

class Spray extends StatefulWidget {
  const Spray({super.key});

  @override
  State<Spray> createState() => _SprayState();
}

class _SprayState extends State<Spray> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Spray',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
