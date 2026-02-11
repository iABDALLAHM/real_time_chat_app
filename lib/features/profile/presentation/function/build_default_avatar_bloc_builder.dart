import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_stream_cubit.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_stream_state.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';

Widget buildDefaultAvatarBlocBuilder({required BuildContext context}) {
  return BlocBuilder<UserStreamCubit, UserStreamStates>(
    builder: (context, state) {
      if (state is SuccessUserStreamState) {
        return Text(
          state.userEntity.displayName[0].toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        );
      }
      return Text(
        getUserData().displayName[0].toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 32,
        ),
      );
    },
  );
}
