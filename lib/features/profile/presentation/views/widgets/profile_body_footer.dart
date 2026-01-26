import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/custom_divider.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/profile_badge.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/profile_body_item.dart';

class ProfileBodyFooter extends StatelessWidget {
  const ProfileBodyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              ProfileBodyItem(
                onPressed: () {},
                text: "Change Password",
                icon: Icon(Icons.security, color: AppTheme.primaryColor),
              ),
              CustomDivider(),
              ProfileBodyItem(
                onPressed: () {},
                text: "Delete Account",
                icon: Icon(Icons.delete_forever, color: AppTheme.errorColor),
              ),
              CustomDivider(),
              ProfileBodyItem(
                onPressed: () {
                  context.read<SignOutCubit>().signOut(
                    userId: getUserData().uId,
                  );
                },
                text: "Sign Out",
                icon: Icon(Icons.logout, color: AppTheme.errorColor),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        ProfileBadge(),
        const SizedBox(height: 20),
      ],
    );
  }
}
