import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/functions/currency.dart';
import 'package:spray/core/models/denomination.dart';
import 'package:spray/core/models/transaction.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/features/authentication/view_models/auth_provider.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/features/spray/data/spray_session_repository.dart';
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
  double _runningTotal = 0.0;
  late double initialBalance;
  Timer? sprayTimer;
  StreamSubscription<Map<String, dynamic>?>? _spraySub;
  StreamSubscription<bool>? _sessionEndSub;
  bool _sessionEnded = false;
  bool _sessionStartConfirmed = false;

  @override
  void initState() {
    super.initState();

    initialBalance = ref.read(homeProvider.select((async) => async.value?.balance ?? 0.0));

    sprayTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      ref.read(sprayProvider.notifier).incrementDuration();
    });

    final uid = ref.read(authStateProvider).value?.uid;
    if (uid != null) {
      final repo = ref.read(spraySessionRepositoryProvider);

      _spraySub = repo.listenToSprayUpdates(uid).listen((data) {
        final amount = (data?['currentSprayAmount'] as num?)?.toDouble() ?? 0.0;
        final denomValue = data?['lastDenominationValue'] as int?;

        if (amount > _runningTotal && denomValue != null) {
          final denomination = Denomination.values.firstWhere(
            (d) => d.value == denomValue,
            orElse: () => Denomination.twoHundredNaira,
          );
          ref.read(sprayProvider.notifier).addMoney(denomination);
        }

        if (mounted) setState(() => _runningTotal = amount);
      });

      _sessionEndSub = repo.listenForSessionEnd(uid).listen((ended) {
        if (!ended) {
          _sessionStartConfirmed = true;
          return;
        }
        if (_sessionStartConfirmed && mounted && !_sessionEnded) _onSessionEnd();
      });
    }
  }

  void _onSessionEnd() {
    if (_sessionEnded) return;
    _sessionEnded = true;
    _cleanup();
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid != null) {
      ref.read(spraySessionRepositoryProvider).clearSpraySession(uid);
    }
    ref.read(homeProvider.notifier).addBalance(
      _runningTotal,
      type: TransactionType.credit,
      narration: 'Spray session',
    );
    context.router.replace(const SpraySessionCompleteRoute());
  }

  void _cleanup() {
    sprayTimer?.cancel();
    _spraySub?.cancel();
    _sessionEndSub?.cancel();
  }

  @override
  void dispose() {
    _cleanup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              "₦${formatCurrency(_runningTotal.toInt())}",
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
                    text: "₦${formatCurrency(_runningTotal + initialBalance)}",
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
                  if (_sessionEnded) return;
                  _sessionEnded = true;
                  _cleanup();
                  final uid = ref.read(authStateProvider).value?.uid;
                  if (uid != null) {
                    ref.read(spraySessionRepositoryProvider).clearSpraySession(uid);
                  }
                  ref.read(homeProvider.notifier).addBalance(
                    _runningTotal,
                    type: TransactionType.credit,
                    narration: 'Spray session',
                  );
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
