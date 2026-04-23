import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_text_field.dart';
import '../../../../core/utils/validator.dart';
import '../controllers/notes_controller.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.addNoteFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Write.',
                  style: AppFonts.headlineLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 36,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'What\'s on your mind?',
                  style: AppFonts.bodyMedium.copyWith(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: controller.titleController,
                  label: 'Title',
                  hint: 'Enter note title',
                  validator: Validator.validateTitle,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: controller.descriptionController,
                  label: 'Description',
                  hint: 'Write your note here...',
                  validator: Validator.validateDescription,
                  maxLines: 8,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 32),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : () => controller.addNote(context),
                    child: controller.isSaving.value
                        ? LoadingAnimationWidget.threeArchedCircle(
                            color: Colors.white,
                            size: 22,
                          )
                        : const Text('Save Note'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
