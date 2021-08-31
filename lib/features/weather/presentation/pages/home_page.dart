import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/business_logic/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/data/models/weather.dart';
import 'package:weather_app/theme/theme_provider.dart';

class HomePage extends StatelessWidget {
  static const String _title = 'BloC Weather App';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Stack(
        children: [
          const WeatherBackground(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: BlocConsumer<WeatherCubit, WeatherState>(
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
          // Display the temperature with 1 decimal place
          "${weather.temp.toStringAsFixed(1)} °C",
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => _submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  void _submitCityName(BuildContext context, String cityName) {
    context.read<WeatherCubit>().getWeatherForCity(cityName);
  }
}
