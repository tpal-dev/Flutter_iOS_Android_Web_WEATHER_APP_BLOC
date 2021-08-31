import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
