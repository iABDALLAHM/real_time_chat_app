import 'package:get_it/get_it.dart';
import 'package:real_time_chat_app/core/services/auth_service.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/services/firebase_auth_service.dart';
import 'package:real_time_chat_app/core/services/firestore_service.dart';
import 'package:real_time_chat_app/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/home/data/repos/main_repo_implementation.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/profile/data/repos/profile_repo_implementation.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<AuthService>(FirebaseAuthService());
  getIt.registerSingleton<DataBaseService>(FirestoreService());
  getIt.registerSingleton<MainRepo>(
    MainRepoImplementation(dataBaseService: getIt<DataBaseService>()),
  );
  getIt.registerSingleton<ProfileRepo>(
    ProfileRepoImplementation(
      authService: getIt<AuthService>(),
      dataBaseService: getIt<DataBaseService>(),
    ),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplementation(
      authService: getIt<AuthService>(),
      dataBaseService: getIt<DataBaseService>(),
    ),
  );
}
