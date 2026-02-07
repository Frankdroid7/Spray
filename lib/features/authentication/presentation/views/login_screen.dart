import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/widgets/primary_button.dart';
import 'package:spray/core/widgets/back_button.dart';
import 'package:spray/core/widgets/custom_textfield.dart';
import 'package:spray/features/authentication/presentation/widgets/apple_button.dart';
import 'package:spray/features/authentication/presentation/widgets/google_button.dart';
import 'package:spray/router/app_router.gr.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _goHome() {
    context.router.replaceAll(const [HomeRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(leading: const CustomBackButton()),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Continue with your account",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppColors.brandDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Login easily with Apple or Google",
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: emailController,
                    label: "Email Address",
                    hint: "e.g johndoe@example.com",
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: passwordController,
                    label: "Password",
                    hint: "e.g ********",
                    type: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Forgot password?",
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.surfaceDark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: AppColors.borderLight,
                        ),
                      ),
                      Text(
                        "OR",
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: AppColors.borderLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const GoogleButton(),
                  const SizedBox(height: 16),
                  const AppleButton(),
                  const SizedBox(height: 40),
                  PrimaryButton(onPressed: _goHome, text: "Log in"),
                  const SizedBox(height: 24),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        children: [
                          TextSpan(
                            text: "Create account",
                            style: TextStyle(
                              color: AppColors.brandDark,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.router.pop();
                              },
                          ),
                        ],
                      ),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
