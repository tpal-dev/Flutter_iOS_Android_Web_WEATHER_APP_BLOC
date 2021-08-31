import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/theme/theme_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: context.watch<ThemeProvider>().isDarkMode,
      inactiveTrackColor: Colors.grey,
      onChanged: (value) => context.read<ThemeProvider>().toggleTheme(value),
    );
  }
}
