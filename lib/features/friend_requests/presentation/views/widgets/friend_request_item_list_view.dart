import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/respond_to_friend_request_cubit/respond_to_friend_request_cubit.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/friend_request_item.dart';

class FriendRequestItemListView extends StatelessWidget {
  const FriendRequestItemListView({
    super.key,
    required this.friendRequestEntity,
  });
  final List<FriendRequestEntity> friendRequestEntity;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendRequestEntity.length,
      itemBuilder: (context, index) {
        return FriendRequestItem(
          onAccept: () {
            context.read<RespondToFriendRequestCubit>().respondToFriendRequest(
              friendRequestStatus: FriendRequestStatus.accepted,
              requestId: friendRequestEntity[index].id,
            );
          },
          onDecline: () {
            context.read<RespondToFriendRequestCubit>().respondToFriendRequest(
              friendRequestStatus: FriendRequestStatus.rejected,
              requestId: friendRequestEntity[index].id,
            );
          },
          // userEntity: userEntityList[index],
          friendRequestEntity: friendRequestEntity[index],
          timeText: DateTime.now().toString(),
          isReceived: true,
        );
      },
    );
  }
}
