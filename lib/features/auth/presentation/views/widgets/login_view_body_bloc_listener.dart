import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/auth/presentation/function/show_top_overlay_message.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/login_cubit/login_state.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/profile_view.dart';

class LoginViewBodyBlocListener extends StatelessWidget {
  const LoginViewBodyBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is SuccessLoginState) {
          showTopOverlayMessage(context, message: "Success Login");
          Navigator.of(context).pushNamed(ProfileView.routeName);
        } else if (state is FailureLoginState) {
          showTopOverlayMessage(context, message: state.errMessage);
        }
      },
      child: child,
    );
  }
}
