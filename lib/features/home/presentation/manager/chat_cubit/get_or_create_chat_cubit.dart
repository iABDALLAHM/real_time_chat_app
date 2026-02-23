import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/chat_cubit/get_or_create_chat_state.dart';

class GetOrCreateChatCubit extends Cubit<GetOrCreateChatStates> {
  GetOrCreateChatCubit({required this.mainRepo})
    : super(InitialGetOrCreateChatState());
  final MainRepo mainRepo;

  void getOrCreateChat({required String user1Id, required String user2Id}) {
    emit(LoadingGetOrCreateChatState());
    var result = mainRepo.createOrGetChat(user1Id: user1Id, user2Id: user2Id);
    emit(SuccessGetOrCreateChatState());
  }
}
