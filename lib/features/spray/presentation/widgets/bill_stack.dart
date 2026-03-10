import 'package:flutter/material.dart';
import 'package:spray/core/models/denomination.dart';

class BillStack extends StatefulWidget {
  final Denomination denomination;
  final Map<Denomination, String> moneyImages;
  final VoidCallback onSpray;

  const BillStack({
    super.key,
    required this.denomination,
    required this.moneyImages,
    required this.onSpray,
  });

  @override
  State<BillStack> createState() => _BillStackState();
}

class _BillStackState extends State<BillStack>
    with SingleTickerProviderStateMixin {
  static const int stackSize = 8;
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
    if (_isSwiping) return;
    setState(() => _isSwiping = true);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    String? image = widget.moneyImages[widget.denomination];
    if (image == null) {
      return const Center(child: Text("No bill image available"));
    }

    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Bottom bills in the stack (static)
          for (int i = 0; i < stackSize; i++)
            Transform.translate(
              offset: Offset(0, -i * stackSpacing),
              child: Transform.rotate(
                angle: (i % 3 - 1) * 0.02,
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          // Top bill (animated on swipe)
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Transform.translate(
                offset: const Offset(0, -stackSize * stackSpacing),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
