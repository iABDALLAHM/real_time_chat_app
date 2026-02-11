import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_stream_cubit.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_stream_state.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class PersonalUserInfo extends StatelessWidget {
  const PersonalUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<UserStreamCubit, UserStreamStates>(
          builder: (context, state) {
            if (state is SuccessUserStreamState) {
              return Text(
                state.userEntity.displayName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              );
            }
            return Text(
              getUserData().displayName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            );
          },
        ),
        const SizedBox(height: 4),
        Text(
          getUserData().email,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppTheme.textsecondaryColor),
        ),
      ],
    );
  }
}
