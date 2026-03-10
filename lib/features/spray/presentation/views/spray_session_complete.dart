import 'package:auto_route/auto_route.dart';
import 'package:easy_conffeti/easy_conffeti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/functions/currency.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/core/models/denomination.dart';
import 'package:spray/features/spray/presentation/providers/spray_provider.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class SpraySessionCompletePage extends ConsumerStatefulWidget {
  const SpraySessionCompletePage({super.key});

  @override
  ConsumerState<SpraySessionCompletePage> createState() =>
      _SpraySessionCompletePageState();
}

class _SpraySessionCompletePageState
    extends ConsumerState<SpraySessionCompletePage> {
  int total = 0, duration = 0, swipes = 0;

  @override
  void initState() {
    super.initState();

    Map<Denomination, int> monies = ref.read(
      sprayProvider.select((u) => u.monies),
    );
    for (Denomination key in monies.keys) {
      total += monies[key]! * key.value;
    }

    duration = ref.read(sprayProvider.select((u) => u.duration));
    swipes = ref.read(sprayProvider.select((u) => u.swipes));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConfettiHelper.showConfettiDialog(
        context: context,
        confettiType: ConfettiType.achievement,
        confettiStyle: ConfettiStyle.ribbons,
        animationStyle: AnimationConfetti.falling,
        density: ConfettiDensity.high,
        durationInSeconds: 2,
        isClosedDialogAutomatic: true,
      );
    });
  }

  String _formatDuration(int totalSeconds) {
    int h = totalSeconds ~/ 3600;
    int m = (totalSeconds % 3600) ~/ 60;
    int s = totalSeconds % 60;

    if (h > 0) return '${h}h ${m}m ${s}s';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  void onPop() {
    ref.read(sprayProvider.notifier).reset();
    context.router.replaceAll(const [HomeRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandPrimary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: onPop,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.borderMedium.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      LucideIcons.x200,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Spray session Complete",
              style: context.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                letterSpacing: 0,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 460,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "🎉",
                          style: context.textTheme.titleLarge?.copyWith(
                            fontSize: 72,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Total Amount",
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                            letterSpacing: 0,
                          ),
                        ),
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
                        const SizedBox(height: 24),
                        Divider(
                          color: AppColors.borderHeavy.withValues(alpha: 0.3),
                          thickness: 1,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: _Stats(
                                name: "Duration",
                                value: _formatDuration(duration),
                              ),
                            ),
                            Expanded(
                              child: _Stats(name: "Swipes", value: "$swipes"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        PrimaryButton(
                          onPressed: onPop,
                          text: "Back to Home",
                          width: 180,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < 10; ++i)
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.brandPrimary,
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < 10; ++i)
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.brandPrimary,
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: -10,
                    top: 235,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.brandPrimary,
                    ),
                  ),
                  Positioned(
                    right: -10,
                    top: 235,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.brandPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  final String name;
  final String value;

  const _Stats({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          Text(name, style: context.textTheme.labelMedium),
          Text(
            value,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
