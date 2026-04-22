import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/constants/route_paths.dart';
import 'package:notes_app/core/errors/app_exception.dart';
import 'package:notes_app/core/utils/toast_message.dart';
import 'package:notes_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:notes_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:notes_app/features/auth/domain/usecases/register_usecase.dart';

class AuthController extends GetxController {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final AuthRepositoryImpl _authRepository;

  AuthController({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required AuthRepositoryImpl authRepositoryImpl,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _authRepository = authRepositoryImpl;

  // Form keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Text controllers - Login
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Text controllers - Register
  final nameController = TextEditingController();
  final regEmailController = TextEditingController();
  final regPasswordController = TextEditingController();

  // Observable states
  final RxBool isLoginLoading = false.obs;
  final RxBool isRegisterLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isRegPasswordVisible = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleRegPasswordVisibility() => isRegPasswordVisible.toggle();

  Future<void> login(BuildContext context) async {
    if (!loginFormKey.currentState!.validate()) return;

    isLoginLoading.value = true;
    try {
      await _loginUseCase.execute(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      if (context.mounted) context.go(RoutePaths.home);
    } on AppException catch (e) {
      ToastMessage.error(e.message);
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future<void> register(BuildContext context) async {
    if (!registerFormKey.currentState!.validate()) return;

    isRegisterLoading.value = true;
    try {
      await _registerUseCase.execute(
        name: nameController.text.trim(),
        email: regEmailController.text.trim(),
        password: regPasswordController.text,
      );
      ToastMessage.success('Account created successfully!');
      if (context.mounted) context.go(RoutePaths.home);
    } on AppException catch (e) {
      ToastMessage.error(e.message);
    } finally {
      isRegisterLoading.value = false;
    }
  }

  Future<void> logout(BuildContext context) async {
    await _authRepository.logout();
    
    // Clear in-memory controllers and bindings so user-specific data is flushed
    Get.deleteAll(force: true);

    if (context.mounted) context.go(RoutePaths.login);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    regEmailController.dispose();
    regPasswordController.dispose();
    super.onClose();
  }
}