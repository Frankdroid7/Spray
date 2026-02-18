import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/functions/currency.dart';
import 'package:spray/core/widgets/close_button.dart';
import 'package:spray/core/widgets/custom_textfield.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/features/home/presentation/widgets/naira_icon.dart';
import 'package:spray/theme/app_colors.dart';

class FundWalletModal extends ConsumerStatefulWidget {
  const FundWalletModal({super.key});

  @override
  ConsumerState<FundWalletModal> createState() => _FundWalletModalState();
}

class _FundWalletModalState extends ConsumerState<FundWalletModal> {
  final TextEditingController controller = TextEditingController();
  double amount = 0.0;

  final List<double> quickAmounts = [1_000, 2_000, 5_000, 10_000, 20_000];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      String text = controller.text.trim().replaceAll(",", "");
      amount = double.tryParse(text) ?? 0.0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double targetHeight = MediaQuery.sizeOf(context).height * 0.7;
    return Container(
      width: double.infinity,
      height: targetHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Fund Wallet",
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.brandDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const CustomCloseButton(),
            ],
          ),
          const SizedBox(height: 36),
          Text(
            "How much do you want to fund your account with?",
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 40),
          CustomTextField(
            controller: controller,
            hint: "0.00",
            type: TextInputType.number,
            label: "Enter amount",
            fillColor: Colors.white,
            prefix: const NairaIcon(),
            formatters: [
              CommaInputFormatter(),
              FilteringTextInputFormatter.digitsOnly,
            ],
            radius: BorderRadius.circular(12),
            hintStyle: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary.withValues(alpha: 0.5),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(quickAmounts.length, (i) {
              double value = quickAmounts[i];
              return GestureDetector(
                onTap: () {
                  controller.text = formatCurrency(value, false);
                  setState(() {});
                },
                child: Chip(
                  backgroundColor: AppColors.surfaceBackground,
                  label: Text(
                    "₦${formatCurrency(value, false)}",
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.brandDark,
                    ),
                  ),
                  side: BorderSide(color: AppColors.surfaceBackground),
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }),
          ),
          const Spacer(),
          PrimaryButton(
            onPressed: () {
              ref.read(homeProvider.notifier).addBalance(amount);
              context.router.pop();
            },
            text: "Add ₦${formatCurrency(amount, true)} to Wallet",
            active: amount > 0.0,
          ),
        ],
      ),
    );
  }
}
