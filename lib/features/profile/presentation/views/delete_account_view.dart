import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/delete_account_bloc_provider.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/delete_account_view_body.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});
  static const String routeName = "deleteAccount";
  @override
  Widget build(BuildContext context) {
    return DeleteAccountViewBlocProvider(
      child: Scaffold(
        appBar: AppBar(title: Text("DeleteYourAccout")),
        body: DeleteAccountViewBody(),
      ),
    );
  }
}
