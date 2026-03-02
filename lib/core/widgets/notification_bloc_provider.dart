import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_notifications_stream_cubit/get_notifications_stream_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/notifications_cubit/notifications_cubit.dart';

class NotificationBlocProvider extends StatelessWidget {
  const NotificationBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetNotificationsStreamCubit(mainRepo: getIt.get<MainRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              NotificationsCubit(mainRepo: getIt.get<MainRepo>()),
        ),
      ],
      child: child,
    );
  }
}