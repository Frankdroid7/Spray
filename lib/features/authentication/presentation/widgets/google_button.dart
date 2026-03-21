import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/features/authentication/view_models/auth_provider.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

class GoogleButton extends ConsumerStatefulWidget {
  const GoogleButton({super.key});

  @override
  ConsumerState<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends ConsumerState<GoogleButton> {
  bool _loading = false;

  Future<void> _signIn() async {
    setState(() => _loading = true);
    try {
      final credential = await ref.read(authServiceProvider).signInWithGoogle();
      if (!mounted) return;
      if (credential != null) {
        context.router.replaceAll(const [HomeRoute()]);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: _signIn,
      active: !_loading,
      backgroundColor: AppColors.textPrimary,
      height: 56,
      child: _loading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.surfaceBackground,
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                SvgPicture.asset("assets/svgs/google.svg", width: 24),
                Text(
                  "Continue with Google",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.surfaceBackground,
                  ),
                ),
              ],
            ),
    );
  }
}
