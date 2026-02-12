import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/functions/show_top_overlay_message.dart';
import 'package:real_time_chat_app/features/home/presentation/function/user_item_button_status.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/send_friend_request_cubit/send_friend_request_cubit.dart';

class SendFriendRequestBlocBuilder extends StatelessWidget {
  const SendFriendRequestBlocBuilder({
    super.key,
    required this.friendRequestEntity,
    required this.userEntity,
  });
  final FriendRequestEntity friendRequestEntity;
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendFriendRequestCubit, UserRelationshipStatus>(
      listener: (context, state) {
        switch (state) {
          case UserRelationshipStatus.none:
            return showTopOverlayMessage(
              context,
              message: "cancel Request Sent to:${userEntity.displayName}",
            );
          case UserRelationshipStatus.friendRequestSent:
            return showTopOverlayMessage(
              context,
              message:
                  "Success, Friend Request Sent to   : ${userEntity.displayName}",
            );

          case UserRelationshipStatus.friendRequestReceived:
          case UserRelationshipStatus.friends:
          case UserRelationshipStatus.blocked:
        }
      },
      builder: (context, state) {
        switch (state) {
          case UserRelationshipStatus.none:
            return userItemButtonStatus(
              onTap: () {
                context.read<SendFriendRequestCubit>().sendRequest(
                  friendRequestEntity: friendRequestEntity,
                );
              },
              relationshipStatus: UserRelationshipStatus.none,
            );

          case UserRelationshipStatus.friendRequestSent:
            return userItemButtonStatus(
              onTap: () {
                context.read<SendFriendRequestCubit>().cancelFriend(
                  requestId: getUserData().uId,
                );
              },
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
