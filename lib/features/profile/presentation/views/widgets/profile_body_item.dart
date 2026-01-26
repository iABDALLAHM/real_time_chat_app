import 'package:flutter/material.dart';

class ProfileBodyItem extends StatelessWidget {
  const ProfileBodyItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  final String text;
  final Icon icon;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios),
      leading: icon,
      onTap: onPressed,
    );
  }
}