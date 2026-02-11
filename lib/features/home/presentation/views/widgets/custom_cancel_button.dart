import 'package:flutter/material.dart';

class CustomCancelButton extends StatelessWidget {
  const CustomCancelButton({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      label: Text("Cancel", style: TextStyle(fontSize: 10)),
      icon: Icon(Icons.cancel_outlined),
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Colors.redAccent),
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        minimumSize: Size(0, 24),
      ),
    );
  }
}
