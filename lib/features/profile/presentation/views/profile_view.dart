import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat_app/features/profile/controllers/profile_controller.dart';
import 'package:real_time_chat_app/features/profile/presentation/function/build_profile_body_app_bar.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/profile_multi_bloc_provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const String routeName = "profile";
  @override
  Widget build(BuildContext context) {
    return ProfileMultiBlocProvider(
      child: ChangeNotifierProvider(
        create: (context) => ProfileController(),
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: buildProfileBodyAppBar(context),
              body: ProfileViewBody(),
            );
          },
        ),
      ),
    );
  }
}
