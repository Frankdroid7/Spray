import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/features/spray/presentation/views/sprayee/get_sprayed.dart';
import 'package:spray/features/spray/presentation/views/sprayer/spray_someone.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

class CoreActions extends StatelessWidget {
  const CoreActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: _Action(
            backgroundColor: AppColors.surfaceAccentBlue,
            titleColor: AppColors.coreActionTitleBlue,
            subtitleColor: AppColors.coreActionSubtitleBlue,
            subtitle: "Send Money",
            title: "Spray Someone",
            image: "💸",
            onTap: () => context.router.push(const SpraySomeoneRoute()),
          ),
        ),
        Expanded(
          child: _Action(
            backgroundColor: AppColors.surfaceAccentGreen,
            titleColor: AppColors.coreActionTitleGreen,
            subtitleColor: AppColors.coreActionSubtitleGreen,
            subtitle: "Receive Money",
            title: "Get Sprayed",
            image: "🎁",
            onTap: () => context.router.push(const GetSprayedRoute()),
          ),
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final Color backgroundColor, titleColor, subtitleColor;
  final String title, subtitle, image;
  final VoidCallback onTap;

  const _Action({
    super.key,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.subtitle,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Text(image, style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 36),
              Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: subtitleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
