import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/friend_request_item_list_view.dart';

class ReceviedRequestTap extends StatelessWidget {
  const ReceviedRequestTap({super.key});

  @override
  Widget build(BuildContext context) {
    return FriendRequestItemListView(
      userEntityList: [],
      friendRequestEntity: [],
    );
  }
}
