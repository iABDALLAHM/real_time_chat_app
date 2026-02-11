import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/profile/controllers/profile_controller.dart';

AppBar buildProfileBodyAppBar(BuildContext context) {
  final profileController = context.watch<ProfileController>();
  return AppBar(
    title: Text("Profile"),
    leading: SizedBox(),
    actions: [
      TextButton(
        onPressed: () {
          profileController.toggleEdit();
        },
        child: Text(
          profileController.isEditing ? 'Cancel' : 'Edit',
          style: TextStyle(
            color: profileController.isEditing
                ? AppTheme.errorColor
                : AppTheme.primaryColor,
          ),
        ),
      ),
    ],
  );
}
