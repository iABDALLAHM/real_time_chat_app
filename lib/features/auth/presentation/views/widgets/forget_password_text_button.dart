import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/forget_password_view.dart';

class ForgetPasswordTextButton extends StatelessWidget {
  const ForgetPasswordTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(ForgetPasswordView.routeName);
      },
      child: Text("Forgot Password?"),
    );
  }
}
