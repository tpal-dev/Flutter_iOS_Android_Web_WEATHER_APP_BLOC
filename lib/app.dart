import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/router/app_router.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository.dart';
import 'package:weather_app/theme/theme_provider.dart';
import 'features/weather/business_logic/bloc/weather_bloc.dart';
// TODO: bloc to cubit change: delete bloc import
// import 'package:weather_app/features/weather/business_logic/cubit/weather_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // TODO: bloc to cubit change:
        // BlocProvider<WeatherCubit>(
        //   create: (context) => WeatherCubit(
        //     weatherRepository: WeatherRepositoryOpenWeatherMapImpl(),
        //   ),
        // ),
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(
            WeatherRepositoryOpenWeatherMapImpl(),
          ),
        ),
      ],
      child: MyAppView(appRouter: AppRouter()),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key, required this.appRouter}) : super(key: key);
  static const String _title = 'BloC Weather App';
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = context.watch<ThemeProvider>();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.onGenerateRoute,
            title: _title,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
          );
        },
      );
}
