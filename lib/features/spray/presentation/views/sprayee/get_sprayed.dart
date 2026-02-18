import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/widgets/back_button.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/features/spray/presentation/widgets/spray_code_timer.dart';
import 'package:spray/features/spray/presentation/widgets/spray_info.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class GetSprayedPage extends StatefulWidget {
  const GetSprayedPage({super.key});

  @override
  State<GetSprayedPage> createState() => _GetSprayedPageState();
}

class _GetSprayedPageState extends State<GetSprayedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Get Sprayed',
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.brandDark,
          ),
        ),
        leading: const CustomBackButton(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SprayInfo(),
            const SizedBox(height: 24),
            const SprayCodeTimer(),
            const Spacer(),
            PrimaryButton(onPressed: () {}, text: "Wait for Sprayer"),
          ],
        ),
      ),
    );
  }
}
