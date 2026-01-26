import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SpraySomeonePage extends StatelessWidget {
  const SpraySomeonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spray Someone')),
      body: const Center(child: Text('Spray Someone Content')),
    );
  }
}
