
import 'package:flutter/material.dart';

class LoginRichText extends StatelessWidget {
  const LoginRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigator.of(context).pushNamed("routeName")
      },
      child: Text("Forgot Password?"),
    );
  }
}
