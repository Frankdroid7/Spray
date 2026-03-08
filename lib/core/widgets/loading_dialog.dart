import 'package:flutter/material.dart';
import 'package:spray/core/extensions/app_extensions.dart';

class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(horizontal: (width - 150) * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const CircularProgressIndicator(strokeWidth: 5),
          const SizedBox(height: 20),
          Text(message, style: context.textTheme.labelMedium),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
