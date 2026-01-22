import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/splash/presentation/views/splash_view.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => SplashView());
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
