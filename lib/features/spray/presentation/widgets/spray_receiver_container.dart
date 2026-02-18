import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/features/spray/domain/entities/spray_receiver.dart';
import 'package:spray/theme/app_colors.dart';

class SprayReceiverContainer extends StatelessWidget {
  final SprayReceiver receiver;
  final bool selected;
  final VoidCallback onSelect;

  const SprayReceiverContainer({
    super.key,
    required this.receiver,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Skeleton.shade(
                shade: true,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.brandPrimary,
                  child: Icon(
                    IconsaxPlusBold.user,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Text(
                    receiver.name,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.brandDark,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    receiver.tag,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: onSelect,
            child: Container(
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.surfaceAccentGreen
                    : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Row(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "SELECT${selected ? "ED" : ""}",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.black.withValues(alpha: 0.8),
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    selected
                        ? IconsaxPlusBold.tick_circle
                        : IconsaxPlusLinear.tick_circle,
                    color: selected
                        ? AppColors.coreActionTitleGreen
                        : AppColors.iconDark,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
