import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(const ThemeState(
          isDarkMode: true,
          themeMode: ThemeMode.dark,
        ));

  void updateTheme(bool isDarkMode) {
    if (isDarkMode) {
      emit(state.copyWith(
        themeMode: ThemeMode.dark,
        isDarkMode: true,
      ));
    } else {
      emit(state.copyWith(
        themeMode: ThemeMode.light,
        isDarkMode: false,
      ));
    }
  }
}
