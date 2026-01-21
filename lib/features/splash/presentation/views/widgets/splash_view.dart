import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static const String routeName = "SplashView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBody());
  }
}
