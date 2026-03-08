import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class SpraySessionCompletePage extends ConsumerWidget {
  const SpraySessionCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(sprayProvider.notifier).reset();
    // ref.read(sprayProvider.notifier).setCurrentDenomination(Denomination.fiveHundredNaira);
    return Scaffold(
      backgroundColor: AppColors.brandPrimary,
      body: SafeArea(child: Column(children: [],)),
    );
  }
}
