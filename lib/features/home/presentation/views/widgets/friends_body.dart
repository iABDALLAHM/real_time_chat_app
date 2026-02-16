import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/home/presentation/function/build_friends_body_app_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/friends_chat_list_view.dart';

class FriendsBody extends StatelessWidget {
  const FriendsBody({super.key});
  static const String routeName = "friends";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildFriendsBodyAppBar(context),
      body: Column(
        children: [
          CustomSearchBar(hintText: "Search Friends"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FriendsChatListView(friendsList: []),
            ),
          ),
          // EmptySearchWidget(),
        ],
      ),
    );
  }
}
