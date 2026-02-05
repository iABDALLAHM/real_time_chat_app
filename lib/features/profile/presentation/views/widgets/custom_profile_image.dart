import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/profile/controllers/profile_controller.dart';
import 'package:real_time_chat_app/features/profile/presentation/function/build_default_avatar.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircleAvatar(
            backgroundColor: AppTheme.primaryColor,
            child: getUserData().photoUrl == null
                // if i have an image !!!
                ? ClipOval(
                    child: Image.asset(
                      "",
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return buildDefaultAvatar();
                      },
                    ),
                  )
                : buildDefaultAvatar(),
          ),
        ),

        controller.isEditing
            ? Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.camera_alt, size: 20, color: Colors.white),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
