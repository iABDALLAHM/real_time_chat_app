import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/functions/show_top_overlay_message.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/login_view.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/delete_account_cubit/delete_account_state.dart';

class DeleteAccountViewBody extends StatelessWidget {
  const DeleteAccountViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocListener<DeleteAccountCubit, DeleteAccountStates>(
          listener: (context, state) {
            if (state is SuccessDeleteAccountState) {
              Navigator.of(context).pushReplacementNamed(LoginView.routeName);
              showTopOverlayMessage(context, message: "Success delete Account");
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                child: Text("DeleteYourAccount"),
                onPressed: () {
                  context.read<DeleteAccountCubit>().deleteAccount(
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
