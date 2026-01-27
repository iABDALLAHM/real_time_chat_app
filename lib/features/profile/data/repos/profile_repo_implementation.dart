import 'package:real_time_chat_app/core/services/auth_service.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImplementation implements ProfileRepo {
  final AuthService authService;
  final DataBaseService dataBaseService;

  ProfileRepoImplementation({
    required this.authService,
    required this.dataBaseService,
  });
  @override
  Future<void> signOut({required String userId}) async {
    await authService.signOut();
    await dataBaseService.updateUserOnlineStatus(
      userId: userId,
      isOnline: false,
    );
  }

  @override
  Future<void> deleteUser({required String userId}) async {
    await authService.deleteAccount();
    await dataBaseService.deleteData(
      path: BackendEndPoints.deleteUser,
      documentId: userId,
    );
  }
}
