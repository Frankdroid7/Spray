import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/theme/app_colors.dart';

class PrimaryButton extends StatefulWidget {
  final bool active;
  final String text;
  final VoidCallback onPressed;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? backgroundColor, textColor;

  const PrimaryButton({
    super.key,
    this.text = "",
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    required this.onPressed,
    this.child,
    this.active = true,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> transition;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    transition = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    animate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PrimaryButton oldWidget) {
    animate();
    super.didUpdateWidget(oldWidget);
  }

  void animate() {
    if (widget.active) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.active,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, child) {
          return FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor:
                  widget.backgroundColor ??
                  Color.lerp(
                    AppColors.brandPrimary.withValues(alpha: 0.75),
                    AppColors.brandPrimary,
                    transition.value,
                  ),
              fixedSize: Size(
                widget.width ?? double.infinity,
                widget.height ?? 48,
              ),
              minimumSize: Size(
                widget.width ?? double.infinity,
                widget.height ?? 48,
              ),
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: widget.onPressed,
            child: child,
          );
        },
        child:
            widget.child ??
            Text(widget.text, style: context.textTheme.labelSmall?.copyWith(color: widget.textColor ?? AppColors.textOnPrimary))
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 300),
                  delay: const Duration(milliseconds: 50),
                )
                .moveY(
                  duration: const Duration(milliseconds: 300),
                  begin: -10.0,
                  end: 0.0,
                ),
      ),
    );
  }
}

class SecondaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? backgroundColor, textColor, borderColor;

  const SecondaryButton({
    super.key,
    this.text = "",
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    required this.onPressed,
    this.child,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        fixedSize: Size(widget.width ?? double.infinity, widget.height ?? 48),
        minimumSize: Size(widget.width ?? double.infinity, widget.height ?? 48),
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(color: widget.borderColor ?? AppColors.borderLight),
      ),
      onPressed: widget.onPressed,
      child:
          widget.child ??
          Text(
                widget.text,
                style: context.textTheme.labelSmall?.copyWith(
                  color: widget.textColor ?? AppColors.textPrimary,
                ),
              )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 300),
                delay: const Duration(milliseconds: 50),
              )
              .moveY(
                duration: const Duration(milliseconds: 300),
                begin: -10.0,
                end: 0.0,
              ),
    );
  }
}
