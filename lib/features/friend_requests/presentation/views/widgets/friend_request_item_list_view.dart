import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_request_with_user.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/core/functions/get_month.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/respond_to_friend_request_cubit/respond_to_friend_request_cubit.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/friend_request_item.dart';

class FriendRequestItemListView extends StatelessWidget {
  const FriendRequestItemListView({
    super.key,
    required this.friendRequestWithUser,
  });
  final List<FriendRequestWithUser> friendRequestWithUser;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendRequestWithUser.length,
      itemBuilder: (context, index) {
        return FriendRequestItem(
          onAccept: () {
            context.read<RespondToFriendRequestCubit>().respondToFriendRequest(
              friendRequestStatus: FriendRequestStatus.accepted,
              requestId: friendRequestWithUser[index].friendRequestEntity.id,
            );
          },
          onDecline: () {
            context.read<RespondToFriendRequestCubit>().respondToFriendRequest(
              friendRequestStatus: FriendRequestStatus.rejected,
              requestId: friendRequestWithUser[index].friendRequestEntity.id,
            );
          },
          friendRequestWithUser: friendRequestWithUser[index],
          timeText:
              "${friendRequestWithUser[index].friendRequestEntity.createdAt.day.toString()} ${getMonth(month: friendRequestWithUser[index].friendRequestEntity.createdAt.month).toString()}",
          isReceived: true,
        );
      },
    );
  }
}
