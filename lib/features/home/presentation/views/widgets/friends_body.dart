import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/friend_request_view.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/empty_search_widget.dart';

class FriendsBody extends StatelessWidget {
  const FriendsBody({super.key});
  static const String routeName = "friends";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          CustomSearchBar(hintText: "Search Friends"),
          Expanded(child: EmptySearchWidget()),
        ],
      ),
    );
  }
}
