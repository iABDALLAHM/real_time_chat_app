import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_friend_request_stream_cubit/get_friend_request_stream_cubit.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_friend_request_stream_cubit/get_friend_request_stream_state.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/friend_request_item_list_view.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/recevied_empty_state_widget.dart';

class ReceviedRequestTap extends StatelessWidget {
  const ReceviedRequestTap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetFriendRequestStreamCubit,
      GetFriendRequestStreamStates
    >(
      builder: (context, state) {
        if (state is SuccessGetFriendRequestStreamState) {
          return FriendRequestItemListView(
            // userEntityList: [],
            friendRequestEntity: state.friendRequestList,
          );
        } else {
          return ReceviedEmptyStateWidget();
        }
      },
    );
  }
}
