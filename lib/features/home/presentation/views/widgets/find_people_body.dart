import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/custom_divider.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/user_list_item.dart';

class FindPeopleBody extends StatelessWidget {
  const FindPeopleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: SizedBox(), title: Text("Find People")),
      body: Column(
        children: [
          CustomSearchBar(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: UsersListItem(
                    onTap: () {},
                    userEntity: UserEntity(
                      uId: "uId",
                      email: "email",
                      displayName: "DisplayName",
                      lastSeen: DateTime.now(),
                      createdAt: DateTime.now(),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => CustomDivider(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
