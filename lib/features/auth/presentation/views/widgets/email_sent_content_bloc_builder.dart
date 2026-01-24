import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/reset_password_cubit/reset_password_states.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/email_sent_content.dart';

class EmailSentContentBlocBuilder extends StatelessWidget {
  const EmailSentContentBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordStates>(
      builder: (context, state) {
        if (state is SuccessResetPasswordState) {
          return EmailSentContent();
        } else {
          return SizedBox();
        }
      },
    );
  }
}
