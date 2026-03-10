import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/constants/images.dart';
import 'package:spray/core/models/denomination.dart';
import 'package:spray/features/spray/presentation/providers/spray_provider.dart';

class _MoneyNote {
  final int id;
  final String image;
  final double horizontalOffset;
  final double rotation;
  bool landed;

  _MoneyNote({
    required this.id,
    required this.image,
    required this.horizontalOffset,
    required this.rotation,
    this.landed = false,
  });
}

class Wallet extends ConsumerStatefulWidget {
  const Wallet({super.key});

  @override
  ConsumerState<Wallet> createState() => _WalletState();
}

class _WalletState extends ConsumerState<Wallet> {
  final List<_MoneyNote> _notes = [];
  final Random _random = Random();
  int _noteCounter = 0;
  int _lastSwipes = 0;

  @override
  void initState() {
    super.initState();

    ref.listenManual(sprayProvider, (_, next) {
      if (next.swipes == _lastSwipes) return;
      _lastSwipes = next.swipes;

      Denomination? denomination = next.last;
      if (denomination == null) return;

      String? image = moneyImages[denomination];
      if (image == null) return;

      _addMoneyNote(image);
    });
  }

  void _addMoneyNote(String image) {
    int index = _noteCounter++;
    double offset = (_random.nextDouble() * 2 - 1) * 30.0;
    double rotation = (_random.nextDouble() * 2 - 1) * 0.1;

    _MoneyNote note = _MoneyNote(
      id: index,
      image: image,
      horizontalOffset: offset,
      rotation: rotation,
    );
    setState(() {
      _notes.add(note);
      if (_notes.length > 20) {
        _notes.removeRange(0, _notes.length - 20);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        note.landed = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/back_wallet.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          for (final note in _notes)
            AnimatedPositioned(
              key: ValueKey(note.id),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              bottom: note.landed ? 10 : screenHeight * 2,
              left: note.horizontalOffset,
              right: -note.horizontalOffset,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: note.landed ? 1.0 : 0.3,
                child: Transform.rotate(
                  angle: note.rotation,
                  child: Image.asset(
                    note.image,
                    fit: BoxFit.contain,
                    height: 250,
                    width: 100,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.05,
              child: Image.asset(
                "assets/images/front_wallet.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/images/wallet_text.png"),
          ),
        ],
      ),
    );
  }
}
