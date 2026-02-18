import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_sent_friend_request_stream_cubit/get_sent_friend_request_stream_cubit.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_sent_friend_request_stream_cubit/get_sent_friend_request_stream_state.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/friend_sent_item_list_view.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/sent_request_empty_state_widget.dart';

class SentRequestTap extends StatelessWidget {
  const SentRequestTap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetSentFriendRequestStreamCubit,
      GetSentFriendRequestStreamStates
    >(
      builder: (context, state) {
        if (state is SuccessGetSentFriendRequestStreamState) {
          return FriendSentItemListView(
            friendRequestWithUser: state.friendRequestWithUserList,
          );
        } else {
          return SentRequestEmptyStateWidget();
        }
      },
    );
  }
}
