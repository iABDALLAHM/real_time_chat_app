import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/chats_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/chat_cubit/get_or_create_chat_state.dart';

class GetOrCreateChatCubit extends Cubit<GetOrCreateChatStates> {
  GetOrCreateChatCubit({required this.chatsRepo})
    : super(InitialGetOrCreateChatState());
  final ChatsRepo chatsRepo;

  void getOrCreateChat({required String user1Id, required String user2Id}) {
    emit(LoadingGetOrCreateChatState());
    var result = chatsRepo.createOrGetChat(user1Id: user1Id, user2Id: user2Id);
    result.toString();
    emit(SuccessGetOrCreateChatState());
  }
}
