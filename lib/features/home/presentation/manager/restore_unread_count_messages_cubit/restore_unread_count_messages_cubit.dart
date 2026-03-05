import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/chats_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/restore_unread_count_messages_cubit/restore_unread_count_messages_state.dart';

class RestoreUnReadCountMessagesCubit
    extends Cubit<RestoreUnReadCountMessagesStates> {
  RestoreUnReadCountMessagesCubit({required this.chatsRepo})
    : super(InitialRestoreUnReadCountMessagesState());

  final ChatsRepo chatsRepo;

  void restoreunReadCount({
    required String userId,
    required String chatId,
  }) async {
    emit(LoadingRestoreUnReadCountMessagesState());
    var result = await chatsRepo.restoreunReadCount(
      chatId: chatId,
      userId: userId,
    );
    result.fold(
      (L) {
        emit(FailureRestoreUnReadCountMessagesState());
      },
      (R) {
        emit(SuccessRestoreUnReadCountMessagesState());
      },
    );
  }
}
