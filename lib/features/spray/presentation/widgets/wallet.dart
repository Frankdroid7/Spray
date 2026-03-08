import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/features/spray/domain/entities/denomination.dart';
import 'package:spray/features/spray/presentation/providers/spray_provider.dart';

class _MoneyNote {
  final String image;
  final double horizontalOffset;
  final double rotation;
  bool landed;

  _MoneyNote({
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
  final Map<Denomination, String> moneyImages = {
    Denomination.fiveHundredNaira: "assets/images/500_naira.png",
  };

  final List<_MoneyNote> _notes = [];
  int _noteCounter = 0;

  @override
  void initState() {
    super.initState();
    ref.listenManual(sprayProvider, (_, next) {
      Denomination denomination = next.current;
      if (denomination == Denomination.nil) return;

      String? image = moneyImages[denomination];
      if (image == null) return;

      _addMoneyNote(image);
    });
  }

  void _addMoneyNote(String image) {
    int index = _noteCounter++;
    double offset = (index % 5 - 2) * 8.0;
    double rotation = (index % 3 - 1) * 0.05;

    _MoneyNote note = _MoneyNote(
      image: image,
      horizontalOffset: offset,
      rotation: rotation,
    );
    setState(() {
      _notes.add(note);
      if (_notes.length > 10) {
        _notes.removeRange(0, _notes.length - 10);
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
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: Stack(
        clipBehavior: Clip.hardEdge,
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
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              bottom: note.landed ? -200 : 200,
              left: note.horizontalOffset,
              right: -note.horizontalOffset,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: note.landed ? 1.0 : 0.3,
                child: Transform.rotate(
                  angle: note.rotation,
                  child: Transform.scale(
                    scale: 0.45,
                    child: Image.asset(note.image, fit: BoxFit.cover),
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
