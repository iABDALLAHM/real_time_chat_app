import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_friend_request_stream_cubit/get_friend_request_stream_cubit.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class FriendRequestMultiBlocProvider extends StatelessWidget {
  const FriendRequestMultiBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetFriendRequestStreamCubit(mainRepo: getIt.get<MainRepo>()),
        ),
      ],
      child: child,
    );
  }
}
