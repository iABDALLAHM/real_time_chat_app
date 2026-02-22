import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/accepted_friend_ship_state.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/pending_friend_ship_state.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/rejected_friend_ship_state.dart';

class FriendRequestStatusWidget extends StatelessWidget {
  const FriendRequestStatusWidget({super.key, required this.status});
  final FriendRequestStatus status;
  @override
  Widget build(BuildContext context) {
    switch (status) {
      case FriendRequestStatus.pending:
        return PendingFriendShipState();
      case FriendRequestStatus.accepted:
        return AcceptedFriendShipState();
      case FriendRequestStatus.rejected:
        return RejectedFriendShipState();
    }
  }
}
