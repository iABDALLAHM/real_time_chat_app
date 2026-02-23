import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/chat/presentation/manager/send_message_cubit/send_message_cubit.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class ChatViewBlocProvider extends StatelessWidget {
  const ChatViewBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendMessageCubit(mainRepo: getIt.get<MainRepo>()),
      child: child,
    );
  }
}
