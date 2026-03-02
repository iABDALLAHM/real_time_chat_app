import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_data_stream_cubit.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/home/domain/repos/friend_ship_repo.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/friend_ship_cubit/friend_ship_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_all_users_stream_cubit/get_all_users_stream_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/friend_request_cubit/friend_request_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_my_friends_stream_cubit.dart/get_my_friends_stream_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/chat_cubit/get_or_create_chat_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_user_chats_stream_cubit/get_user_chats_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/restore_unread_count_messages_cubit/restore_unread_count_messages_cubit.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';

class MainViewMultiBlocProvider extends StatelessWidget {
  const MainViewMultiBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserDataStreamCubit(profileRepo: getIt.get<ProfileRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              GetAllUsersStreamCubit(mainRepo: getIt.get<MainRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              FriendRequestCubit(mainRepo: getIt.get<MainRepo>()),
        ),
        BlocProvider(
          create: (context) => GetMyFriendsStreamCubit(
            friendShipRepo: getIt.get<FriendShipRepo>(),
            authRepo: getIt.get<AuthRepo>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              FriendShipCubit(friendShipRepo: getIt.get<FriendShipRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              GetOrCreateChatCubit(mainRepo: getIt.get<MainRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              RestoreUnReadCountMessagesCubit(mainRepo: getIt.get<MainRepo>()),
        ),
        BlocProvider(
          create: (context) => GetUserChatsCubit(
            mainRepo: getIt.get<MainRepo>(),
            authRepo: getIt.get<AuthRepo>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
