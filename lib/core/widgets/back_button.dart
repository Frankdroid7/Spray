import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spray/theme/app_colors.dart';


class CustomBackButton extends StatelessWidget {
  final bool invert;
  const CustomBackButton({super.key, this.invert = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pop(),
      child: SizedBox(
        width: 48,
        height: 32,
        child: Center(
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: invert ? AppColors.cardBackgroundDark : AppColors.cardBackground,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: invert ? Colors.white : AppColors.surfaceDark,
            ),
          ),
        ),
      ),
    );
  }
}
