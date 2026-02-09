import 'package:flutter/material.dart';
// import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/users_item_list_view.dart';

class FindPeopleBody extends StatelessWidget {
  const FindPeopleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: SizedBox(), title: Text("Find People")),
      body: Column(
        children: [
          CustomSearchBar(hintText: "Search People"),
          Expanded(
            child: UsersItemListView(
              usersList: [
                // UserEntity(
                //   uId: "uId",
                //   email: "email",
                //   displayName: "DisplayName",
                //   lastSeen: DateTime.now(),
                //   createdAt: DateTime.now(),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
