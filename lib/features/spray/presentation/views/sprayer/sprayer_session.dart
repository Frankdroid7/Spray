import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/functions/currency.dart';
import 'package:spray/core/widgets/combobox.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/features/spray/domain/entities/denomination.dart';
import 'package:spray/features/spray/presentation/providers/spray_provider.dart';
import 'package:spray/features/spray/presentation/widgets/wallet.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class SprayerSessionPage extends ConsumerStatefulWidget {
  const SprayerSessionPage({super.key});

  @override
  ConsumerState<SprayerSessionPage> createState() => _SprayerSessionPageState();
}

class _SprayerSessionPageState extends ConsumerState<SprayerSessionPage> {
  int total = 0, cap = 50_000;
  late double initialBalance;
  Timer? sprayTimer;

  double? currentSpeed;
  final List<double> speeds = [0.5, 1.0, 1.5, 2.0];

  final Map<Denomination, String> moneyImages = {
    Denomination.fiveHundredNaira: "assets/images/500_naira.png",
  };

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
    super.dispose();
  }

  void spray() {
    Denomination current = ref.read(sprayProvider.select((u) => u.current));
    ref.read(sprayProvider.notifier).addMoney(current);
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
              "Total Sprayed",
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Balance: ",
                    children: [
                      TextSpan(
                        text: "₦${formatCurrency(initialBalance - total)}",
                        style: TextStyle(color: AppColors.brandPrimary),
                      ),
                    ],
                  ),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "Cap: ",
                    children: [
                      TextSpan(
                        text: "₦${formatCurrency(cap)}",
                        style: TextStyle(color: AppColors.capYellow),
                      ),
                    ],
                  ),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Text(
                  "Swipe up to spray",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0,
                  ),
                ),
                SvgPicture.asset("assets/svgs/spray_swipe.svg", width: 20),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                color: AppColors.surfaceBackgroundLighter,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: null,  // Add stacks of bills here based on the current denomination
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ComboBox<Denomination>(
                  value: current,
                  hint: "",
                  dropdownItems: Denomination.values,
                  onChanged: (v) {
                    if (v == null) return;
                    ref.read(sprayProvider.notifier).setCurrentDenomination(v);
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryButton(
                onPressed: () {
                  sprayTimer?.cancel();
                  ref.read(homeProvider.notifier).addBalance(-total.toDouble());
                  context.router.replace(const SpraySessionCompleteRoute());
                },
                text: "Stop Session",
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
