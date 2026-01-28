import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/change_password_view_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});
  static const String routeName = "ChangePassword";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Password")),
      body: SafeArea(child: ChangePasswordViewBody()),
    );
  }
}
