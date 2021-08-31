import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/pages/home_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return null;
    }
  }
}
