import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/forget_password_view.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/login_view.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/register_view.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/chat_view.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/friend_request_view.dart';
import 'package:real_time_chat_app/features/home/presentation/views/main_view.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/change_password_view.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/delete_account_view.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/profile_view.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/signout_view.dart';
import 'package:real_time_chat_app/features/splash/presentation/views/splash_view.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => LoginView());
    case RegisterView.routeName:
      return MaterialPageRoute(builder: (context) => RegisterView());
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(builder: (context) => ForgetPasswordView());
    case ProfileView.routeName:
      return MaterialPageRoute(builder: (context) => ProfileView());
    case ChangePasswordView.routeName:
      return MaterialPageRoute(builder: (context) => ChangePasswordView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => MainView());
    case FriendRequestView.routeName:
      return MaterialPageRoute(builder: (context) => FriendRequestView());
    case SignoutView.routeName:
      return MaterialPageRoute(builder: (context) => SignoutView());
    case DeleteAccountView.routeName:
      return MaterialPageRoute(builder: (context) => DeleteAccountView());
    case ChatView.routeName:
      return MaterialPageRoute(
        builder: (context) {
          final user = settings.arguments;
          return ChatView(userEntity: user as UserEntity);
        },
      );
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
