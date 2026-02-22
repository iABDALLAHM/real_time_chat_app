import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/notification_cubit/notification_cubit.dart';

class NotificationViewBlocProvider extends StatelessWidget {
  const NotificationViewBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              NotificationCubit(mainRepo: getIt.get<MainRepo>()),
        ),
      ],
      child: child,
    );
  }
}
