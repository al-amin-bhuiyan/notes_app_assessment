import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastMessage {
  ToastMessage._();

  static void success(String message) {
    toastification.show(
      title: const Text('Success'),
      description: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.check_circle),
      showProgressBar: false,
    );
  }

  static void error(String message) {
    toastification.show(
      title: const Text('Error'),
      description: Text(message),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 4),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.error_outline),
      showProgressBar: false,
    );
  }

  static void info(String message) {
    toastification.show(
      title: const Text('Info'),
      description: Text(message),
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.info_outline),
      showProgressBar: false,
    );
  }
}