import 'package:flutter/material.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "":
      return MaterialPageRoute(builder: (context) => Placeholder());
    default:
      return MaterialPageRoute(builder: (context) => Placeholder());
  }
}
