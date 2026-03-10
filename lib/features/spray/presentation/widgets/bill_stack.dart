import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spray/core/models/denomination.dart';

class BillStack extends StatefulWidget {
  final Denomination denomination;
  final Map<Denomination, String> moneyImages;
  final VoidCallback onSpray;
  final int remaining;

  const BillStack({
    super.key,
    required this.denomination,
    required this.moneyImages,
    required this.onSpray,
    required this.remaining,
  });

  @override
  State<BillStack> createState() => _BillStackState();
}

class _BillStackState extends State<BillStack>
    with SingleTickerProviderStateMixin {
  static const int maxStackSize = 8;
  static const double stackSpacing = 3.0;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _isSwiping = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -2.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        setState(() => _isSwiping = false);
        widget.onSpray();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_isSwiping) return;
    // Detect upward swipe
    if (details.primaryDelta != null && details.primaryDelta! < -8) {
      _triggerSpray();
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_isSwiping) return;
    if (details.primaryVelocity != null && details.primaryVelocity! < -200) {
      _triggerSpray();
    }
  }

  void _triggerSpray() {
    if (_isSwiping || _billCount == 0) return;
    setState(() => _isSwiping = true);
    _controller.forward();
  }

  int get _billCount {
    if (widget.remaining <= 0) return 0;
    int bills = widget.remaining ~/ widget.denomination.value;
    return min(bills, maxStackSize);
  }

  @override
  Widget build(BuildContext context) {
    String? image = widget.moneyImages[widget.denomination];
    if (image == null) {
      return const Center(child: Text("No bill image available"));
    }

    int count = _billCount;
    bool disabled = count == 0;
    int staticCount = max(count - 1, 0);

    return GestureDetector(
      onVerticalDragUpdate: disabled ? null : _onVerticalDragUpdate,
      onVerticalDragEnd: disabled ? null : _onVerticalDragEnd,
      child: Opacity(
        opacity: disabled ? 0.4 : 1.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Bottom bills in the stack (static)
            for (int i = 0; i < staticCount; i++)
              Transform.translate(
                offset: Offset(0, -i * stackSpacing),
                child: Transform.rotate(
                  angle: (i % 3 - 1) * 0.02,
                  child: Image.asset(image, fit: BoxFit.contain),
                ),
              ),
            // Top bill (animated on swipe)
            if (count > 0)
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Transform.translate(
                    offset: Offset(0, -staticCount * stackSpacing),
                    child: Image.asset(image, fit: BoxFit.contain),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
