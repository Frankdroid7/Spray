import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ReceivingSprayPage extends StatelessWidget {
  const ReceivingSprayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receiving Spray')),
      body: const Center(child: Text('Receiving Spray Content')),
    );
  }
}
