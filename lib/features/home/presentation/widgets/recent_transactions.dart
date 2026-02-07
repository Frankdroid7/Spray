import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/models/transaction.dart';
import 'package:spray/core/widgets/transaction_container.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/theme/app_colors.dart';

class RecentTransactions extends ConsumerWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Transaction> transactions = ref.watch(
      homeProvider.select((h) => h.transactions),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Activity",
              style: context.textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "See all",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.brandPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.brandPrimary,
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: ListView.separated(
            itemBuilder: (_, index) {
              Transaction transaction = transactions[index];
              return TransactionContainer(transaction: transaction);
            },
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemCount: transactions.length,
          ),
        ),
      ],
    );
  }
}
