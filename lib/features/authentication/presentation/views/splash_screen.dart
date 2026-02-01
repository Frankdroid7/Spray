import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spray/core/app_extensions.dart';
import 'package:spray/router/app_router.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.fastOutSlowIn,
      ),
    );

    _runAnimation();
  }

  Future<void> _runAnimation() async {
    await controller.forward();
    await controller.reverse();
    if (!mounted) return;

    context.router.replacePath(Paths.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandPrimary,
      body: Center(
        child: FadeTransition(
          opacity: animation,
          child: Text('Spraypay', style: context.textTheme.displayLarge),
        ),
      ),
    );
  }
}
