import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SpraySessionCompletePage extends StatelessWidget {
  const SpraySessionCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spray Session Complete')),
      body: const Center(child: Text('Spray Session Complete Content')),
    );
  }
}
