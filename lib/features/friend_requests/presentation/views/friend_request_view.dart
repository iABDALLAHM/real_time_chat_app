import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/friend_request_view_body.dart';

class FriendRequestView extends StatelessWidget {
  const FriendRequestView({super.key});
  static const String routeName = "friendRequest";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FriendRequestViewBody(),
    );
  }
}