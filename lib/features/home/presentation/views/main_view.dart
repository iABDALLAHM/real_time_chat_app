import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/chat_body.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/find_people_body.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/friends_body.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/main_view_multi_bloc_provider.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const String routeName = "Main";

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MainViewMultiBlocProvider(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          onChange: (value) {
            currentIndex = value;
            setState(() {});
          },
        ),
        body: IndexedStack(
          index: currentIndex,
          children: [
            ProfileView(),
            FindPeopleBody(),
            FriendsBody(),
            ChatBody(),
          ],
        ),
      ),
    );
  }
}
