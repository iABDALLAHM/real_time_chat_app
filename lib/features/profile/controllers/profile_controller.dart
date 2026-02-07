import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  bool isEditing = false;
  void toggleEdit() {
    isEditing = !isEditing;
    notifyListeners();
  }
}
