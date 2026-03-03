import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/custom_divider.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/user_item.dart';

class UsersItemListView extends StatelessWidget {
  const UsersItemListView({super.key, required this.usersList});
  final List<UserEntity> usersList;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: usersList[index].uId == getUserData().uId
              ? SizedBox.shrink()
              : UserItem(userEntity: usersList[index]),
        );
      },
      separatorBuilder: (context, index) => CustomDivider(),
      itemCount: usersList.length,
    );
  }
}
