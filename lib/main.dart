import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/on_generate_route.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/core/services/shared_prefs_service.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/notification_bloc_provider.dart';
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
    return NotificationBlocProvider(
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
