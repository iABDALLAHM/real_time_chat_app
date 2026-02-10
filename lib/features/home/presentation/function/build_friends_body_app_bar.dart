import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/friend_request_view.dart';

AppBar buildFriendsBodyAppBar(BuildContext context) {
  return AppBar(
    leading: SizedBox(),
    title: Text("Friends"),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(FriendRequestView.routeName);
        },
        icon: Icon(Icons.person_add_alt_1),
      ),
    ],
  );
}
