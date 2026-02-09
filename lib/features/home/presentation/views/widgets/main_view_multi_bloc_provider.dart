import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_stream_cubit.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_all_users_stream_cubit/get_all_users_stream_cubit.dart';
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
              UserStreamCubit(profileRepo: getIt.get<ProfileRepo>())
                ..getUserStream(userId: getUserData().uId),
        ),
        BlocProvider(
          create: (context) =>
              GetAllUsersStreamCubit(mainRepo: getIt.get<MainRepo>()),
        ),
      ],
      child: child,
    );
  }
}
