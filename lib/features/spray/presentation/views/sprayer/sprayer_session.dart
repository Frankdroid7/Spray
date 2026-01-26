import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SprayerSessionPage extends StatelessWidget {
  const SprayerSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sprayer Session')),
      body: const Center(child: Text('Sprayer Session Content')),
    );
  }
}
