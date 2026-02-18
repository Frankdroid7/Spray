import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotted_border/flutter_dotted_border.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/theme/app_colors.dart';

class SprayCodeTimer extends StatefulWidget {
  const SprayCodeTimer({super.key});

  @override
  State<SprayCodeTimer> createState() => _SprayCodeTimerState();
}

class _SprayCodeTimerState extends State<SprayCodeTimer> {
  final String code = (1000 + Random().nextInt(9000)).toString();
  int totalMinutes = 60 * 12; // Total minutes in 12 hours

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      --totalMinutes;
      if (totalMinutes < 0) {
        totalMinutes = 0;
        timer.cancel();
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: RoundedRectDottedBorder(
        color: AppColors.borderLight,
        dashGap: 4,
        dashWidth: 4,
        strokeWidth: 2,
        radius: Radius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                code,
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  text: "Expires in: ",
                  children: [
                    TextSpan(
                      text: "${totalMinutes ~/ 60}h ${totalMinutes % 60}m",
                      style: TextStyle(color: AppColors.error),
                    ),
                  ],
                ),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Share this code with the sprayer",
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              QrImageView(data: code, version: QrVersions.auto, size: 185),
              const SizedBox(height: 24),
              Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                    },
                    backgroundColor: AppColors.lightBlue,
                    width: 110,
                    height: 32,
                    radius: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          "Copy",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.brandPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          IconsaxPlusBold.copy,
                          color: AppColors.brandPrimary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  PrimaryButton(
                    onPressed: () {
                      SharePlus.instance.share(ShareParams(
                        text: "Connect with me on SprayPay with this code: $code"
                      ));
                    },
                    backgroundColor: AppColors.lightBlue,
                    width: 110,
                    height: 32,
                    radius: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          "Share",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.brandPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          IconsaxPlusBold.send_2,
                          color: AppColors.brandPrimary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
