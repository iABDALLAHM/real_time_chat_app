import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/login_bloc_provider.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/login_view_body_bloc_listener.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String routeName = "login";
  @override
  Widget build(BuildContext context) {
    return LoginBlocProvider(
      child: Scaffold(
        body: SafeArea(
          child: LoginViewBodyBlocListener(child: LoginViewBody()),
        ),
      ),
    );
  }
}
