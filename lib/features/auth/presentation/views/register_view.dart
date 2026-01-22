import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const String routeName = "register";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterViewBody(),
    );
  }
}
