import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/features/spray/domain/entities/spray_receiver.dart';
import 'package:spray/theme/app_colors.dart';

class SprayReceiverContainer extends StatelessWidget {
  final SprayReceiver receiver;

  const SprayReceiverContainer({super.key, required this.receiver});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight)
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(receiver.name, style: context.textTheme.labelMedium?.copyWith(),),
                  Text(receiver.tag),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
