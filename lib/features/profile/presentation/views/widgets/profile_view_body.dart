import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primaryColor,
                  child: getUserData().photoUrl == null
                      ? ClipOval(child: SizedBox(width: 120, height: 120))
                      : buildDefaultAvatar(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildDefaultAvatar() {
  return Text(
    getUserData().displayName[0].toUpperCase(),
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 32,
    ),
  );
}
