import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/user_with_chat_entity.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_user_chats_stream_cubit/get_user_chats_state.dart';

class GetUserChatsCubit extends Cubit<GetUserChatsStates> {
  GetUserChatsCubit({required this.mainRepo, required this.authRepo})
    : super(InitialGetUserChatsState());

  final MainRepo mainRepo;
  final AuthRepo authRepo;

  StreamSubscription? _streamSubscription;
  List<ChatEntity> chats = [];
  void getUserChats({required String userId}) {
    emit(LoadingGetUserChatsState());
    _streamSubscription = mainRepo.getUserChatsStream(userId: userId).listen((
      result,
    ) async {
      List<UserWithChatEntity> userWithChatList = [];

      if (result.isEmpty) {
        emit(EmptyGetUserChatsState());
      } else {
        chats = result;
        for (var user in result) {
          var otherUserId = user.participants.firstWhere((id) => id != userId);
          var userData = await authRepo.getUserData(uId: otherUserId);
          userWithChatList.add(
            UserWithChatEntity(chatEntity: user, userEntity: userData),
          );
        }
        emit(SuccessGetUserChatsState(userWithChatList: userWithChatList));
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
