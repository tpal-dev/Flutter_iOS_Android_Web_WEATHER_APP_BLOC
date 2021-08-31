import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/router/app_router.dart';
import 'package:weather_app/features/weather/business_logic/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository.dart';
import 'package:weather_app/theme/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(
            weatherRepository: WeatherRepositoryOpenWeatherMapImpl(),
          ),
        ),
      ],
      child: MyAppView(appRouter: AppRouter()),
    );
  }
}

class MyAppView extends StatelessWidget {
  static const String _title = 'BloC Weather App';
  final AppRouter appRouter;
  const MyAppView({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          return MaterialApp(
            onGenerateRoute: appRouter.onGenerateRoute,
            title: _title,
            themeMode: ThemeMode.system,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
          );
        },
      );
}
