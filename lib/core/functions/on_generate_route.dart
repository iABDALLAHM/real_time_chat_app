import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/login_view.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/register_view.dart';
import 'package:real_time_chat_app/features/splash/presentation/views/splash_view.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => LoginView());
    case RegisterView.routeName:
      return MaterialPageRoute(builder: (context) => RegisterView());
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
