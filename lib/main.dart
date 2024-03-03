import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/feature/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc_demo/feature/weather/repository/repository.dart';
import 'package:flutter_bloc_demo/feature/weather/repository/repository_provider.dart';
import 'package:flutter_bloc_demo/feature/weather/screens/home_screen.dart';
import 'package:flutter_bloc_demo/rest_client/api_key.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => RepoProvider(wf: WeatherFactory(apiKey)),
      child: BlocProvider(
        create: (_) => WeatherBloc(RepoProvider(wf: WeatherFactory(apiKey))),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: ThemeData.dark(),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
