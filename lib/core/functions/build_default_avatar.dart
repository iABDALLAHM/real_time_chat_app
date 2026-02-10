import 'package:flutter/material.dart';

Text buildDefaultAvatar({required String name}) {
    return Text(
      name.isNotEmpty ? name[0].toUpperCase() : "?",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }