import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/on_generate_route.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/core/services/shared_prefs_service.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_notifications_stream_cubit/get_notifications_stream_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:real_time_chat_app/features/splash/presentation/views/splash_view.dart';
import 'package:real_time_chat_app/firebase_options.dart';
import 'package:real_time_chat_app/simple_bloc_observer.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Firebase.initializeApp();
  setupGetIt();
  SharedPrefsService.initSharedPrefs();
  runApp(const RealTimeChat());
}

class RealTimeChat extends StatelessWidget {
  const RealTimeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetNotificationsStreamCubit(mainRepo: getIt.get<MainRepo>()),
        ),
     BlocProvider(
          create: (context) =>
              NotificationsCubit(mainRepo: getIt.get<MainRepo>()),
        ),
      ],
      child: MaterialApp(
        initialRoute: SplashView.routeName,
        onGenerateRoute: onGenerateRoute,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        title: "Chat App",
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
