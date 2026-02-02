import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/theme/app_colors.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {},
      backgroundColor: AppColors.textPrimary,
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          SvgPicture.asset("assets/svgs/google.svg", width: 24),
          Text(
            "Continue with Google",
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.surfaceBackground,
            ),
          ),
        ],
      ),
    );
  }
}
