import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/features/home/presentation/widgets/fund_wallet_modal.dart';
import 'package:spray/features/home/presentation/widgets/withdraw_modal.dart';
import 'package:spray/theme/app_colors.dart';

class WalletContainer extends ConsumerStatefulWidget {
  const WalletContainer({super.key});

  @override
  ConsumerState<WalletContainer> createState() => _WalletContainerState();
}

class _WalletContainerState extends ConsumerState<WalletContainer> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    double amount = ref.watch(homeProvider.select((h) => h.balance));
    String formatted = NumberFormat("#,##0.00").format(amount);
    String whole = formatted.split('.')[0];
    String decimals = formatted.split('.')[1];

    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 4,
            children: [
              Text(
                "BALANCE",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary.withValues(alpha: 0.8),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => visible = !visible),
                child: AnimatedSwitcherPlus.revealCircular(
                  duration: const Duration(milliseconds: 300),
                  child: SvgPicture.asset(
                    "assets/svgs/eye_${visible ? "open" : "closed"}.svg",
                    width: 20,
                    key: ValueKey(visible),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: visible ? 2 : 8,
            children: [
              Text(
                "₦",
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              if (visible)
                Text.rich(
                  TextSpan(
                    text: "$whole.",
                    children: [
                      TextSpan(
                        text: decimals,
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: List.generate(
                    3,
                    (_) => CircleAvatar(
                      radius: 7,
                      backgroundColor: AppColors.surfaceDark,
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          Row(
            spacing: 40,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Action(
                title: "Fund wallet",
                background: AppColors.brandPrimary,
                text: Colors.white,
                icon: IconsaxPlusLinear.add,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const FundWalletModal(),
                  );
                },
              ),
              _Action(
                title: "Withdraw",
                background: AppColors.cardBackground,
                text: Colors.black,
                icon: IconsaxPlusLinear.arrow_up,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const WithdrawModal(),
                  );
                },
              ),
              _Action(
                title: "History",
                background: AppColors.cardBackground,
                text: Colors.black,
                icon: IconsaxPlusLinear.arrow_2,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final String title;
  final Color background, text;
  final IconData icon;
  final VoidCallback onTap;

  const _Action({
    super.key,
    required this.title,
    required this.background,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: text, size: 18),
          ),
        ),
        Text(
          title,
          style: context.textTheme.labelSmall?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
