import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GetSprayedPage extends StatelessWidget {
  const GetSprayedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get Sprayed')),
      body: const Center(child: Text('Get Sprayed Content')),
    );
  }
}
