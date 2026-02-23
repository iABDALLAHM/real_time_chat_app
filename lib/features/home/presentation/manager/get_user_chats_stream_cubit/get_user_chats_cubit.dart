import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_user_chats_stream_cubit/get_user_chats_state.dart';

class GetUserChatsCubit extends Cubit<GetUserChatsStates> {
  GetUserChatsCubit({required this.mainRepo})
    : super(InitialGetUserChatsState());

  final MainRepo mainRepo;
  StreamSubscription? _streamSubscription;
  List<ChatEntity> chats = [];
  void getUserChats({required String userId}) {
    emit(LoadingGetUserChatsState());
    _streamSubscription = mainRepo.getUserChatsStream(userId: userId).listen((
      result,
    ) {
      if (result.isEmpty) {
        emit(EmptyGetUserChatsState());
      } else {
        chats = result;
        emit(SuccessGetUserChatsState(chats: result));
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
