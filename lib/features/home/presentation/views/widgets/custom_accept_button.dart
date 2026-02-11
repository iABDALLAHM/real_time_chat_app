import 'package:flutter/material.dart';

class CustomAcceptButton extends StatelessWidget {
  const CustomAcceptButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      label: Text("Accept", style: TextStyle(fontSize: 10)),
      icon: Icon(Icons.check),
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Colors.green),
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }
}