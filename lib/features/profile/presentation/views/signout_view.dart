import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/sign_out_view_bloc_provider.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/signout_view_body.dart';

class SignoutView extends StatelessWidget {
  const SignoutView({super.key});
  static const routeName = "SignOut";
  @override
  Widget build(BuildContext context) {
    return SignOutViewBlocProvider(
      child: Scaffold(
        appBar: AppBar(title: Text("SignOut")),
        body: SignOutViewBody(),
      ),
    );
  }
}
