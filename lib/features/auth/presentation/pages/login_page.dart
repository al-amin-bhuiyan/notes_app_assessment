import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:notes_app_assessment/core/constants/route_paths.dart';
import 'package:notes_app_assessment/core/utils/app_fonts.dart';
import 'package:notes_app_assessment/core/utils/app_text_field.dart';
import 'package:notes_app_assessment/core/utils/validator.dart';
import 'package:notes_app_assessment/features/auth/presentation/controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                _buildHeader(),
                const SizedBox(height: 40),
                AppTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validator.validateEmail,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                Obx(
                  () => AppTextField(
                    controller: controller.passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    obscureText: !controller.isPasswordVisible.value,
                    validator: Validator.validatePassword,
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoginLoading.value
                        ? null
                        : () => controller.login(context),
                    child: controller.isLoginLoading.value
                        ? LoadingAnimationWidget.threeArchedCircle(
                            color: Colors.white,
                            size: 22,
                          )
                        : const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 24),
                _buildRegisterLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Log in.',
          style: AppFonts.headlineLarge.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 36,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please enter your details to sign in.',
          style: AppFonts.bodyMedium.copyWith(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      children: [
        Text("Don't have an account? ", style: AppFonts.bodyMedium),
        GestureDetector(
          onTap: () => context.go(RoutePaths.register),
          child: Text(
            'Sign up',
            style: AppFonts.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
