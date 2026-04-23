import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:notes_app_assessment/core/constants/route_paths.dart';
import 'package:notes_app_assessment/core/utils/app_fonts.dart';
import 'package:notes_app_assessment/core/utils/app_text_field.dart';
import 'package:notes_app_assessment/core/utils/validator.dart';
import 'package:notes_app_assessment/features/auth/presentation/controllers/auth_controller.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                _buildHeader(),
                const SizedBox(height: 40),
                AppTextField(
                  controller: controller.nameController,
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  validator: Validator.validateName,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: controller.regEmailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validator.validateEmail,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                Obx(
                  () => AppTextField(
                    controller: controller.regPasswordController,
                    label: 'Password',
                    hint: 'Create a password',
                    obscureText: !controller.isRegPasswordVisible.value,
                    validator: Validator.validatePassword,
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isRegPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: controller.toggleRegPasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isRegisterLoading.value
                        ? null
                        : () => controller.register(context),
                    child: controller.isRegisterLoading.value
                        ? LoadingAnimationWidget.threeArchedCircle(
                            color: Colors.white,
                            size: 22,
                          )
                        : const Text('Create Account'),
                  ),
                ),
                const SizedBox(height: 24),
                _buildLoginLink(context),
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
          'Sign up.',
          style: AppFonts.headlineLarge.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 36,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Create an account to get started.',
          style: AppFonts.bodyMedium.copyWith(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      children: [
        Text('Already have an account? ', style: AppFonts.bodyMedium),
        GestureDetector(
          onTap: () => context.go(RoutePaths.login),
          child: Text(
            'Log in',
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
