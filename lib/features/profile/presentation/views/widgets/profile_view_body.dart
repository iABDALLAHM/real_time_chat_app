import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/custom_profile_image.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/online_or_offline_status.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/profile_body_footer.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/user_joined_date.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomProfileImage(),
            const SizedBox(height: 16),
            Text(
              getUserData().displayName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              getUserData().email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textsecondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            OnlineOrOfflineStatus(),
            const SizedBox(height: 8),
            UserJoinedDate(),
            const SizedBox(height: 32),

            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Information",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      labelText: "Display Name",
                      hintText: getUserData().displayName,
                      onSaved: (value) {},
                      prefixIcon: Icon(Icons.person_outlined),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      helperText: "Email can't be changed",
                      labelText: "Email",
                      hintText: getUserData().email,
                      onSaved: (value) {},
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            ProfileBodyFooter(),
          ],
        ),
      ),
    );
  }
}
