import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/widgets/app_button.dart';
import 'package:spray/theme/app_colors.dart';

class AppleButton extends StatelessWidget {
  const AppleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      onPressed: () {},
      backgroundColor: AppColors.surfaceBackground,
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          SvgPicture.asset("assets/svgs/apple.svg", width: 24),
          Text(
            "Continue with Apple",
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.surfaceDark,
            ),
          ),
        ],
      ),
    );
  }
}
