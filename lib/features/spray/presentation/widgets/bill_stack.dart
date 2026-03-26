import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spray/core/models/denomination.dart';

class BillStack extends StatefulWidget {
  final Denomination denomination;
  final Map<Denomination, String> moneyImages;
  final VoidCallback onSpray;
  final int remaining;
  final double spraySpeed;

  const BillStack({
    super.key,
    required this.denomination,
    required this.moneyImages,
    required this.onSpray,
    required this.remaining,
    this.spraySpeed = 1.0,
  });

  @override
  State<BillStack> createState() => _BillStackState();
}

class _BillStackState extends State<BillStack>
    with SingleTickerProviderStateMixin {
  static const int maxStackSize = 8;
  static const double stackSpacing = 3.0;

  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  late Animation<double> _fadeAnimation;

  bool _isSwiping = false;
  Offset _dragDelta = Offset.zero;
  Offset _flyDirection = const Offset(0, -2.0);

  /// Returns the animation duration scaled by spray speed.
  /// Higher speed = shorter duration, lower speed = longer duration.
  int get _animationMs => (500 / widget.spraySpeed).round();

  /// Drag threshold scaled by speed — slower speed needs more drag.
  double get _dragThreshold => 8 / widget.spraySpeed;

  /// Velocity threshold scaled by speed.
  double get _velocityThreshold => -200 / widget.spraySpeed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationMs),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_curvedAnimation);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        setState(() {
          _isSwiping = false;
          _dragDelta = Offset.zero;
        });
        widget.onSpray();
      }
    });
  }

  @override
  void didUpdateWidget(covariant BillStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spraySpeed != widget.spraySpeed) {
      _controller.duration = Duration(milliseconds: _animationMs);
    }
  }

  @override
  void dispose() {
    _curvedAnimation.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_isSwiping) return;
    _dragDelta += details.delta;

    // Trigger spray once the user has dragged upward enough
    if (_dragDelta.dy < -_dragThreshold) {
      _triggerSpray();
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_isSwiping) return;
    final velocity = details.velocity.pixelsPerSecond;
    if (velocity.dy < _velocityThreshold) {
      // Use velocity direction for the fly angle
      final dx = velocity.dx.clamp(-600.0, 600.0) / 600.0;
      _dragDelta = Offset(dx * 20, -20);
      _triggerSpray();
    }
    _dragDelta = Offset.zero;
  }

  void _triggerSpray() {
    if (_isSwiping || _billCount == 0) return;

    // Compute fly direction from drag delta
    // Normalize horizontal: clamp to [-1.2, 1.2] range for the fractional offset
    final dx = (_dragDelta.dx / 30.0).clamp(-1.2, 1.2);

    setState(() {
      _isSwiping = true;
      _flyDirection = Offset(dx, -2.0);
    });
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
      onPanUpdate: disabled ? null : _onPanUpdate,
      onPanEnd: disabled ? null : _onPanEnd,
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
              AnimatedBuilder(
                animation: _curvedAnimation,
                builder: (context, child) {
                  final progress = _curvedAnimation.value;

                  // Fold effect: slight 3D perspective bend as the note flies
                  final foldAngle = progress * 0.3; // max ~17 degrees
                  final foldMatrix = Matrix4.identity()
                    ..setEntry(3, 2, 0.002) // perspective
                    ..rotateX(foldAngle);

                  return FractionalTranslation(
                    translation: Offset(
                      _flyDirection.dx * progress,
                      _flyDirection.dy * progress,
                    ),
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: foldMatrix,
                        child: Transform.translate(
                          offset: Offset(0, -staticCount * stackSpacing),
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
                child: Image.asset(image, fit: BoxFit.contain),
              ),
          ],
        ),
      ),
    );
  }
}
