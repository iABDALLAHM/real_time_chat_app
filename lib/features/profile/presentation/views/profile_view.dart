import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/profile_multi_bloc_provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const String routeName = "profile";
  @override
  Widget build(BuildContext context) {
    return ProfileMultiBlocProvider(
      child: Scaffold(
        appBar: buildProfileViewAppBar(context),
        body: ProfileViewBody(),
      ),
    );
  }

  AppBar buildProfileViewAppBar(BuildContext context) {
    return AppBar(
      title: Text("Profile"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text("Edit", style: TextStyle(color: AppTheme.primaryColor)),
        ),
      ],
    );
  }
}

