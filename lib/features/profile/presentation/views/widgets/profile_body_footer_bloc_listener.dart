import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/auth/presentation/function/show_top_overlay_message.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/login_view.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/delete_account_cubit/delete_account_state.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_state.dart';

class ProfileBodyFooterBlocListener extends StatelessWidget {
  const ProfileBodyFooterBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignOutCubit, SignOutStates>(
          listener: (context, state) {
            if (state is SuccessSignOutState) {
              Navigator.of(context).pushReplacementNamed(LoginView.routeName);
              showTopOverlayMessage(context, message: "Success SignOut");
            }
          },
        ),
        BlocListener<DeleteAccountCubit, DeleteAccountStates>(
          listener: (context, state) {
            if (state is SuccessDeleteAccountState) {
              Navigator.of(context).pushReplacementNamed(LoginView.routeName);
              showTopOverlayMessage(context, message: "Success delete Account");
            }
          },
        ),
      ],
      child: child,
    );
  }
}
