import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/restore_unread_count_messages_cubit/restore_unread_count_messages_state.dart';

class RestoreUnReadCountMessagesCubit
    extends Cubit<RestoreUnReadCountMessagesStates> {
  RestoreUnReadCountMessagesCubit({required this.mainRepo})
    : super(InitialRestoreUnReadCountMessagesState());

  final MainRepo mainRepo;

  void restoreunReadCount({required String userId, required String chatId}) {
    emit(LoadingRestoreUnReadCountMessagesState());
    mainRepo.restoreunReadCount(chatId: chatId, userId: userId);
    emit(SuccessRestoreUnReadCountMessagesState());
  }
}
