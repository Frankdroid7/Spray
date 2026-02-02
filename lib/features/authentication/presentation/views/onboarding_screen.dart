import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/features/authentication/presentation/widgets/apple_button.dart';
import 'package:spray/features/authentication/presentation/widgets/google_button.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                    "assets/svgs/onboarding.svg",
                    height: 380,
                    fit: BoxFit.contain,
                  )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                  )
                  .moveY(end: 24, curve: Curves.easeIn),
              const SizedBox(height: 24),
              Text("Spraypay", style: context.textTheme.displayMedium),
              const SizedBox(height: 8),
              Text(
                "Celebrate moments.\nSpray money digitally.",
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const GoogleButton(),
              const SizedBox(height: 16),
              const AppleButton(),
              const SizedBox(height: 32),
              Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  children: [
                    TextSpan(
                      text: "Log in",
                      style: TextStyle(
                        color: AppColors.brandDark,
                        fontWeight: FontWeight.w700,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.router.push(LoginRoute());
                        },
                    ),
                  ],
                ),
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
