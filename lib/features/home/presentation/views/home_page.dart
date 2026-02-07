import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as bg;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/features/home/presentation/widgets/wallet_container.dart';
import 'package:spray/features/home/presentation/widgets/core_actions.dart';
import 'package:spray/features/home/presentation/widgets/recent_transactions.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).addDummyTransactions();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi, Freeborn',
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 20,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: bg.Badge(
              showBadge: true,
              position: bg.BadgePosition.topEnd(top: -4, end: -6),
              badgeStyle: bg.BadgeStyle(badgeColor: AppColors.error),
              badgeContent: Text(
                "2",
                style: context.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Icon(IconsaxPlusLinear.notification_bing),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletContainer(),
              SizedBox(height: 24),
              CoreActions(),
              SizedBox(height: 24),
              RecentTransactions(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
