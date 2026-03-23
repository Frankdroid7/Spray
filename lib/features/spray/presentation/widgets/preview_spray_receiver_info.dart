import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/functions/focus.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/core/widgets/secondary_button.dart';
import 'package:spray/features/home/presentation/providers/home_provider.dart';
import 'package:spray/features/spray/data/spray_session_repository.dart';
import 'package:spray/features/spray/domain/entities/spray_receiver.dart';
import 'package:spray/features/spray/presentation/providers/search_receiver_provider.dart';
import 'package:spray/features/spray/presentation/widgets/custom_code_field.dart';
import 'package:spray/features/spray/presentation/widgets/spray_receiver_container.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

class PreviewSprayReceiverInfo extends ConsumerStatefulWidget {
  final SprayReceiver receiver;

  const PreviewSprayReceiverInfo({super.key, required this.receiver});

  @override
  ConsumerState<PreviewSprayReceiverInfo> createState() =>
      _PreviewSprayReceiverInfoState();
}

class _PreviewSprayReceiverInfoState
    extends ConsumerState<PreviewSprayReceiverInfo> {
  String digit = "";
  bool _loading = false;

  Future<void> navigateToQRPage() async {
    var result = await context.router.push(ScanQrRoute());
    if (result == null || !mounted) return;

    digit = result as String;
    setState(() {});
  }

  Future<void> _startSession() async {
    if (digit.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the 4-digit code")),
      );
      return;
    }

    setState(() => _loading = true);

    final repo = ref.read(spraySessionRepositoryProvider);
    final valid = await repo.validateAndStartSession(widget.receiver.id, digit);

    if (!mounted) return;
    setState(() => _loading = false);

    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid code. Ask the receiver to share their code."),
        ),
      );
      return;
    }

    final balance = ref.read(
      homeProvider.select((async) => async.value?.balance ?? 0.0),
    );
    if (balance < 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Insufficient balance. You need at least ₦200 to spray.",
          ),
        ),
      );
      return;
    }

    context.router.replace(const SprayerSessionRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SprayReceiverContainer(
          receiver: widget.receiver,
          selected: true,
          onSelect: () {
            unFocus();
            ref.read(searchReceiversProvider.notifier).selectReceiver(-1);
          },
        ),
        const SizedBox(height: 16),
        Text("Enter Receiver's Code", style: context.textTheme.bodySmall),
        const SizedBox(height: 12),
        CustomCodeField(
          fields: 4,
          onComplete: (code) {

            print('CODE -> $code');
            unFocus();
            setState(() => digit = code);
          },
        ),
        const SizedBox(height: 24),
        Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Divider(color: AppColors.borderLight)),
            Text(
              "OR",
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Expanded(child: Divider(color: AppColors.borderLight)),
          ],
        ),
        const SizedBox(height: 24),
        SecondaryButton(
          onPressed: navigateToQRPage,
          backgroundColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Text(
                "Scan QR Code",
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Icon(
                IconsaxPlusLinear.scan_barcode,
                color: Colors.black,
                size: 18,
              ),
            ],
          ),
        ),
        const Spacer(),
        PrimaryButton(
          onPressed: _startSession,
          active: !_loading,
          text: _loading ? "Verifying..." : "Start Spray Session",
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
