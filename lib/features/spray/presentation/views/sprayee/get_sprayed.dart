import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/widgets/back_button.dart';
import 'package:spray/core/widgets/loading_dialog.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/features/spray/data/spray_session_repository.dart';
import 'package:spray/features/spray/presentation/widgets/spray_code_timer.dart';
import 'package:spray/features/spray/presentation/widgets/spray_info.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class GetSprayedPage extends ConsumerStatefulWidget {
  const GetSprayedPage({super.key});

  @override
  ConsumerState<GetSprayedPage> createState() => _GetSprayedPageState();
}

class _GetSprayedPageState extends ConsumerState<GetSprayedPage> {
  late final String _code;
  StreamSubscription<bool>? _sessionSub;
  bool _waitingForSprayer = false;

  @override
  void initState() {
    super.initState();
    _code = (1000 + Random().nextInt(9000)).toString();
    _saveCodeAndListen();
  }

  Future<void> _saveCodeAndListen() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final repo = ref.read(spraySessionRepositoryProvider);
    await repo.saveSprayCode(uid, _code);

    _sessionSub = repo.listenForSessionStart(uid).listen((active) {
      if (active && mounted) {
        _onSessionStarted();
      }
    });
  }

  void _onSessionStarted() {
    if (_waitingForSprayer && Navigator.of(context).canPop()) {
      context.router.pop(); // dismiss loading dialog
    }
    context.router.replace(ReceivingSprayRoute());
  }

  Future<void> showLoadingDialog() async {
    setState(() => _waitingForSprayer = true);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(message: "Waiting for sprayer"),
    );
  }

  @override
  void dispose() {
    _sessionSub?.cancel();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      ref.read(spraySessionRepositoryProvider).clearSpraySession(uid);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Get Sprayed',
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.brandDark,
          ),
        ),
        leading: const CustomBackButton(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SprayInfo(),
            const SizedBox(height: 24),
            SprayCodeTimer(code: _code),
            const Spacer(),
            PrimaryButton(
              onPressed: showLoadingDialog,
              text: "Wait for Sprayer",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
