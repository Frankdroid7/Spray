import 'package:flutter/material.dart';
import 'package:spray/features/spray/domain/entities/denomination.dart';

class Wallet extends StatefulWidget {

  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final Map<Denomination, String> moneyImages = {
    Denomination.fiveHundredNaira: "assets/images/500_naira.png",
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: Stack(
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
          // Add the money here using AnimatedPositioned
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
