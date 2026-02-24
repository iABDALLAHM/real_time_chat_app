import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/functions/show_top_overlay_message.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/login_view.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_state.dart';

class SignOutViewBody extends StatelessWidget {
  const SignOutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocListener<SignOutCubit, SignOutStates>(
          listener: (context, state) {
            if (state is SuccessSignOutState) {
              Navigator.of(context).pushReplacementNamed(LoginView.routeName);
              showTopOverlayMessage(context, message: "Success SignOut");
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                child: Text("SignOut"),
                onPressed: () {
                  context.read<SignOutCubit>().signOut(
                    userId: getUserData().uId,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
