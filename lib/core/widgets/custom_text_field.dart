import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.onSaved,
    required this.prefixIcon,
    this.helperText,
    this.controller,
    this.isEnabled = true,
  });
  final String labelText, hintText;
  final Function(String?)? onSaved;
  final Icon prefixIcon;
  final String? helperText;
  final TextEditingController? controller;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      controller: controller,
      onSaved: onSaved,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        helperText: helperText,
        errorStyle: TextStyle(fontSize: 0),
        labelText: labelText,
        prefixIcon: prefixIcon,
        hintText: hintText,
      ),
    );
  }
}