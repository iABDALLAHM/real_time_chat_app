import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/forget_password_view_body.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/reset_password_bloc_provider.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  static const String routeName = "ForgetPassword";
  @override
  Widget build(BuildContext context) {
    return ResetPasswordBlocProvider(
      child: Scaffold(body: SafeArea(child: ForgetPasswordViewBody())),
    );
  }
}
