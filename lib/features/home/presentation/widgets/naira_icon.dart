import 'package:flutter/material.dart';
import 'package:spray/theme/app_colors.dart';
import 'package:spray/theme/app_text_styles.dart';

class NairaIcon extends StatelessWidget {
  const NairaIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRSuperellipse(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 20,
        height: 20,
        color: AppColors.brandPrimary,
        alignment: Alignment.center,
        child: Text(
          "₦",
          style: AppTextStyles.naira.copyWith(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
