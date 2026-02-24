import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/features/home/presentation/function/build_friends_body_app_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_my_friends_stream_cubit.dart/get_my_friends_stream_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_my_friends_stream_cubit.dart/get_my_friends_stream_states.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/empty_search_widget.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/friends_chat_list_view.dart';

class FriendsBody extends StatefulWidget {
  const FriendsBody({super.key});
  static const String routeName = "friends";

  @override
  State<FriendsBody> createState() => _FriendsBodyState();
}

class _FriendsBodyState extends State<FriendsBody> {
  @override
  void initState() {
    context.read<GetMyFriendsStreamCubit>().getMyFriends(
      userId: getUserData().uId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildFriendsBodyAppBar(context),
      body: Column(
        children: [
          CustomSearchBar(hintText: "Search Friends"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  BlocBuilder<
                    GetMyFriendsStreamCubit,
                    GetMyFriendsStreamStates
                  >(
                    builder: (context, state) {
                      if (state is SuccessGetMyFriendsStreamState) {
                        return FriendsChatListView(
                          friendShipWithUserEntityList:
                              state.friendShipWithUserList,
                        );
                      }
                      return EmptySearchWidget();
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
