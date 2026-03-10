import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/functions/currency.dart';
import 'package:spray/core/models/denomination.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/features/spray/presentation/providers/spray_provider.dart';
import 'package:spray/features/spray/presentation/widgets/wallet.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class ReceivingSprayPage extends ConsumerStatefulWidget {
  const ReceivingSprayPage({super.key});

  @override
  ConsumerState<ReceivingSprayPage> createState() => _ReceivingSprayPageState();
}

class _ReceivingSprayPageState extends ConsumerState<ReceivingSprayPage> {
  int total = 0;
  late double initialBalance;
  Timer? sprayTimer, randomMoneyTimer;

  @override
  void initState() {
    super.initState();

    initialBalance = ref.read(homeProvider.select((u) => u.balance));

    sprayTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }

      ref.read(sprayProvider.notifier).incrementDuration();
    });

    randomMoneyTimer = Timer.periodic(const Duration(milliseconds: 250), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }

      ref.read(sprayProvider.notifier).addMoney(Denomination.twoHundredNaira);
    });

    ref.listenManual(sprayProvider, (_, next) {
      total = 0;
      Map<Denomination, int> monies = ref.watch(
        sprayProvider.select((u) => u.monies),
      );
      for (Denomination key in monies.keys) {
        total += monies[key]! * key.value;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    sprayTimer?.cancel();
    randomMoneyTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Denomination current = ref.watch(sprayProvider.select((u) => u.current));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              "₦${formatCurrency(total)}",
              style: context.textTheme.displaySmall?.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.02,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Total Received",
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "Balance: ",
                children: [
                  TextSpan(
                    text: "₦${formatCurrency(total + initialBalance)}",
                    style: TextStyle(color: AppColors.brandPrimary),
                  ),
                ],
              ),
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                color: AppColors.surfaceBackgroundLighter,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "🎉",
                          style: context.textTheme.titleLarge?.copyWith(
                            fontSize: 48,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Receiving Money!",
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Watch it rain 💸",
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.brandDark,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: const Wallet(),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryButton(
                onPressed: () {
                  sprayTimer?.cancel();
                  randomMoneyTimer?.cancel();

                  ref.read(homeProvider.notifier).addBalance(total.toDouble());
                  context.router.replace(const SpraySessionCompleteRoute());
                },
                text: "End Session",
                backgroundColor: AppColors.error,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
