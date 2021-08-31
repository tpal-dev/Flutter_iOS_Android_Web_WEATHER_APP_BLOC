import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/theme/cubit/theme_cubit.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: context.watch<ThemeCubit>().state.isDarkMode,
      inactiveTrackColor: Colors.grey,
      onChanged: (value) => context.read<ThemeCubit>().updateTheme(value),
    );
  }
}
