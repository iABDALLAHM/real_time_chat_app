import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/features/home/presentation/function/user_item_button_status.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/send_friend_request_cubit/send_friend_request_cubit.dart';

class SendFriendRequestBlocBuilder extends StatelessWidget {
  const SendFriendRequestBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendFriendRequestCubit, UserRelationshipStatus>(
      builder: (context, state) {
        switch (state) {
          case UserRelationshipStatus.none:
            return userItemButtonStatus(
              onTap: () {
                context.read<SendFriendRequestCubit>().sendRequest(
                  friendRequestEntity: FriendRequestEntity(
                    id: "id",
                    senderId: "senderId",
                    receiverId: "receiverId",
                    createdAt: DateTime.now(),
                  ),
                );
              },
              relationshipStatus: UserRelationshipStatus.none,
            );
          case UserRelationshipStatus.friendRequestSent:
            return userItemButtonStatus(
              onTap: () {},
              relationshipStatus: UserRelationshipStatus.friendRequestSent,
            );
          case UserRelationshipStatus.friendRequestReceived:
            return userItemButtonStatus(
              onTap: () {},
              relationshipStatus: UserRelationshipStatus.friendRequestReceived,
            );
          case UserRelationshipStatus.friends:
            return userItemButtonStatus(
              onTap: () {},
              relationshipStatus: UserRelationshipStatus.friends,
            );
          case UserRelationshipStatus.blocked:
            return userItemButtonStatus(
              onTap: () {},
              relationshipStatus: UserRelationshipStatus.blocked,
            );
        }
      },
    );
  }
}
