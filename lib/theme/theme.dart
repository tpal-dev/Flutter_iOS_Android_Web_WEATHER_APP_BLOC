import 'package:flutter/material.dart';

class MyThemes {
  static final IconThemeData _iconThemeDark =
      IconThemeData(color: Colors.purple.shade200, opacity: 0.8);
  static const IconThemeData _iconThemeLight =
      IconThemeData(color: Colors.black, opacity: 0.8);

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple,
      iconTheme: _iconThemeDark,
    ),
    iconTheme: _iconThemeDark,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blue,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
      iconTheme: _iconThemeLight,
    ),
    iconTheme: _iconThemeLight,
  );
}

class WeatherBackground extends StatelessWidget {
  const WeatherBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.25, 0.75, 0.90, 1.0],
          colors: [
            color,
            color.brighten(10),
            color.brighten(33),
            color.brighten(50),
          ],
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}
