import 'package:flutter/material.dart';

class BottomNavigationItemEntity {
  final String text;
  final IconData icon;

  BottomNavigationItemEntity({required this.text, required this.icon});
}

final List<BottomNavigationItemEntity> bottomNAvigationList = [
  BottomNavigationItemEntity(
    icon: Icons.account_circle_outlined,
    text: "Profile",
  ),
  BottomNavigationItemEntity(icon: Icons.person_search, text: "Find Friends"),
  BottomNavigationItemEntity(icon: Icons.group_outlined, text: "Friends"),
  BottomNavigationItemEntity(icon: Icons.chat, text: "Chats"),
];
