// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:sample_app/features/common_widgets/app_button.dart';
import 'package:sample_app/features/common_widgets/app_textfields.dart';
import 'package:sample_app/features/login/widgets/gradient_background.dart';

import '../../core/theme/colors.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onSignUp;
  final VoidCallback? onForgotPassword;
  final void Function(String email, String password)? onSignIn;

  const LoginScreen({
    super.key,
    this.onSignUp,
    this.onForgotPassword,
    this.onSignIn,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 840),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 156,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'firstpass»',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          fontFamily: 'ProximaNova',
                        ),
                      ),
                      const SizedBox(height: 40),

                      AppTextField(
                        label: 'Mobile Number / Email ID',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 24),

                      AppTextField(
                        label: 'Password',
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        suffixIcon: GestureDetector(
                          onTap: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      AppButton(
                        size: AppButtonSize.large,
                        text: 'Sign In',
                        onPressed: () => widget.onSignIn?.call(
                          _emailController.text,
                          _passwordController.text,
                        ),
                      ),
                      const SizedBox(height: 36),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Don't have an account ? ",
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.darkBg,
                              fontFamily: 'ProximaNova',
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onSignUp,
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                                fontFamily: 'ProximaNova',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      const Divider(color: AppColors.divider, height: 1),
                      const SizedBox(height: 22),

                      GestureDetector(
                        onTap: widget.onForgotPassword,
                        child: Opacity(
                          opacity: 0.9,
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.primary,
                              fontFamily: 'ProximaNova',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
