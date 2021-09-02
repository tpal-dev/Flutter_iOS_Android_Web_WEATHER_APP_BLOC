import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/business_logic/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/data/models/weather.dart';
import 'package:weather_app/features/weather/presentation/widgets/change_theme_button_widget.dart';
import 'package:weather_app/theme/cubit/theme_cubit.dart';
import 'package:weather_app/theme/theme.dart';
// TODO: bloc to cubit change: delete bloc import
// import 'package:weather_app/features/weather/business_logic/cubit/weather_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String _title = 'BloC Weather App';

  @override
  Widget build(BuildContext context) {
    final switchText =
        (context.watch<ThemeCubit>().state) ? 'DarkTheme' : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              child: Column(
                children: [
                  const Flexible(flex: 3, child: ChangeThemeButtonWidget()),
                  const Flexible(child: SizedBox(height: 5.0)),
                  Flexible(flex: 2, child: Text(switchText)),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.gps_fixed),
        onPressed: () =>
            context.read<WeatherBloc>().add(const GetWeatherForLocation()),
      ),
      body: Stack(
        children: [
          const WeatherBackground(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            // TODO: bloc to cubit change: <WeatherCubit, WeatherState>
            child: BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is WeatherFetchFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return buildInitialInput();
                } else if (state is WeatherFetchInProgress) {
                  return buildLoading();
                } else if (state is WeatherFetchSuccess) {
                  return buildColumnWithData(state.weather);
                } else {
                  // (state is WeatherError)
                  return buildInitialInput();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInitialInput() {
    return const Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.city,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '${weather.temp.toStringAsFixed(1)} °C',
          style: const TextStyle(fontSize: 80),
        ),
        const CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textField = '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onChanged: (value) => textField = value,
        onSubmitted: (value) => _submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: GestureDetector(
            onTap: () => _submitCityName(context, textField),
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  void _submitCityName(BuildContext context, String cityName) {
    // TODO: bloc to cubit change:
    // context.read<WeatherCubit>().getWeatherForCity(cityName);
    context.read<WeatherBloc>().add(GetWeatherForCity(cityName));
  }
}
