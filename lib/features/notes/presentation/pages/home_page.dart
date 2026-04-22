import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/constants/route_paths.dart';
import 'package:notes_app/core/utils/app_fonts.dart';
import 'package:notes_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:notes_app/features/notes/domain/entities/note_entity.dart';
import 'package:notes_app/features/notes/presentation/controllers/notes_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notesController = Get.find<NotesController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'Logout',
            onPressed: () => _showLogoutDialog(context, authController),
          ),
        ],
      ),
      body: Obx(() => _buildBody(notesController)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RoutePaths.addNote),
        icon: Icon(Icons.add, size: 24.w),
        label: Text('Add', style: TextStyle(fontSize: 16.sp)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }

  Widget _buildBody(NotesController controller) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.hasError.value) {
      return _buildErrorState(controller.errorMessage.value);
    }

    if (controller.notes.isEmpty) {
      return _buildEmptyState();
    }

    return _buildNotesList(controller.notes);
  }

  Widget _buildNotesList(List<NoteEntity> notes) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return _NoteCard(note: notes[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_outlined,
            size: 80.w,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16.h),
          Text(
            'Nothing here.',
            style: AppFonts.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Click the + button to create a note',
            style: AppFonts.bodyMedium.copyWith(
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops.',
              style: AppFonts.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: AppFonts.bodyMedium.copyWith(
                color: Colors.black54,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              authController.logout(context);
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final NoteEntity note;

  const _NoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title.isNotEmpty ? note.title : 'Untitled',
              style: AppFonts.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),
            Text(
              note.description,
              style: AppFonts.bodyMedium.copyWith(
                color: Colors.black87,
                height: 1.4,
                fontSize: 14.sp,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16.h),
            Text(
              DateFormat('MMM d, yyyy').format(note.createdAt),
              style: AppFonts.bodySmall.copyWith(
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}