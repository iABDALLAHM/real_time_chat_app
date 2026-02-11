import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/show_top_overlay_message.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/login_view.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_password_cubit/update_password_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_password_cubit/update_password_state.dart';

class UpdatePasswordBlocListener extends StatelessWidget {
  const UpdatePasswordBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePasswordCubit, UpdatePasswordStates>(
      listener: (context, state) {
        if (state is SuccessUpdatePasswordState) {
          Navigator.of(context).pushReplacementNamed(LoginView.routeName);
          showTopOverlayMessage(context, message: " Success update password ");
        }
      },
      child: child,
    );
  }
}
