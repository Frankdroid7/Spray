import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as bg;
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/features/home/presentation/widgets/amount_container.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              position: bg.BadgePosition.topEnd(
                top: -4,
                end: -6,
              ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const AmountContainer(),
          ],
        ),
      ),
    );
  }
}
