import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EnterSprayCodePage extends StatelessWidget {
  const EnterSprayCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Spray Code')),
      body: const Center(child: Text('Enter Spray Code Content')),
    );
  }
}
