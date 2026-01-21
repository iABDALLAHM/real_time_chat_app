import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/functions/on_generate_route.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const RealTimeChat());
}

class RealTimeChat extends StatelessWidget {
  const RealTimeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: ,
      onGenerateRoute: onGenerateRoute,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      title: "Chat App",
      debugShowCheckedModeBanner: false,
      home: Placeholder(),
    );
  }
}
