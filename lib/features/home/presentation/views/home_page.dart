import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spray/core/app_extensions.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text('Home Content', style: context.textTheme.titleLarge?.copyWith(
          fontSize: 28,
        ),),
      ),
    );
  }
}
