import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/chat/presentation/manager/get_messages_stream_cubit/get_messages_stream_state.dart';
import 'package:real_time_chat_app/core/repos/messages_repo.dart';

class GetMessagesStreamCubit extends Cubit<GetMessagesStreamStates> {
  GetMessagesStreamCubit({required this.messagesRepo})
    : super(InitialGetMessagesStreamState());
  final MessagesRepo messagesRepo;
  StreamSubscription? _streamSubscription;

  void getMessages({required String user1Id, required String user2Id}) {
    emit(LoadingGetMessagesStreamState());
    _streamSubscription = messagesRepo
        .getMessagesStream(user1Id: user1Id, user2Id: user2Id)
        .listen((messages) {
          if (messages.isEmpty) {
            emit(EmptyMessagesStreamState());
          } else {
            emit(SuccessGetMessagesStreamState(messagesList: messages));
          }
        });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
