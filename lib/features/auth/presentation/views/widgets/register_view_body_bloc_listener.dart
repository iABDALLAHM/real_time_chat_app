import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/auth/presentation/function/show_top_overlay_message.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/register_cubit/cubit/register_cubit.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/register_cubit/cubit/register_state.dart';

class RegisterViewBodyBlocListener extends StatelessWidget {
  const RegisterViewBodyBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is SuccessRegisterState) {
          showTopOverlayMessage(context, message: "success create account");
          Navigator.pop(context);
        } else if (state is FailureRegisterState) {
          showTopOverlayMessage(context, message: state.errMessage);
        }
      },
      child: child,
    );
  }
}
