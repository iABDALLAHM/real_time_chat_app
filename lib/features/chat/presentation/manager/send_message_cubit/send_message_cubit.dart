import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/features/chat/presentation/manager/send_message_cubit/send_message_state.dart';
import 'package:real_time_chat_app/features/home/domain/repos/messages_repo.dart';

class SendMessageCubit extends Cubit<SendMessageStates> {
  SendMessageCubit({required this.messagesRepo}) : super(InitialSendMessageState());
  final MessagesRepo messagesRepo;

  void sendMessage({required MessageEntity message}) {
    emit(LoadingSendMessageState());
    messagesRepo.sendMessage(message: message);
    emit(SuccessSendMessageState());
  }
}
