import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spray/core/constants/images.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/functions/currency.dart';
import 'package:spray/core/widgets/combobox.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/core/models/transaction.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/core/models/denomination.dart';
import 'package:spray/features/spray/data/spray_session_repository.dart';
import 'package:spray/features/spray/presentation/providers/spray_provider.dart';
import 'package:spray/features/spray/presentation/widgets/bill_stack.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class SprayerSessionPage extends ConsumerStatefulWidget {
  final String receiverId;

  const SprayerSessionPage({super.key, required this.receiverId});

  @override
  ConsumerState<SprayerSessionPage> createState() => _SprayerSessionPageState();
}

class _SprayerSessionPageState extends ConsumerState<SprayerSessionPage> {
  int total = 0, cap = 50_000;
  late double initialBalance;
  Timer? sprayTimer;
  StreamSubscription<bool>? _sessionEndSub;
  bool _sessionEnded = false;

  String? currentSpeed = "1.0x";
  final List<double> speeds = [0.5, 1.0, 1.5, 2.0];



  @override
  void initState() {
    super.initState();

    initialBalance = ref.read(homeProvider.select((async) => async.value?.balance ?? 0.0));

    final repo = ref.read(spraySessionRepositoryProvider);
    // _sessionEndSub = repo.listenForSessionEnd(widget.receiverId).listen((ended) {
    //   if (ended && mounted && !_sessionEnded) {
    //     _endSession();
    //   }
    // });

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

  void _endSession() {
    if (_sessionEnded) return;
    _sessionEnded = true;
    sprayTimer?.cancel();
    _sessionEndSub?.cancel();
    ref.read(homeProvider.notifier).addBalance(
      -total.toDouble(),
      type: TransactionType.debit,
      narration: 'Spray session',
    );
    context.router.replace(const SpraySessionCompleteRoute());
  }

  @override
  void dispose() {
    sprayTimer?.cancel();
    _sessionEndSub?.cancel();
    super.dispose();
  }

  int get remaining {
    int balanceLeft = (initialBalance - total).toInt();
    int capLeft = cap - total;
    return balanceLeft < capLeft ? balanceLeft : capLeft;
  }

  void spray() {
    if (remaining <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Insufficient balance to spray."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    Denomination current = ref.read(sprayProvider.select((u) => u.current));
    ref.read(sprayProvider.notifier).addMoney(current);
  }

  @override
  Widget build(BuildContext context) {
    Denomination current = ref.watch(sprayProvider.select((u) => u.current));
    bool capReached = remaining <= 0;

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
                  capReached ? "Cap reached!" : "Swipe up to spray",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: capReached ? AppColors.error : AppColors.textSecondary,
                    letterSpacing: 0,
                  ),
                ),
                if (!capReached)
                  SvgPicture.asset("assets/svgs/spray_swipe.svg", width: 20),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColors.surfaceBackgroundLighter,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                alignment: const Alignment(0, 0.6),
                child: BillStack(
                  denomination: current,
                  moneyImages: moneyImages,
                  onSpray: spray,
                  remaining: remaining,
                  spraySpeed: double.tryParse(
                        currentSpeed?.replaceAll('x', '') ?? '1.0',
                      ) ??
                      1.0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Denomination",
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 0,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ComboBox<int>(
                        value: current.value,
                        hint: "",
                        buttonWidth: 70,
                        buttonHeight: 35,
                        iconEnabledColor: AppColors.brandPrimary,
                        buttonColor: AppColors.surfaceBackgroundLighter,
                        buttonPadding: EdgeInsets.all(4),
                        dropdownWidth: 100,
                        dropdownItems: Denomination.values
                            .map((e) => e.value)
                            .toList(),
                        onChanged: (v) {
                          if (v == null) return;

                          Denomination d = Denomination.values.firstWhere(
                            (e) => e.value == v,
                          );
                          ref
                              .read(sprayProvider.notifier)
                              .setCurrentDenomination(d);
                        },
                      ),
                      const Spacer(),
                      Text(
                        "Spray Speed",
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 0,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ComboBox<String>(
                        value: currentSpeed,
                        hint: "",
                        buttonWidth: 70,
                        buttonHeight: 35,
                        iconEnabledColor: AppColors.brandPrimary,
                        buttonColor: AppColors.surfaceBackgroundLighter,
                        buttonPadding: EdgeInsets.all(4),
                        dropdownWidth: 100,
                        dropdownItems: speeds.map((e) => "${e}x").toList(),
                        onChanged: (v) {
                          currentSpeed = v;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    onPressed: _endSession,
                    text: "Stop Session",
                    backgroundColor: AppColors.error,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
