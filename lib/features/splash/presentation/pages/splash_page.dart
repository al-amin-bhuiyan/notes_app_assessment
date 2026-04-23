import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:notes_app_assessment/app/theme/app_colors.dart';
import 'package:notes_app_assessment/core/utils/app_fonts.dart';
import 'package:notes_app_assessment/features/splash/presentation/controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.edit_document,
              size: 80,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 24),
            Text(
              'Notes.',
              style: AppFonts.headlineLarge.copyWith(
                color: AppColors.primaryColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Capture your thoughts',
              style: AppFonts.bodyMedium.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.primaryColor,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}