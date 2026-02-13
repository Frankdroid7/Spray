import 'package:flutter/material.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/theme/app_colors.dart';

class SprayInfo extends StatelessWidget {
  const SprayInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceAccentGreen,
        border: Border.all(color: AppColors.outlineGreen),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("🎉", style: TextStyle(fontSize: 20)),
          Expanded(
            child: Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Spray Code",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.brandDark,
                  ),
                ),
                Text(
                  "Share this code with anyone who wants to spray you",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
