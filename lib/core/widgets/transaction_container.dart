import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/functions/currency.dart';
import 'package:spray/core/models/transaction.dart';
import 'package:spray/theme/app_colors.dart';

final DateFormat _formatter = DateFormat("HH:mm a");

class TransactionContainer extends StatelessWidget {
  final Transaction transaction;

  const TransactionContainer({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    IconData icon = switch (transaction.type) {
      TransactionType.credit => LucideIcons.arrowUp,
      TransactionType.fund => IconsaxPlusLinear.add,
      TransactionType.debit => LucideIcons.arrowDown,
    };

    Color color = switch (transaction.type) {
      TransactionType.credit => const Color(0xFF149D4F),
      TransactionType.fund => const Color(0xFF149D4F),
      TransactionType.debit => const Color(0xFFFA4242),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: const Color(0xFFEEF0F2))),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    transaction.narration,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.brandDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    _formatter.format(DateTime.parse(transaction.timestamp),),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF9D9FAF),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "${transaction.type == TransactionType.debit ? "-" : "+"}₦${formatCurrency(transaction.amount)}",
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.brandDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
