import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/chat/presentation/manager/send_message_cubit/send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageStates> {
  SendMessageCubit({required this.mainRepo}) : super(InitialSendMessageState());
  final MainRepo mainRepo;

  void sendMessage({required MessageEntity message}) {
    emit(LoadingSendMessageState());
    mainRepo.sendMessage(message: message);
    emit(SuccessSendMessageState());
  }
}
