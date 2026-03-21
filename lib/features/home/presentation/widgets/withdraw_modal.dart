import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/functions/currency.dart';
import 'package:spray/core/widgets/close_button.dart';
import 'package:spray/core/widgets/combobox.dart';
import 'package:spray/core/widgets/custom_textfield.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/core/models/transaction.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/features/home/presentation/widgets/naira_icon.dart';
import 'package:spray/theme/app_colors.dart';

class WithdrawModal extends ConsumerStatefulWidget {
  const WithdrawModal({super.key});

  @override
  ConsumerState<WithdrawModal> createState() => _WithdrawModalState();
}

class _WithdrawModalState extends ConsumerState<WithdrawModal> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final List<String> banks = ["Bank A", "Bank B", "Bank C", "Bank D", "Bank E"];

  String resolvedName = "";
  String? selectedBank;

  double amount = 0.0;

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      String text = amountController.text.trim().replaceAll(",", "");
      amount = double.tryParse(text) ?? 0.0;
      setState(() {});
    });
    numberController.addListener(_determineResolvedName);
  }

  @override
  void dispose() {
    numberController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _determineResolvedName() {
    String accountNumber = numberController.text.trim();
    if (accountNumber.length == 10 && selectedBank != null) {
      resolvedName = "FREEBORN EHIRHERE";
      setState(() {});
    } else {
      if (resolvedName.isNotEmpty) {
        resolvedName = "";
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double targetHeight = MediaQuery.sizeOf(context).height * 0.7;
    double balance = ref.watch(homeProvider.select((async) => async.value?.balance ?? 0.0));

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
                "Withdraw to Bank",
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.brandDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const CustomCloseButton(),
            ],
          ),
          const SizedBox(height: 36),
          CustomTextField(
            controller: amountController,
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
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text.rich(
              TextSpan(
                text: "Your Wallet Balance: ",
                children: [
                  TextSpan(
                    text: "₦${formatCurrency(balance, true)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textTertiary,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ComboBox(
            hint: "Select a bank",
            label: "Bank",
            value: selectedBank,
            dropdownItems: banks,
            onChanged: (b) {
              setState(() => selectedBank = b);
              _determineResolvedName();
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: numberController,
            hint: "1234567890",
            type: TextInputType.number,
            label: "Account Number",
            fillColor: Colors.white,
            formatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
            ],
            radius: BorderRadius.circular(12),
          ),
          const SizedBox(height: 8),
          if (resolvedName.isNotEmpty)
            Text(
              resolvedName,
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.brandPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          const Spacer(),
          PrimaryButton(
            onPressed: () async {
              final value = double.tryParse(
                      amountController.text.trim().replaceAll(",", "")) ??
                  0.0;
              if (value <= 0) return;
              final router = context.router;
              final messenger = ScaffoldMessenger.of(context);
              try {
                await ref.read(homeProvider.notifier).addBalance(
                      -value,
                      type: TransactionType.debit,
                      narration: 'Withdrawal',
                    );
                if (mounted) router.pop();
              } catch (_) {
                if (mounted) {
                  messenger.showSnackBar(
                    const SnackBar(
                        content: Text('Withdrawal failed. Try again.')),
                  );
                }
              }
            },
            text: "Withdraw",
            active: resolvedName.isNotEmpty && amount > 0.0,
          ),
        ],
      ),
    );
  }
}
